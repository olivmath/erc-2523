// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library DiamondStorageLib {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.storage");

    struct Storage {
        bool value;
        uint256 count;

        mapping(bytes4 => address) fn2facet;
        mapping(address => bytes4[]) facet2fn;
        uint256 fnLen;
        bytes4[] allFunctions;
    }

    function getDiamondStorage() internal pure returns (Storage storage ds) {
        bytes32 storagePosition = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := storagePosition
        }
    }
}
