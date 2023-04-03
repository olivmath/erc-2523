// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./BaseSetup.sol";

contract FlipperFacetTest is BaseSetup {
    bytes result;

    function setUp() public virtual override {
        BaseSetup.setUp();
    }

    function testFlip() public {
        //call get() -> bool (6d4ce63c)
        (, result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c));
        bool value = abi.decode(result, (bool));
        assertEq(value, false, "Initial value should be false");

        //call flip (cde4efa9)
        address(diamond).call(abi.encodeWithSelector(0xcde4efa9));
        //call get (6d4ce63c)
        (, result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c));
        bool value2 = abi.decode(result, (bool));
        assertEq(value2, true, "Value should be true after flip");

        //call flip (cde4efa9)
        address(diamond).call(abi.encodeWithSelector(0xcde4efa9));
        //call get (6d4ce63c)
        (, result) = address(diamond).call(abi.encodeWithSelector(0x6d4ce63c));
        bool value3 = abi.decode(result, (bool));
        assertEq(value3, false, "Value should be false after flip");
    }
}
