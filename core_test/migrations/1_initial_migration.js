const Migrations = artifacts.require("Migrations");
const MyTokens = artifacts.require('Token1.sol');   // Token1.sol 파일 추가

module.exports = function (deployer) 
{
  deployer.deploy(Migrations);
  deployer.deploy(MyTokens);
};
