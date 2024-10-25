require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

module.exports = {
  solidity: {
    version: "0.8.27",
    settings: {
      optimizer: {
        enabled: true,  // Enable the optimizer
        runs: 200,  // Number of optimizer runs
      },
      evmVersion: "paris"  // EVM version to target
    }
  },
  networks: {
    bscTestnet: {
      url: `https://go.getblock.io/${process.env.GETBLOCK_TESTNET_API_KEY}`,  // Uses the GETBLOCK_TESTNET_API_key from the .env file
      accounts: [`0x${process.env.PRIVATE_KEY}`],  // Use your wallet's private key
    },
    bscMainnet: {
      url: `https://go.getblock.io/${process.env.GETBLOCK_MAINNET_API_KEY}`,  // Uses the GETBLOCK_MAINNET_API_key from the .env file
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
  etherscan: {
    apiKey: process.env.BSCSCAN_API_KEY,  // API key for BSCScan verification
  },
  sourcify: {
    enabled: true,  // Enable Sourcify verification
  },
};
