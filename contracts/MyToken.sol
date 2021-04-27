pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import 'zeppelin-solidity/contracts/token/ERC20/MintableToken.sol';



contract MyToken is ERC20, ERC20Detailed, MintableToken {
  uint public INITIAL_SUPPLY = 200000000;

  constructor(string memory _name, string memory _symbol, uint8 _decimals)
    ERC20Detailed(_name, _symbol, _decimals)
    public
  {
      _mint(msg.sender, INITIAL_SUPPLY);
  }

}