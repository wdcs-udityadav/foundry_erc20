// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MyToken} from "../src/MyToken.sol";

contract MyTokenTest is Test {
    MyToken public myToken;
    uint256 startTimestamp;

    event Minted(uint256 indexed amount, address to);

    function setUp() public {
        myToken = new MyToken(address(this));
        startTimestamp = block.timestamp;
        console.log("myToken: ", address(myToken));
    }

    function testGetOwner() public {
        assertEq(myToken.owner(), address(this));
    }

    function testGetName() public {
        assertEq(myToken.name(), "MyToken");
    }

    function testGetSymbol() public {
        assertEq(myToken.symbol(), "MTK");
    }

    function testGetDecimals() public {
        assertEq(myToken.decimals(), 18);
    }

    function testMintFailsBeforeStartTime() public {
        vm.expectRevert(bytes("cannot mint"));
        myToken.mint(100);
    }

    function testMintFailsAfterEndtime() public {
        vm.warp(startTimestamp + 2 days);
        vm.expectRevert(bytes("cannot mint"));
        myToken.mint(100);
    }

    function testCanMint() public {
        vm.warp(startTimestamp + 1 days);
        myToken.mint(5);
        console.log("address(this): ", address(this));
        assertEq(myToken.balanceOf(address(this)), 5);
    }

    function testGetTotalSupply() public {
        assertEq(myToken.totalSupply(), 0);
    }

    function testCanTransfer() public {
        address receiver = vm.addr(2);
        console.log("receiver: ", receiver);
        vm.warp(startTimestamp + 1 days);

        myToken.mint(10);

        myToken.transfer(receiver, 10);
        assertEq(myToken.balanceOf(receiver), 10);
        assertEq(myToken.balanceOf(address(this)), 0);
    }

    function testCanApproveAndAllowance() public {
        address spender = vm.addr(3);
        bool isApproved = myToken.approve(spender, 25);

        assertEq(isApproved, true);
        assertEq(myToken.allowance(address(this), spender), 25);
    }

    function testCanTransferFrom() public {
        address to = vm.addr(4);
        vm.warp(startTimestamp + 1 days);
        myToken.mint(15);
        assertEq(myToken.balanceOf(address(this)), 15);

        myToken.approve(address(this), 15);
        myToken.transferFrom(address(this), to, 15);

        assertEq(myToken.balanceOf(to), 15);
    }

    function testEmitMintEvent() public {
        vm.expectEmit(true, false, false, true);
        emit Minted(100, address(this));
        vm.warp(startTimestamp + 1 days);

        myToken.mint(100);
    }

    function testFailMintIfCallerNotOwner() public {
        vm.prank(address(0));
        myToken.mint(10);
    }

    function testFailTransferWhenLowBalance() public {
        console.log("balance: ", myToken.balanceOf(address(this)));
        address to = vm.addr(5);
        myToken.transfer(to, 10);
    }

    function testFailTransferFromIfInsufficientAllowance() public {
        address to = vm.addr(6);
        myToken.transferFrom(address(this), to, 101);
    }
}
