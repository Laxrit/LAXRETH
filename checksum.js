// Import ethers from the installed version
const { ethers } = require("ethers");

const address = "0x8887ca5F4BB4154c21b58EE9De3C65817049FB46"; // Replace with your actual contract address
try {
    const checksumAddress = ethers.getAddress(address);
    console.log("Checksum Address:", checksumAddress);
} catch (error) {
    console.error("Invalid address:", error);
}
