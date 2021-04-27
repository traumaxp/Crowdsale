const MyToken = artifacts.require("MyToken");
const ExampleTokenCrowdsale = artifacts.require("ExampleTokenCrowdsale");

module.exports = async function(deployer, accounts) {
  deployer.deploy(MyToken,"Example Token", "EXM", 18).then(function() {
    return deployer.deploy(ExampleTokenCrowdsale, 500, '0x7fC23F3411842f9381eAD4e75Dac9640a1abEB82', MyToken.address , new web3.utils.BN(web3.utils.toWei('200', 'ether')));
  });
}
