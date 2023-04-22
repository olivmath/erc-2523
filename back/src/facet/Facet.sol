// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../diamond/Diamond.Storage.Lib.sol";

abstract contract Facet {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function getSomeValue() public view returns (bool) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        return ds.value;
    }
}
