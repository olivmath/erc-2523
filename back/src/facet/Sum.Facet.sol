// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../diamond/Diamond.Storage.Lib.sol";

contract SumFacet {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function sum(uint256 x, uint256 y) public pure returns (uint256 z) {
        z = x + y;
    }
}
