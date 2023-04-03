// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "../lib/forge-std/src/Test.sol";
import "../src/diamond/Diamond.sol";
import "../src/diamond/Diamond.Cut.sol";
import {FlipperFacet} from "../src/facet/Flipper.Facet.sol";
import {CounterFacet} from "../src/facet/Counter.Facet.sol";

contract BaseSetup is Test {
    Diamond public diamond;
    FlipperFacet public flipperFacet;
    CounterFacet public counterFacet;
    IDiamondCut.FacetCut[] public diamondCut;

    function setUp() public virtual {
        // ----------------
        // DIAMOND CONTRACT
        // ----------------
        diamond = new Diamond();

        // ----------------
        // FLIPPER CONTRACT
        // ----------------
        // - flip() -> void
        // - get() -> bool
        bytes4[] memory flipperSelectors = new bytes4[](2);
        flipperSelectors[0] = FlipperFacet.flip.selector;
        flipperSelectors[1] = FlipperFacet.get.selector;
        flipperFacet = new FlipperFacet();

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

        IDiamondCut.FacetCut memory counterFacetCut = IDiamondCut.FacetCut({
            facetAddress: address(counterFacet),
            action: IDiamondCut.Action.Save,
            functionSelectors: selectors
        });

        diamondCut.push(flipperFacetCut);
        diamondCut.push(counterFacetCut);
        diamond.diamondCut(diamondCut, address(0), new bytes(0));
    }
}
