const MilestonePaymentChannel = artifacts.require("MilestonePaymentChannel");

module.exports = async function(deployer, _network, accounts) {
  await deployer.deploy(MilestonePaymentChannel, accounts[0], accounts[1], accounts[2]);
};
