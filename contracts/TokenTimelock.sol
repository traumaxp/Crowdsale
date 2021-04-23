pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";

contract TokenTimelock {
    using SafeERC20 for IERC20;

    IERC20 public token;

    address public beneficiary;

    uint256 public releaseTime;

    constructor(
      IERC20 _token,
      address _beneficiary,
      uint256 _releaseTime
    )
    public
    {
      require(_releaseTime > block.timestamp);
      token = _token;
      beneficiary = _beneficiary;
      releaseTime = _releaseTime;
    }

    function release() public {
      require(block.timestamp >= releaseTime);

      uint256 amount = token.balanceOf(address(this));
      require(amount > 0);

      token.safeTransfer(beneficiary, amount);
    }

}