// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Diamond.Storage.Lib.sol";
import "./interfaces/IDiamond.Loupe.sol";

contract DiamondLoupe is IDiamondLoupe {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function facetAddress(
        bytes4 fnSelector
    ) external view override returns (address facetAddress_) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib
            .getDiamondStorage();
        facetAddress_ = ds.fn2facet[fnSelector];
    }

    function facetFunctionSelectors(
        address facet_
    ) external view override returns (bytes4[] memory) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib
            .getDiamondStorage();
        bytes4[] memory fnSelectors;
        uint256 index = 0;
        //
        //
        for (uint256 i = 0; i < ds.fnLen; i++) {
            if (ds.fn2facet[ds.allFunctions[i]] == facet_) {
                fnSelectors.push(ds.allFunctions[i]);
                index += 1;
            }
        }

        return fnSelectors;
    }

    function facetAddresses()
        public
        view
        override
        returns (address[] memory facetAddresses_)
    {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib
            .getDiamondStorage();
        address[] memory uniqueFacetAddresses = new address[](ds.fnLen);
        //
        //
        uint256 count = 0;
        for (uint256 i = 0; i < ds.fnLen; i++) {
            address facetAddress_ = ds.fn2facet[ds.allFunctions[i]];
            bool isUnique = true;
            for (uint256 j = 0; j < count; j++) {
                if (uniqueFacetAddresses[j] == facetAddress_) {
                    isUnique = false;
                    break;
                }
            }
            //
            //
            if (isUnique) {
                uniqueFacetAddresses[count] = facetAddress_;
                count += 1;
            }
        }
        //
        //
        for (uint256 i = 0; i < count; i++) {
            facetAddresses_[i] = uniqueFacetAddresses[i];
        }
    }

    function facets() external view override returns (Facet[] memory facets_) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib
            .getDiamondStorage();
        address[] memory uniqueFacetAddresses = facetAddresses();
        facets_ = new Facet[](uniqueFacetAddresses.length);
        //
        //
        for (uint256 i = 0; i < uniqueFacetAddresses.length; i++) {
            //
            //
            uint256 selectorCount = 0;
            for (uint256 j = 0; j < ds.fnLen; j++) {
                if (
                    ds.fn2facet[ds.allFunctions[j]] == uniqueFacetAddresses[i]
                ) {
                    selectorCount += 1;
                }
            }
            //
            //
            bytes4[] memory fnSelectors = new bytes4[](selectorCount);
            uint256 index = 0;
            for (uint256 j = 0; j < ds.fnLen; j++) {
                if (
                    ds.fn2facet[ds.allFunctions[j]] == uniqueFacetAddresses[i]
                ) {
                    fnSelectors[index] = ds.allFunctions[j];
                    index += 1;
                }
            }
            //
            //
            facets_[i] = Facet(uniqueFacetAddresses[i], fnSelectors);
        }
    }
}
