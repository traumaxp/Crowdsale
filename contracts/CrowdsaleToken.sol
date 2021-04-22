pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "./Token.sol";

contract TokenSale is Crowdsale, GLDToken {
    constructor(
    uint256 _rate,
    address payable _wallet,
    ERC20 _token
  )
    Crowdsale(_rate, _wallet, _token)
    public
  {
  }
  mapping(address => uint256) public contributions;
}