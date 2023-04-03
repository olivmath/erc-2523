// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./BaseSetup.sol";

contract CounterFacetTest is BaseSetup {
    bytes result;
    uint256 value;

    function setUp() public virtual override {
        BaseSetup.setUp();
    }

    function testCounter() public {
        // 8ada066e  =>  getCounter() -> uint256
        (, result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e));
        value = abi.decode(result, (uint256));
        assertEq(value, 0, "Initial value should be 0");

        // d09de08a  =>  increment() -> void
        address(diamond).call(abi.encodeWithSelector(0xd09de08a));
        // d09de08a  =>  increment() -> void
        address(diamond).call(abi.encodeWithSelector(0xd09de08a));
        // 8ada066e  =>  getCounter() -> uint256
        (, result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e));
        value = abi.decode(result, (uint256));
        assertEq(value, 2, "Double incremented value should be 2");

        // 2baeceb7  =>  decrement() -> void
        address(diamond).call(abi.encodeWithSelector(0x2baeceb7));
        // 8ada066e  =>  getCounter() -> uint256
        (, result) = address(diamond).call(abi.encodeWithSelector(0x8ada066e));
        value = abi.decode(result, (uint256));
        assertEq(value, 1, "Decremented value should be 1");
    }
}
