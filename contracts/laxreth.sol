// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract NewLAXRETH is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 10000000 * 10 ** 6; // 10 million tokens with 6 decimals
    uint256 public mintingAmount = 1000000 * 10 ** 6; // 1 million tokens with 6 decimals
    uint8 private _customDecimals = 0; // Represent tokens as whole numbers for user-facing operations

    address public oldTokenAddress; // Address of the old token contract

    constructor(address _oldTokenAddress) ERC20("LAXRETH", "ETH") {
        require(_oldTokenAddress != address(0), "Invalid old token address");
        oldTokenAddress = _oldTokenAddress;
        _mint(msg.sender, INITIAL_SUPPLY); // Mint initial tokens to the deployer
    }

    /**
     * @dev Returns the decimals used for blockchain operations (default: 6).
     */
    function decimals() public view virtual override returns (uint8) {
        return 6;
    }

    /**
     * @dev Sets custom decimals for user-facing operations.
     * For example, setting this to 0 means users deal with whole numbers.
     */
    function setCustomDecimals(uint8 customDecimals) external onlyOwner {
        require(customDecimals <= 6, "Decimals cannot exceed blockchain precision.");
        _customDecimals = customDecimals;
    }

    /**
     * @dev Transfers tokens using whole numbers for user convenience.
     * Converts the whole number amount into smallest units for blockchain transactions.
     */
    function transferWhole(address recipient, uint256 amount) public returns (bool) {
        uint256 scaledAmount = amount * (10 ** (6 - _customDecimals));
        return transfer(recipient, scaledAmount);
    }

    /**
     * @dev Transfers tokens using whole numbers for user convenience with allowance.
     * Converts the whole number amount into smallest units for blockchain transactions.
     */
    function transferFromWhole(address sender, address recipient, uint256 amount) public returns (bool) {
        uint256 scaledAmount = amount * (10 ** (6 - _customDecimals));
        return transferFrom(sender, recipient, scaledAmount);
    }

    /**
     * @dev Issues new tokens to the owner's address. The mintingAmount is adjusted to use full precision.
     */
    function mintTokens() external onlyOwner {
        _mint(msg.sender, mintingAmount);
    }

    /**
     * @dev Sets the minting amount in smallest units (6 decimals).
     */
    function setMintingAmount(uint256 _amount) external onlyOwner {
        mintingAmount = _amount;
    }

    /**
     * @dev Overload for setting the minting amount using whole numbers.
     * Converts the whole number amount into smallest units for blockchain storage.
     */
    function setMintingAmountWhole(uint256 amount) external onlyOwner {
        mintingAmount = amount * (10 ** (6 - _customDecimals));
    }

    /**
     * @dev Migrates tokens from the old contract to the new contract.
     * Users must approve this contract to spend their old tokens before calling this function.
     */
    function migrateTokens(uint256 amount) external {
        require(amount > 0, "Amount must be greater than zero");

        uint256 scaledAmount = amount * (10 ** (6 - _customDecimals));
        require(IERC20(oldTokenAddress).transferFrom(msg.sender, address(this), scaledAmount), "Token transfer failed");

        _mint(msg.sender, amount * (10 ** (6 - _customDecimals)));
    }
}
