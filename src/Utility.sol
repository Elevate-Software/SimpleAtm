// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.6;

import "./users/Actor.sol";
import "../lib/ds-test/src/test.sol";

contract Utility is DSTest {

    Actor  blackHat;        // Hacker
    Actor  banker;          // Bank Manager
    Actor  accountOwner;    // Account Owner

    function createActors() public { 
        blackHat     = new Actor();
        banker       = new Actor();
        accountOwner = new Actor();
    }
    
}