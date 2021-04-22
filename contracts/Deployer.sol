pragma solidity ^0.5.0;

import "./Token.sol";
import "./CrowdsaleToken.sol";

contract MyCrowdsaleDeployer is Token, CrowdsaleToken {
    constructor()
        public
    {
        // create a mintable token
        ERC20Mintable token = new Token();

        // create the crowdsale and tell it about the token
        Crowdsale crowdsale = new CrowdsaleToken(
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