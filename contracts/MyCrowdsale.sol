pragma solidity ^0.5.0;

import "./MyToken.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/TokenTimelock.sol";


contract MyCrowdsale is Crowdsale, TimedCrowdsale, PostDeliveryCrowdsale {
  
  mapping(address => uint256) public contributions;

  // Token Distribution
  uint256 public tokenSalePercentage = 70;
  uint256 public foundersPercentage = 10;
  uint256 public foundationPercentage = 10;
  uint256 public partnersPercentage = 10;

  // Token reserve funds
  address public foundersFund;
  address public foundationFund;
  address public partnersFund;

  // Token time lock
  address public foundersTimelock;
  address public foundationTimelock;
  address public partnersTimelock;

  constructor(
      uint256 rate,    // rate in TKNbits
      address payable wallet,
      MyToken token,
      uint256 openingTime,     // opening time in unix epoch seconds https://www.epochconverter.com/
      uint256 closingTime,
      address _foundersFund,
      address _foundationFund,
      address _partnersFund
  )
      Crowdsale(rate, wallet, token)
      TimedCrowdsale(openingTime, closingTime)
      PostDeliveryCrowdsale()
      public
  {
    foundersFund   = _foundersFund;
    foundationFund = _foundationFund;
    partnersFund   = _partnersFund;
  }
  /**
  * @dev Returns the amount contributed so far by a sepecific user.
  * @param _beneficiary Address of contributor
  * @return User contribution so far
  */
  function getUserContribution(address _beneficiary)
    public view returns (uint256)
  {
    return contributions[_beneficiary];
  }

  function _preValidatePurchase(
    address _beneficiary,
    uint256 _weiAmount
  )
    internal view
  {
    super._preValidatePurchase(_beneficiary, _weiAmount);
  }

  function validPurchase (address beneficiary,uint256 weiAmount) public 
  {
      _preValidatePurchase(beneficiary, weiAmount);
      uint256 _existingContribution = contributions[beneficiary];
      uint256 _newContribution = _existingContribution.add(weiAmount);
      contributions[beneficiary] = _newContribution;
  }

  // /**
  //  * @dev enables token transfers, called when owner calls finalize()
  // */
  // function finalization() internal {
  //   if(goalReached()) {
  //     MintableToken _mintableToken = MintableToken(token);
  //     uint256 _alreadyMinted = _mintableToken.totalSupply();

  //     uint256 _finalTotalSupply = _alreadyMinted.div(tokenSalePercentage).mul(100);

  //     foundersTimelock   = new TokenTimelock(token, foundersFund, releaseTime);
  //     foundationTimelock = new TokenTimelock(token, foundationFund, releaseTime);
  //     partnersTimelock   = new TokenTimelock(token, partnersFund, releaseTime);

  //     _mintableToken.mint(address(foundersTimelock),   _finalTotalSupply.mul(foundersPercentage).div(100));
  //     _mintableToken.mint(address(foundationTimelock), _finalTotalSupply.mul(foundationPercentage).div(100));
  //     _mintableToken.mint(address(partnersTimelock),   _finalTotalSupply.mul(partnersPercentage).div(100));

  //     _mintableToken.finishMinting();
  //     // Unpause the token
  //     PausableToken _pausableToken = PausableToken(token);
  //     _pausableToken.unpause();
  //     _pausableToken.transferOwnership(wallet);
  //   }

  //   super.finalization();
  // }


}