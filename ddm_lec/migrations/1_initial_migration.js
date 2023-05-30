const MyTokens = artifacts.require("MyToken");

module.exports = function(deployer)
{
	deployer.deploy(MyTokens, "DDMT99", "DDT");
};




