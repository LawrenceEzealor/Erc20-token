import { ethers } from "hardhat";

async function main() {

  const Token = await ethers.getContractFactory("Erc2otoken");

  const token = await Token.deploy("Lawcoin", "law", 5000000000 );

  console.log(
    `Erc20token contract deployed with deployed to ${token.target}`
  );
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
