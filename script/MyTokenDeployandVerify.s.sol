// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenScript is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");
        address deployer = vm.addr(deployerKey);
        console.log("deployer: ", deployer);
        vm.startBroadcast(deployerKey);

        MyToken myToken = new MyToken(address(this));

        vm.stopBroadcast();
    }
}
