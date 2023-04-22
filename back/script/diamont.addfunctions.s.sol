// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {Diamond} from "../src/diamond/Diamond.sol";

import {IDiamondCut} from "../src/diamond/interfaces/IDiamond.Cut.sol";
import {FlipperFacet} from "../src/facet/Flipper.Facet.sol";
import {CounterFacet} from "../src/facet/Counter.Facet.sol";

contract DiamondFnDeploy is Script {
    IDiamondCut.FacetCut[] public diamondCut;
    FlipperFacet public flipperFacet;
    CounterFacet public counterFacet;
    Diamond public diamond;

    function setUp() public virtual {}

    function run() public {
        vm.startBroadcast(
            0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
        );
        // ----------------
        // DIAMOND CONTRACT
        // ----------------
        diamond = new Diamond();
        console.log(address(diamond));

        // ----------------
        // FLIPPER CONTRACT
        // ----------------
        // - flip() -> void
        // - get() -> bool
        bytes4[] memory flipperSelectors = new bytes4[](2);
        flipperSelectors[0] = FlipperFacet.flip.selector;
        flipperSelectors[1] = FlipperFacet.get.selector;
        flipperFacet = new FlipperFacet();
        console.log(address(flipperFacet));

        IDiamondCut.FacetCut memory flipperFacetCut = IDiamondCut.FacetCut({
            facetAddress: address(flipperFacet),
            action: IDiamondCut.Action.Save,
            functionSelectors: flipperSelectors
        });

        // ----------------
        // COUNTER CONTRACT
        // ----------------
        // - increment() -> void
        // - decrement() -> void
        // - getCounter() -> bool
        bytes4[] memory selectors = new bytes4[](3);
        selectors[0] = CounterFacet.increment.selector;
        selectors[1] = CounterFacet.decrement.selector;
        selectors[2] = CounterFacet.getCounter.selector;
        counterFacet = new CounterFacet();
        console.log(address(counterFacet));

        IDiamondCut.FacetCut memory counterFacetCut = IDiamondCut.FacetCut({
            facetAddress: address(counterFacet),
            action: IDiamondCut.Action.Save,
            functionSelectors: selectors
        });

        diamondCut.push(flipperFacetCut);
        diamondCut.push(counterFacetCut);
        diamond.diamondCut(diamondCut, address(0), new bytes(0));
        vm.stopBroadcast();
    }
}
