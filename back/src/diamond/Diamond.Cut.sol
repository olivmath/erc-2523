// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./Diamond.Storage.Lib.sol";
import "./interfaces/IDiamond.Cut.sol";

contract DiamondCut is IDiamondCut {
    using DiamondStorageLib for DiamondStorageLib.Storage;

    function facetCutsToBytes(FacetCut[] memory _diamondCut)
        internal
        pure
        returns (bytes[] memory diamondCutBytes)
    {
        diamondCutBytes = new bytes[](_diamondCut.length);
        //
        //
        for (uint256 i = 0; i < _diamondCut.length; i++) {
            bytes memory selectorsBytes = abi.encodePacked(_diamondCut[i].functionSelectors);
            diamondCutBytes[i] = abi.encode(
                _diamondCut[i].facetAddress, uint8(_diamondCut[i].action), selectorsBytes
            );
        }
        //
        //
        return diamondCutBytes;
    }

    function addSelector(bytes4 selector) internal {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        ds.allFunctions.push(selector);
        // TODO: this should be updated to avoid overflow
        ds.fnLen += 1;
    }

    function removeSelector(bytes4 selector) internal {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        uint256 selectorIndex;
        //
        //
        for (uint256 i = 0; i < ds.allFunctions.length; i++) {
            if (ds.allFunctions[i] == selector) {
                selectorIndex = i;
                break;
            }
        }
        //
        //
        uint256 index = ds.allFunctions.length - 1;
        ds.allFunctions[selectorIndex] = ds.allFunctions[index];
        ds.allFunctions.pop();
        // TODO: this should be updated to avoid underflow
        ds.fnLen -= 1;
    }

    // essa funcao eh responsavel por 'cortar o diamante'
    // isso significa que posso adicionar/editar/remover uma face (contrato) do diamante
    function diamondCut(FacetCut[] memory _diamondCut, address _constructor, bytes memory _calldata)
        external
    {
        DiamondStorageLib.Storage storage ds = DiamondStorageLib.getDiamondStorage();
        //
        //
        for (uint256 i = 0; i < _diamondCut.length; i++) {
            FacetCut memory cut = _diamondCut[i];
            Action action = cut.action;
            address facetAddress = cut.facetAddress;
            bytes4[] memory functionSelectors = cut.functionSelectors;
            //
            //
            for (uint256 j = 0; j < functionSelectors.length; j++) {
                bytes4 functionSelector = functionSelectors[j];
                address currentFacetAddress = ds.fn2facet[functionSelector];
                //
                //
                if (currentFacetAddress == address(0x0) && action == Action.Save) {
                    ds.fn2facet[functionSelector] = facetAddress;
                    addSelector(functionSelector);
                } else if (currentFacetAddress != address(0x0) && action == Action.Modify) {
                    ds.fn2facet[functionSelector] = facetAddress;
                } else if (currentFacetAddress != address(0x0) && action == Action.Remove) {
                    ds.fn2facet[functionSelector] = address(0x0);
                    removeSelector(functionSelector);
                } else if (currentFacetAddress == address(0x0)) {
                    revert("FACET_DOES_NOT_EXIST");
                } else {
                    revert("ACTION_INVALID");
                }
            }
        }
        //
        //
        if (_constructor != address(0x0)) {
            // call constructor of contract
            (bool success,) = _constructor.delegatecall(_calldata);
            if (!success) {
                revert("FAIL_INITIALIZATION");
            }
        }
        //
        //
        emit DiamondCuted(facetCutsToBytes(_diamondCut), _constructor, _calldata);
    }
}
