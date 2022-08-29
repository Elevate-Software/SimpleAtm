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

    // ~ addFunds() Testing ~

    function test_simpleAtm_addFunds_restrictions() public {
        // verify the bank cannot add funds to the balance.
        assert(!banker.try_addFunds(address(simpleAtm), 10 ether));

        // verify a hacker cannot add funds to the balance.
        assert(!blackHat.try_addFunds(address(simpleAtm), 10 ether));

        // verify the account owner can add funds to the balance.
        assert(accountOwner.try_addFunds(address(simpleAtm), 10 ether));
    }

    function test_simpleAtm_addFunds_state_changes() public {
        // Pre-State Check.
        assertEq(simpleAtm.balance(), 0 ether);

        // State Change. Add to account owner's balance.
        assert(accountOwner.try_addFunds(address(simpleAtm), 10 ether));

        // Post-State Check.
        assertEq(simpleAtm.balance(), 10 ether);
    }

    // ~ addFunds() Testing ~

    function test_simpleAtm_removeFunds_restrictions() public {
        // Add 10 ether to the balance
        assert(accountOwner.try_addFunds(address(simpleAtm), 10 ether));

        // verify the bank cannot remove funds to the balance.
        assert(!banker.try_removeFunds(address(simpleAtm), 10 ether));

        // verify a hacker cannot remove funds to the balance.
        assert(!blackHat.try_removeFunds(address(simpleAtm), 10 ether));

        // verify the account owner can remove funds to the balance.
        assert(accountOwner.try_removeFunds(address(simpleAtm), 10 ether));

        // verify the account owner cannot remove 10 ether from an insufficient balance.
        assert(!accountOwner.try_removeFunds(address(simpleAtm), 10 ether));
    }

    function test_simpleAtm_removeFunds_state_changes() public {
        // Add 10 ether to the balance
        assert(accountOwner.try_addFunds(address(simpleAtm), 10 ether));

        // Pre-State Check.
        assertEq(simpleAtm.balance(), 10 ether);

        // State Change. Add to account owner's balance.
        assert(accountOwner.try_removeFunds(address(simpleAtm), 10 ether));

        // Post-State Check.
        assertEq(simpleAtm.balance(), 0 ether);
    }

    // ~ changeOwner() Testing ~

    function test_simpleAtm_changeOwner_restrictions() public {
        // Initialize a new Actor -> Will be used to simulate the new owner.
        Actor tom = new Actor();

        // Verify the account owner cannot change the owner address.
        assert(!accountOwner.try_changeOwner(address(simpleAtm), address(tom)));

        // verify a hacker cannot change the owner address.
        assert(!blackHat.try_changeOwner(address(simpleAtm), address(tom)));

        // verify the banker cannot change the owner address to the existing owner address.
        assert(!banker.try_changeOwner(address(simpleAtm), address(accountOwner)));

        // verify the banker cannot change the owner address to address(0).
        assert(!banker.try_changeOwner(address(simpleAtm), address(0)));

        // verify the bank can change the owner address.
        assert(banker.try_changeOwner(address(simpleAtm), address(tom)));
    }

    function test_simpleAtm_changeOwner_state_changes() public {
        // Initialize a new Actor -> Will be used to simulate the new owner.
        Actor tom = new Actor();

        // Pre-State Check.
        assertEq(simpleAtm.owner(), address(accountOwner));

        // State Change. Change owner var to address of actor, tom.
        assert(banker.try_changeOwner(address(simpleAtm), address(tom)));

        // Post-State Check.
        assertEq(simpleAtm.owner(), address(tom));
    }

}
