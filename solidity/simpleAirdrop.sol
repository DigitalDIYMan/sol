// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

struct timePeriod 
{
    uint beginTime;
    uint endTime;
}


contract DDM_SimpleAirdrop is ERC20, Ownable 
{
    bool public airdropEnabled;     // 에어드랍 가능 여부
    timePeriod public dTimePeriod;  // 에어드랍 시간 

    mapping(address => bool) public airdropReceivers; // 에어드랍 참여자 

    uint256 public airdropAmount = 0.00001 ether;

    constructor(string memory name, string memory symbol) ERC20(name, symbol) 
    {
        airdropEnabled = false;
        dTimePeriod.beginTime = 0;
        dTimePeriod.endTime = 0;
    }


    function setAirdropValue_1_ETH(uint256 amount) public onlyOwner 
    {
        airdropAmount = amount * 1 ether;
    }

    function setAirdropValue_point_001_ETH(uint256 amount) public onlyOwner 
    {
        airdropAmount = amount * 0.001 ether;
    }

    function getAirdropValue() public view returns (uint256) 
    {
        return airdropAmount;
    }


    function airdropOn() public onlyOwner 
    {
        airdropEnabled = true;
    }

    function airdropOff() public onlyOwner 
    {
        airdropEnabled = false;
    }

    function getMintingState() public view returns (bool) 
    {
        return airdropEnabled;
    }

    function setTimePeriod(uint256 begin, uint256 end) public onlyOwner
    {
        dTimePeriod = timePeriod(begin, end);
    }

    function getTimePeriod() public view returns (uint256, uint256) 
    {
        return (dTimePeriod.beginTime, dTimePeriod.endTime);
    }

    function addReceiver(address user) public onlyOwner 
    {
        airdropReceivers[user] = true;
    }

    function removeReceiver(address user) public onlyOwner 
    {
        airdropReceivers[user] = false;
    }

    function getReceiverState(address user) public view returns (bool) 
    {
        return airdropReceivers[user];
    }

    function depositToHere_1_ETH(uint256 amount) 
        external payable 
    {
        require(msg.value > 0 && amount > 0, "zero value is not allowed");

        uint256 value = amount * 1 ether;

        require(msg.value == value, "msg.value is wrong");
        // nothing else to do!
    }

    function depositToHere(uint256 amount) 
        external payable 
    {
        require(msg.value > 0 && amount > 0, "zero value is not allowed");
        require(msg.value == amount, "msg.value is wrong");
        // nothing else to do!
    }


    function getBalance()
        public onlyOwner
        view
        returns (uint256)
    {
        require(address(this).balance > 0, "Balance is 0");

        return address(this).balance;
    }

    function getThisAddress()
        public onlyOwner
        view
        returns (address)
    {
        return address(this);
    }

    function withdraw()
        public onlyOwner
        payable
    {
        require(address(this).balance > 0, "Balance is 0");

        // get the amount of Ether stored in this contract
        uint256 amount = address(this).balance;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool bSuccess, ) = owner().call{value: amount}("");
        require(bSuccess, "Failed to send Ether");
    }

    function withdrawALittleBit() 
        public onlyOwner
        payable
    {
        require(address(this).balance > 0, "Balance is 0");

        // get the amount of Ether stored in this contract
        uint256 amount = address(this).balance * 1 / 100;

        // send all Ether to owner
        // Owner can receive Ether since the address of owner is payable
        (bool bSuccess, ) = owner().call{value: amount}("");
        require(bSuccess, "Failed to send Ether");
    }


    function withdrawToOther(address payable toUserAddress) 
        public payable
    {
        require(address(this).balance >= airdropAmount, "Balance is too low");
        require(toUserAddress != address(0), "Wallet address is wrong");
        require(airdropEnabled, "airdrop is not enabled");
        require(dTimePeriod.beginTime > 0 && dTimePeriod.endTime > 0, "Period is not inputted");
        require(block.timestamp >= dTimePeriod.beginTime, "airdrop not yet started");
        require(block.timestamp <= dTimePeriod.endTime, "airdrop period has ended");
        require(airdropReceivers[toUserAddress] == false, "user can airdrop only once");

        // user can airdrop only once
        airdropReceivers[toUserAddress] = true;

        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool bSent, ) = toUserAddress.call{value: airdropAmount}("");
        require(bSent, "Failed to send Ether");
    }

}