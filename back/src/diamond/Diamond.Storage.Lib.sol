// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library DiamondStorageLib {
    bytes32 constant DIAMOND_STORAGE_POSITION = keccak256("diamond.storage");

    struct Storage {
        bool value;
        mapping(bytes4 => address) fnSelectorToFacet;
        mapping(address => bytes4[]) facetToFnSelector;
        uint256 fnSelectorLength;
        bytes4[] allFnSelectors;
    }

    function getDiamondStorage() internal pure returns (Storage storage ds) {
        bytes32 storagePosition = DIAMOND_STORAGE_POSITION;
        assembly {
            ds.slot := storagePosition
        }
    }
}
