// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;

    function setUp() public {
        myToken = new MyToken();
    }

    function test_Name() public {
        assertEq(myToken.name(), "MyToken");
    }

    function test_Symbol() public {
        assertEq(myToken.symbol(), "MTK");
    }

    function test_Decimals() public {
        assertEq(myToken.decimals(), 18);
    }

    function test_Mint() public {
        myToken.mint(5);
        assertEq(myToken.balanceOf(address(this)), 5);
    }

    function test_TotalSupply() public {
        assertEq(myToken.totalSupply(), 0);
    }

    function test_Transfer() public {
        address receiver = vm.addr(2);
        myToken.mint(10);

        myToken.transfer(receiver,10);
        assertEq(myToken.balanceOf(receiver), 10);
        assertEq(myToken.balanceOf(address(this)), 0);
    }

    function test_Approve_Allowance() public {
        address spender = vm.addr(3);
        bool isApproved = myToken.approve(spender, 25);

        assertEq(isApproved, true);
        assertEq(myToken.allowance(address(this), spender), 25);
    }

    function test_TransferFrom() public {
        address to = vm.addr(4);
        myToken.mint(15);
        assertEq(myToken.balanceOf(address(this)), 15);

        myToken.approve(address(this), 15);
        myToken.transferFrom(address(this), to, 15);

        assertEq(myToken.balanceOf(to), 15);
    }
}
