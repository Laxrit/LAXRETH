// Import the necessary Hardhat libraries
const { ethers } = require("hardhat");

async function main() {
    // Get the signer (deployer's wallet)
    const [deployer] = await ethers.getSigners();

    console.log("Deploying contracts with the account:", deployer.address);

    // The address of the old contract (you'll need to set this manually)
    const oldTokenAddress = "0x8887ca5F4BB4154c21b58EE9De3C65817049FB46";  // Replace this with the actual old token contract address

    // Deploy the NewLAXRETH contract with the old token address
    const NewLAXRETH = await ethers.getContractFactory("NewLAXRETH");
    const newLAXRETH = await NewLAXRETH.deploy(oldTokenAddress);

    console.log("NewLAXRETH deployed to:", newLAXRETH.address);
}

// Run the script
main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
