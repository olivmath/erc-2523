// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Flipper {
    bool private value;

    constructor(bool initvalue) {
        value = initvalue;
    }

    function flip() public {
        value = !value;
    }

    function get() public view returns (bool) {
        return value;
    }
}
