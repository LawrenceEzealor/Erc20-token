import { ethers } from "hardhat";

async function main() {

  const token = await ethers.deployContract("Erc2otoken", [unlockTime], {
    value: lockedAmount,
);

  await token.waitForDeployment();

  console.log(
    `Erc20token contract deployed with ${ethers.formatEther(
      lockedAmount
    )}ETH and unlock timestamp ${unlockTime} deployed to ${token.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
