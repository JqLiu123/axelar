import { ethers } from "hardhat";
import { CHAINS } from "@axelar-network/axelarjs-sdk";
const goerliBridge = '0xB2aAD844BfA11f0195c46c692c5B9b64a0988D68'
const arbitrumGoerliBridge = '0x154CC04e176c090424497EF8242e24e0E5A6701E'
async function main() {
  const TestToken = await ethers.deployContract('TestToken')
  await TestToken.waitForDeployment()
  console.log(`Test token addr: ${TestToken.target}`)
  const Bridge = await ethers.deployContract('Bridge', [
    '0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B',
    '0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6',
    TestToken.target
  ])
  await Bridge.waitForDeployment()
  console.log(`bridge addr: ${Bridge.target}`)
  await Bridge.setBridges([CHAINS.TESTNET.ETHEREUM], [goerliBridge], [true])
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// arbitrumGoerli TestToken: 0x651D8b6e182E81c8c0fd35a482af6AC7e1C952Db
// goerli TestToken: 0x01084CFAE3e521E535211223621F957b28B14411
// arbitrum
// ethereum-2
// goerli-arbitrum gasfee: 0.186368797572752798
// arbitrum-goerli gasfee: 0.000238851221722791
0.00000018703189
0.000000001556674631