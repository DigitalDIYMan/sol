// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import '@openzeppelin/contracts/token/ERC20/ERC20.sol';

contract Token1 is ERC20 
{
    // 1 token = 1 * (10 ** decimals)
    // 1000000 tokens = 1000000 * (10 ** decimals)
    
    constructor() ERC20('Token9_OnTruffle', 'TK9OT')
    {
        _mint(msg.sender, 1000000000000 * 10 ** decimals());
    }

}

