// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import {Flipper} from "../src/Flipper.sol";

contract FlipperTest is Test {
    Flipper public flipper;

    function setUp() public {
        flipper = new Flipper(true);
    }

    function testFlip() public {
        bool initialValue = flipper.get();
        assertEq(initialValue, true, "Initial value should be true");

        flipper.flip();
        bool newValue = flipper.get();
        assertEq(newValue, false, "Value should be false after flip");

        flipper.flip();
        newValue = flipper.get();
        assertEq(newValue, true, "Value should be true after flip");
    }
}
