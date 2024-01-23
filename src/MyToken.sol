// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyToken is ERC20{
    constructor() ERC20("MyToken", "MTK") {}

    function mint(uint256 _amount) public {
        _mint(msg.sender, _amount);
    }
}