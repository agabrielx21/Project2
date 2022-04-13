//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "openzeppelin-solidity/contracts/utils/math/SafeMath.sol";


contract Staking {

    using SafeERC20 for IERC20;
    using SafeMath for uint256;
    IERC20 public rewardsToken;
    IERC20 public stakingToken;
    mapping(address => uint256) public balances;
    mapping(address => uint) public userRewardPerTokenPaid;
    mapping(address => uint) public rewards;
    uint public rewardRate = 100;
    uint public lastUpdateTime;
    uint public rewardPerTokenStored;
    uint private Supply;
    
     constructor(address _stakingToken, address _rewardsToken) {
        stakingToken = IERC20(_stakingToken);
        rewardsToken = IERC20(_rewardsToken);
    }
    
    event tokensStaked(
        address from,
        uint256 amount);

        function rewardPerToken() public view returns (uint) {
            if (Supply == 0) return rewardPerTokenStored;
            return  rewardPerTokenStored + (((block.timestamp - lastUpdateTime) * rewardRate * 1e18) / Supply);
    }

        function earned(address account) public view returns (uint) {
            return ((balances[account] * (rewardPerToken() - userRewardPerTokenPaid[account])) / 1e18) + rewards[account];
        }
    
        function stakeTokens(IERC20 token, uint256 amount) external updateReward(msg.sender) {
            
            require(token == stakingToken, "You are trying to stake a invalid token !");
            require(amount <= token.balanceOf(msg.sender), "Not enough tokens to stake !");
            token.safeTransferFrom(msg.sender, address(this), amount);
            balances[msg.sender] = balances[msg.sender].add(amount);
            emit tokensStaked(msg.sender, amount); 
            }


        function withdraw(uint256 amount) external updateReward(msg.sender) {

            require(amount <= balances[msg.sender], "You are trying to withdraw more than you have!");
            if (amount > 0) {
            Supply = Supply.sub(amount);
            balances[msg.sender] = balances[msg.sender].sub(amount);
            stakingToken.transfer(msg.sender, amount);}
        }

         function getReward() external updateReward(msg.sender) {
            uint reward = rewards[msg.sender];
            rewards[msg.sender] = 0;
            rewardsToken.transfer(msg.sender, reward);
    }

        modifier updateReward(address account) {
            rewardPerTokenStored = rewardPerToken();
            lastUpdateTime = block.timestamp;
            rewards[account] = earned(account);
            userRewardPerTokenPaid[account] = rewardPerTokenStored;
        _;
    }
    }