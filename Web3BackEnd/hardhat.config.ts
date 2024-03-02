import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
require("dotenv").config({ path: ".env" });

const INFURA_KEY = process.env.INFURA_KEY;
const PRIVATE_KEY1 = process.env.PRIVATEKEY;
const PRIVATE_KEY2 = process.env.PRIVATEKEY2;
const API_KEY = process.env.API_KEY;

module.exports = {
  solidity: "0.8.4",
  settings: {
    optimizer: {
      enabled: true,
      runs: 500,
    },
  },
  etherscan: {
    apiKey: API_KEY
  },
  networks: {
    hardhat: {},
    sepolia: {
      url: `https://sepolia.infura.io/v3/${INFURA_KEY}`,
      accounts: [PRIVATE_KEY1,PRIVATE_KEY2]
    }
  },
  blockGasLimit: 200000000000,
  gasPrice: 10000000000,
};
