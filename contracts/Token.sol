pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

contract Token is ERC20, ERC20Detailed, ERC20Mintable {
    constructor() ERC20Detailed("Gold", "GLD", 18) public {
        _mint(msg.sender, 1000);
    }
}