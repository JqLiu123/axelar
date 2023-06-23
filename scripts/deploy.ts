import { ethers } from "hardhat";
async function main() {
  const TestToken = await ethers.deployContract('TestToken')
  await TestToken.waitForDeployment()
  console.log(`Test token addr: ${TestToken.target}`)
  const Bridge = await ethers.deployContract('Bridge', [
    '0xe432150cce91c13a887f7D836923d5597adD8E31',
    '0xbE406F0189A0B4cf3A05C286473D23791Dd44Cc6',
    TestToken.target
  ])
  await Bridge.waitForDeployment()
  console.log(`bridge addr: ${Bridge.target}`)
  
  await TestToken.setBridge(Bridge.target)
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
// arbitrumGoerli TestToken: 0x694B6D7BD736Fe02683A1B446e6b825D5c0EddF3
// goerli TestToken: 0xB82a423E9b4b932E56A0780e1176c576a81aE78f
// arbitrumGoerli Bridge: 0x53875abbb3f8c46086e43998a5B9058728DaE278
// goerli Bridge: 0xBa79CC899ff2acCCf2B00375Df608f738114CFA0
// arbitrum
// ethereum-2
