//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
contract Uniswap {
    address constant UniSwap_Router = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

    function getPathForETHtoToken() private view returns (address[] memory) {
        address[] memory path = new address[](2);
        path[0] = address(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
        path[1] = address(0xdAC17F958D2ee523a2206206994597C13D831ec7);
        return path;
        }
    function swap() external payable returns(uint[] memory) {
        uint deadline = block.timestamp;
        IUniswapV2Router02(UniSwap_Router).swapExactETHForTokens(0, getPathForETHtoToken(), msg.sender, deadline);
    }
}