// require("@nomiclabs/hardhat-waffle");

// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async (taskArgs, hre) => {
  const accounts = await hre.ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
// require('nomiclbs/hardhat-waffle');
module.exports = {
  solidity: "0.8.4",
};

require('dotenv').config();
require("@nomiclabs/hardhat-ethers");

const { API_URL, PRIVATE_KEY } = process.env;

module.exports = {
    solidity: "0.8.0",
    defaultNetwork: "hardhat",
    networks: {
        hardhat: {
          forking: {
            url: "https://eth-mainnet.alchemyapi.io/v2/anCBuMk_pw94m7QPej2FTLJzNGkbyBtd",
            blockNumber: 14489217
          }
        },
        /*rinkeby: {
            url: API_URL,
            accounts: [`${PRIVATE_KEY}`]
        }*/
    },
}