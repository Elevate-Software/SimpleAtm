// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.6;
pragma experimental ABIEncoderV2;

contract Actor {

    /*********************/
    /*** TRY FUNCTIONS ***/
    /*********************/

    function try_addFunds(address atm, uint256 amount) external returns (bool ok) {
        string memory sig = "addFunds(uint256)";
        (ok,) = address(atm).call(abi.encodeWithSignature(sig, amount));
    }

    function try_removeFunds(address atm, uint256 amount) external returns (bool ok) {
        string memory sig = "removeFunds(uint256)";
        (ok,) = address(atm).call(abi.encodeWithSignature(sig, amount));
    }

    function try_changeOwner(address atm, address newOwner) external returns (bool ok) {
        string memory sig = "changeOwner(address)";
        (ok,) = address(atm).call(abi.encodeWithSignature(sig, newOwner));
    }

}