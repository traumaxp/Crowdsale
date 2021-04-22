const DappToken = artifacts.require("./DappToken.sol");
const DappTokenCrowdsale = artifacts.require('DappTokenCrowdsale');

const ether = (n) => new web3.BigNumber(web3.toWei(n, 'ether'));

const duration = {
    seconds: function (val) { return val; },
    minutes: function (val) { return val * this.seconds(60); },
    hours: function (val) { return val * this.minutes(60); },
    days: function (val) { return val * this.hours(24); },
    weeks: function (val) { return val * this.days(7); },
    years: function (val) { return val * this.days(365); },
  };

// module.exports = function(deployer, network, accounts) {
module.exports = function(deployer, network, accounts) {
    const latestTime = Math.floor(Date.now() / 1000);
    const _token = DappToken.address;
    const _rate = 1000;

    const _wallet = accounts[3]; // Collecting Wallet
    const _openingTime = latestTime + duration.minutes(1);
    const _closingTime = _openingTime + duration.minutes(2);
    const _cap = ether(100);

    console.log("Open: " + new Date(_openingTime*1000) + " Close: " + new Date(_closingTime*1000));

    return deployer.deploy(DappTokenCrowdsale, _rate, _wallet, _token, _cap, _openingTime, _closingTime)
        .then(() => {
            return DappToken.deployed().then((token) => {
                return token.transferOwnership(DappTokenCrowdsale.address)
            });
        });
};