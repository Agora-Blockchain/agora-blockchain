import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "@nomicfoundation/hardhat-toolbox/network-helpers";
import "@nomicfoundation/hardhat-ignition-ethers";
import 'dotenv/config'

const config: HardhatUserConfig = {
  solidity: "0.8.24",
  networks: {
    hardhat: {
      allowUnlimitedContractSize: true,
    },
    sepolia: {
      allowUnlimitedContractSize: true,
      url: process.env.RPC_URL_SEPOLIA,
      accounts: [process.env.PRIVATE_KEY!] ,
    },
    fuji: {
      allowUnlimitedContractSize: true,
      url: process.env.RPC_URL_FUJI,
      accounts: [process.env.PRIVATE_KEY!],
    },
  },
  etherscan: {
  apiKey: process.env.ETHERSCAN_KEY
}
};

export default config;
