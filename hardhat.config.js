require('dotenv').config();
require('@nomiclabs/hardhat-ethers');
require('@nomiclabs/hardhat-etherscan');

const { API_URL, PRIVATE_KEY, ETHERSCAN_API_KEY } = process.env;

module.exports = {
  solidity: {
    compilers: [
      {
        version: "0.8.0",
      },
      {
        version: "0.6.7",
      },
    ],
  },
  
  networks: {
    localhost: {
      url: "http://127.0.0.1:7545"
    },
    
    rinkeby: {
      url: API_URL,
      accounts: [PRIVATE_KEY] // 這樣也可以
    },
  },
  
  etherscan: {
    apiKey: ETHERSCAN_API_KEY
  }
};
