const MyToken = artifacts.require("MyToken");
const ExampleTokenCrowdsale = artifacts.require("ExampleTokenCrowdsale");

module.exports = async function(deployer) {
  deployer.deploy(MyToken,"Example Token", "EXM", 18).then(function() {
    return deployer.deploy(ExampleTokenCrowdsale, 500, '0xC652c2c6B36Ce08a7596069F83C74732FE5614AD', MyToken.address , new web3.utils.BN(web3.utils.toWei('200', 'ether')));
  });
}
