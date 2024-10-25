// Import ethers from Hardhat
const { ethers } = require("hardhat");

async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    // Deploy the contract
    const LAXRETH = await ethers.getContractFactory("LAXRETH");
    const contract = await LAXRETH.deploy();

    // Wait for the contract to be mined (ensure deployment is successful)
    await contract.deployed();

    // Log the contract address
    console.log("Contract deployed to:", contract.address);
}

main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
