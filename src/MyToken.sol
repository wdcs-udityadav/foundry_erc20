// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

import "forge-std/console.sol";

contract MyToken is ERC20, Ownable{
    constructor(address _owner) ERC20("MyToken", "MTK") Ownable(_owner) {}

    function mint(uint256 _amount) public onlyOwner{
        console.log("msg.sender: ", msg.sender);
        _mint(msg.sender, _amount);
    }
}