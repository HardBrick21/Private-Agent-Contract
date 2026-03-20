const hre = require("hardhat");

async function main() {
  console.log("Deploying Private Agent Contract to Base Sepolia");
  console.log("Chain ID: 84532\n");

  const PrivateAgentContract = await hre.ethers.getContractFactory("PrivateAgentContract");
  const PrivateAgentWallet = await hre.ethers.getContractFactory("PrivateAgentWallet");
  
  console.log("Deploying PrivateAgentContract...");
  const contract = await PrivateAgentContract.deploy();
  await contract.waitForDeployment();
  
  const contractAddress = await contract.getAddress();
  console.log(`✅ PrivateAgentContract deployed to: ${contractAddress}`);
  
  console.log("\nDeploying PrivateAgentWallet...");
  const wallet = await PrivateAgentWallet.deploy();
  await wallet.waitForDeployment();
  
  const walletAddress = await wallet.getAddress();
  console.log(`✅ PrivateAgentWallet deployed to: ${walletAddress}`);
  
  console.log("\n--- Deployment Summary ---");
  console.log(`PrivateAgentContract: ${contractAddress}`);
  console.log(`PrivateAgentWallet: ${walletAddress}`);
  console.log(`Network: Base Sepolia`);
  console.log(`Explorer: https://sepolia.basescan.org/address/${contractAddress}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});