import { AxelarQueryAPI, CHAINS, Environment, GasToken } from "@axelar-network/axelarjs-sdk";
async function main() {
    const sdk = new AxelarQueryAPI({
        environment: Environment.TESTNET
      });
    const fee = await sdk.estimateGasFee(
        CHAINS.TESTNET.ETHEREUM,
        CHAINS.TESTNET.ARBITRUM,
        GasToken.ETH,
        350000
        )
    console.log(`fee is ${fee}`)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

