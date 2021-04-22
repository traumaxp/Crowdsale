pragma solidity ^0.5.0;

import './MyToken.sol';
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/TimedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/PostDeliveryCrowdsale.sol";


contract MyCrowdsale is Crowdsale, TimedCrowdsale, PostDeliveryCrowdsale {
  constructor(
      uint256 rate,    // rate in TKNbits
      address payable wallet,
      MyToken token,
      uint256 openingTime,     // opening time in unix epoch seconds https://www.epochconverter.com/
      uint256 closingTime
  )
      Crowdsale(rate, wallet, token)
      TimedCrowdsale(openingTime, closingTime)
      PostDeliveryCrowdsale()
      public
  {

  }

}