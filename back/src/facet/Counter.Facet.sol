// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../diamond/Diamond.Storage.Lib.sol";

contract CounterFacet {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function increment() public {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        ds.count += 1;
    }

    function decrement() public {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        ds.count -= 1;
    }

    function getCounter() public view returns (uint256) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        return ds.count;
    }
}
