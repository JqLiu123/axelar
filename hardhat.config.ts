import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "dotenv/config"

// // set proxy
// import { ProxyAgent, setGlobalDispatcher } from "undici"
// const proxyAgent = new ProxyAgent('http://127.0.0.1:7890')
// setGlobalDispatcher(proxyAgent)

const config: HardhatUserConfig = {
  solidity: {
    version: "0.8.18",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  networks: {
    arbitrumGoerli: {
      url: "https://arbitrum-goerli.public.blastapi.io",
      accounts: [`${process.env.OWNER_PRIVATE_KEY}`]
    },
    goerli: {
      url: `https://eth-goerli.g.alchemy.com/v2/${process.env.GOERLI_RPC}`,
      accounts: [`${process.env.OWNER_PRIVATE_KEY}`]
    }
  },
  etherscan: {
    apiKey: {
      arbitrumGoerli: `${process.env.ARBITRUMGOERLI_API_KEY}`,
      goerli: `${process.env.GOERLI_API_KEY}`
    }
  }
};

export default config;
