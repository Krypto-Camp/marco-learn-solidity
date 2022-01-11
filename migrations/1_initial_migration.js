const Migrations = artifacts.require("Migrations");
const cutLeeks = artifacts.require("cutLeeks");

module.exports = function (deployer) {
  deployer.deploy(Migrations);
  deployer.deploy(cutLeeks);
};
