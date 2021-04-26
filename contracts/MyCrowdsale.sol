pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./MyToken.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/validation/TimedCrowdsale.sol";
import "@openzeppelin/contracts/crowdsale/distribution/PostDeliveryCrowdsale.sol";
import "@openzeppelin/contracts/token/ERC20/TokenTimelock.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Pausable.sol";


contract MyCrowdsale is Crowdsale, TimedCrowdsale, PostDeliveryCrowdsale {
  
  mapping(address => uint256) public contributions;


  // Token Distribution
  uint256 public tokenSalePercentage = 12.5;
  uint256 public founderAPercentage = 10;
  uint256 public founderBPercentage = 10;
  uint256 public futurTeamPercentage = 4;
  uint256 public advisorsPercentage = 2;
  uint256 public LPreserveBootstrapPercentage = 4.5;
  uint256 public LPreserveIncentivePercentage = 37.5;
  uint256 public TGPAirdropPercentage = 2;
  uint256 public stakingReserveIncentivePercentage = 9;
  uint256 public marketingReservePercentage = 6;
  uint256 public bugsBountyCompensationPercentage = 2.5;




  // Token reserve funds
  address public founderAFund;
  address public founderBFund;
  address public futurTeamFund;
  address public advisorsFund;
  address public LPreserveBootstrapFund;
  address public LPreserveIncentiveFund;
  address public TGPAirdropFund;
  address public stakingReserveIncentiveFund;
  address public marketingReserveFund;
  address public bugsBountyCompensationFund;

  // Token time lock
  address public founderATimelock; // Vesting 36months
  address public founderBTimelock; // Vesting 36 months
  address public futurTeamTimelock; // Vesting 36 months
  address public advisorsTimelock; // Vesting 12months
  address public LPreserveBootstrapTimelock; // Vesting 10months
  address public LPreserveIncentiveTimelock; // No vesting = locked in sc for lp mining
  address public TGPAirdropTimelock;
  address public stakingReserveIncentiveTimelock; // No vesting = locked in sc for Staking
  address public marketingReserveTimelock; // Vesting 36months
  address public bugsBountyCompensationTimelock;
  address public foundersTimelock;
  address public foundationTimelock;
  address public partnersTimelock;

  // Token time lock
  // address public foundersTimelock;
  // address public foundationTimelock;
  // address public partnersTimelock;

  uint public releaseTimeStaking;
  bool public finalized;

  constructor(
      uint256 rate,    // rate in TKNbits
      address payable wallet,
      MyToken token,
      uint256 openingTime,     // opening time in unix epoch seconds https://www.epochconverter.com/
      uint256 closingTime,
      address _foundersFund,
      address _foundationFund,
      address _partnersFund,
      uint256 _releaseTimeStaking
  )
      Crowdsale(rate, wallet, token)
      TimedCrowdsale(openingTime, closingTime)
      PostDeliveryCrowdsale()
      public
  {
    // foundersFund   = _foundersFund;
    // foundationFund = _foundationFund;
    // partnersFund   = _partnersFund;
    // releaseTimeStaking = _releaseTimeStaking;
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

  // function finalizeIfNeeded () internal {
  //   if (!finalized && block.timestamp >= closingTime) {
  //       finalization ();
  //       finalized = true;
  //   }
  // }

  /**
   * @dev enables token transfers, called when owner calls finalize()
  */
  // function finalization() internal {
  //     ERC20Mintable _mintableToken = ERC20Mintable(token);
  //     uint256 _alreadyMinted = _mintableToken.totalSupply();

  //     uint256 _finalTotalSupply = _alreadyMinted.div(tokenSalePercentage).mul(100);

  //     foundersTimelock   = new TokenTimelock(token, foundersFund, releaseTimeFounders);
  //     // foundationTimelock = new TokenTimelock(token, foundationFund, releaseTime);
  //     // partnersTimelock   = new TokenTimelock(token, partnersFund, releaseTime);

  //     _mintableToken.mint(address(foundersTimelock),   _finalTotalSupply.mul(foundersPercentage).div(100));
  //     _mintableToken.mint(address(foundationTimelock), _finalTotalSupply.mul(foundationPercentage).div(100));
  //     _mintableToken.mint(address(partnersTimelock),   _finalTotalSupply.mul(partnersPercentage).div(100));

  // }


}