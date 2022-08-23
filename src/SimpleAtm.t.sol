// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../lib/ds-test/src/test.sol";
import "./SimpleAtm.sol";
import "./Utility.sol";

contract SimpleTest is DSTest, Utility {
    SimpleAtm simpleAtm;

    function setUp() public {
        createActors();

        simpleAtm = new SimpleAtm(
            address(banker),
            address(accountOwner),
            0 ether
        );
    }

    function test_SimpleAtm_init_state() public {
        assertEq(simpleAtm.bank(), address(banker));
        assertEq(simpleAtm.owner(), address(accountOwner));
        assertEq(simpleAtm.balance(), 0 ether);
    }

    function test_simpleAtm_addFunds_restrictions() public {
        
    }

}
