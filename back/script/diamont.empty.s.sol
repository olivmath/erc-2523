// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "../lib/forge-std/src/Script.sol";
import {console} from "../lib/forge-std/src/console.sol";
import {Diamond} from "../src/diamond/Diamond.sol";

contract DiamondDeploy is Script {
    Diamond diamond;

    function setUp() public virtual {}

    function run() public {
        vm.startBroadcast(0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80);
        // ----------------
        // DIAMOND CONTRACT
        // ----------------
        diamond = new Diamond();
        console.log(address(diamond));
        vm.stopBroadcast();
    }
}
