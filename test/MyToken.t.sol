// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;

    function setUp() public {
        myToken = new MyToken();
    }

    function test_Mint() public {
        myToken.mint(5);
        assertEq(myToken.balanceOf(address(this)), 5);
    }
}
