import { ethers } from "hardhat";

async function main() {
  const InsuranceToken = await ethers.getContractFactory("InsuranceToken");
  const [deployer] = await ethers.getSigners();

  const insuranceToken = await InsuranceToken.deploy();
  await insuranceToken.deployed();



  console.log("InsuranceToken deployed to:", insuranceToken.address);
}
// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
