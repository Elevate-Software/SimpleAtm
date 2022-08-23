// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

import "../lib/ds-test/src/test.sol";

import "./SimpleAtm.sol";

contract SimpleTest is DSTest {
    SimpleAtm simpleAtm;

    function setUp() public {
        simpleAtm = new SimpleAtm();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
