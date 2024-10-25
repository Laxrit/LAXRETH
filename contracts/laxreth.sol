// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract LAXRETH is ERC20, Ownable {
    uint256 public constant INITIAL_SUPPLY = 10000000 * 10 ** 18; // 10 million tokens
    uint256 public mintingAmount = 5000000 * 10 ** 18; // 5 million tokens

    constructor() ERC20("LAXRETH", "LETH") Ownable(msg.sender) {
        _mint(msg.sender, INITIAL_SUPPLY); // Mint initial tokens to the deployer
    }

    function mintTokens() external onlyOwner {
        _mint(msg.sender, mintingAmount);
    }

    function setMintingAmount(uint256 _amount) external onlyOwner {
        mintingAmount = _amount;
    }
}
