// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import "openzeppelin-contracts/contracts/access/Ownable.sol";

import "forge-std/console.sol";

contract MyToken is ERC20, Ownable {
    uint256 public startTimestamp = block.timestamp + 1 days;
    uint256 public endTimestamp = block.timestamp + 2 days;

    constructor(address _owner) ERC20("MyToken", "MTK") Ownable(_owner) {}

    event Minted(uint256 indexed amount, address to);

    function mint(uint256 _amount) public onlyOwner {
        require(block.timestamp >= startTimestamp && block.timestamp < endTimestamp, "cannot mint");
        console.log("msg.sender: ", msg.sender);
        _mint(msg.sender, _amount);

        emit Minted(_amount, msg.sender);
    }
}
