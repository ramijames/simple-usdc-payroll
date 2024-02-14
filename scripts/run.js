const hre = require("hardhat");

async function main() {
  // Get wallet address
  const [owner] = await hre.ethers.getSigners();

  // Define the official USDC contract address
  usdcTokenAddress = "0x07865c6E87B9F70255377e024ace6630C1Eaa37F";

  const contract = await hre.ethers.deployContract("Payroll", [
    usdcTokenAddress,
  ]);

  // console.log(contract);

  await contract.waitForDeployment();
  console.log("USDC Balance contract deployed to: ", contract.target, "\n");

  // // Get wallet's USDC balance
  // let usdcBalance = await contract.connect(owner).getUsdcBalance();
  // console.log(`USDC Balance of ${owner.address}: `, usdcBalance);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.log(error);
    process.exit(1);
  });
