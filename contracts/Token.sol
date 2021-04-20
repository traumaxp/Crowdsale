pragma solidity ^0.5.0;

import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";


contract ICO is Crowdsale {
    constructor(
      uint rate,
      address payable wallet,
      IERC20 token
    ) Crowdsale(rate, wallet, token) public {}
}

