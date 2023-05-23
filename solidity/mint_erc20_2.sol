// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MyToken2 is ERC20 
{
    // 1 token = 1 * (10 ** decimals)
    // 1000000 tokens = 1000000 * (10 ** decimals)
    
    constructor(string memory name, string memory symbol, uint256 amount) ERC20(name, symbol)
    {
        _mint(msg.sender, amount * 10 ** decimals());
    }

}
