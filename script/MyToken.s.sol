// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenScript is Script {
    function run() public {
        MyToken myToken = new MyToken(address(this));
        console.log("My address: ", address(this));
        console.log("Initial balance: ",myToken.balanceOf(address(this)));
        myToken.mint(5);
        console.log("Final balance: ", myToken.balanceOf(address(this)));
        console.log(myToken.totalSupply());


        address user = vm.addr(1);
        console.log("address of user: ", user);
        console.log("Initial balance of user: ",myToken.balanceOf(user));
        myToken.transfer(user, 3);
        console.log("Final balance of user: ",myToken.balanceOf(user));
        console.log("My balance: ", myToken.balanceOf(address(this)));

        vm.broadcast();
    }
}
