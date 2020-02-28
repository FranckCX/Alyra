const RoseToken = artifacts.require("RoseToken");

module.exports = function(deployer) {
  deployer.deploy(RoseToken);
};
