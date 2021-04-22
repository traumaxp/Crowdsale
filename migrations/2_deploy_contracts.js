const MyToken = artifacts.require("MyToken");
const MyCrowdsale = artifacts.require("MyCrowdsale");

module.exports = async function(deployer, network, accounts) {
  const _name = "My Token";
  const _symbol = "MTK";
  const _decimals = 18;

  const rate = 1; // 
  const wallet = accounts[0];
  const openingTime = '1619096000';
  const closingTime = '1619096500';

  // Deploy Token
  await deployer.deploy(MyToken, _name, _symbol, _decimals);

  // Deploy MyCrowdsale
  // Params:
      // uint256 rate,    // rate in TKNbits
      // address payable wallet,
      // MyToken token,
      // uint256 openingTime,   1619096000  // opening time in unix epoch seconds https://www.epochconverter.com/
      // uint256 closingTime

  await deployer.deploy(MyCrowdsale, rate, wallet, MyToken.address, openingTime, closingTime);

  const myCrowdsale = await MyCrowdsale.deployed();
  const myToken = await MyToken.deployed()
  await myToken.transfer(myCrowdsale.address, await myToken.totalSupply());
}

// You can then purchase tokens
// await myCrowdsale.sendTransaction({value: web3.utils.toWei('10', 'gwei'), gas: '220000'})
