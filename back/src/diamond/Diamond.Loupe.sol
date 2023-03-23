// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Diamond.Storage.Lib.sol";
import "./interfaces/IDiamond.Loupe.sol";

contract DiamondLoupe is IDiamondLoupe {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function facetAddress(bytes4 fnSelector)
        external
        view
        override
        returns (address facetAddress_)
    {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        facetAddress_ = ds.fnSelectorToFacet[fnSelector];
    }

    function facetFunctionSelectors(address facet_)
        external
        view
        override
        returns (bytes4[] memory fnSelectors)
    {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        fnSelectors = new bytes4[](ds.fnSelectorLength);
        uint256 index = 0;
        //
        //
        for (uint256 i = 0; i < ds.fnSelectorLength; i++) {
            if (ds.fnSelectorToFacet[ds.allFnSelectors[i]] == facet_) {
                fnSelectors[index++] = ds.allFnSelectors[i];
                index += 1;
            }
        }
        //
        //
        assembly {
            mstore(fnSelectors, index)
        }
    }

    function facets() external view override returns (Facet[] memory facets_) {}

    function facetAddresses() external view override returns (address[] memory facetAddresses_) {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        address[] memory uniqueFacetAddresses = new address[](ds.fnSelectorLength);
        //
        //
        uint256 count = 0;
        for (uint256 i = 0; i < ds.fnSelectorLength; i++) {
            address facetAddress_ = ds.fnSelectorToFacet[ds.allFnSelectors[i]];
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
}
