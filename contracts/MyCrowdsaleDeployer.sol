pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";
import "@openzeppelin/contracts/crowdsale/Crowdsale.sol";
import "@openzeppelin/contracts/crowdsale/emission/MintedCrowdsale.sol";


contract MyToken is ERC20, ERC20Detailed, ERC20Mintable {
    constructor() ERC20Detailed("Gold", "GXD", 18) public {
        _mint(msg.sender, 1000);
    }
}

contract MyCrowdsale is Crowdsale, MintedCrowdsale {
    constructor(
        uint256 rate,    // rate in TKNbits
        address payable wallet,
        IERC20 token
    )
        MintedCrowdsale()
        Crowdsale(rate, wallet, token)
        public
    {

    }
}

contract MyCrowdsaleDeployer {
    constructor()
        public
    {
        // create a mintable token
        ERC20Mintable token = new MyToken();

        // create the crowdsale and tell it about the token
        Crowdsale crowdsale = new MyCrowdsale(
            1,               // rate, still in TKNbits
            msg.sender,      // send Ether to the deployer
            token            // the token
        );
        // transfer the minter role from this contract (the default)
        // to the crowdsale, so it can mint tokens
        token.addMinter(address(crowdsale));
        token.renounceMinter();
    }
}