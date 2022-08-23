// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.6;

contract SimpleAtm {

    // ~ State Variables ~

    address public bank;
    address public owner;
    uint256 public balance;

    // ~ Constructor ~

    constructor(
        address _bank,
        address _owner,
        uint256 _startBalance
        ) {
        bank = _bank;
        owner = _owner;
        balance = _startBalance;
    }

    // ~ Modifiers ~

    modifier isOwner() {
        require(msg.sender == owner, "Err: msg.sender is now owner");
        _;
    }

    modifier isBank() {
        require(msg.sender == owner, "Err: msg.sender is now owner");
        _;
    }
    
    // ~ Functions ~

    function addFunds(uint256 _amount) external isOwner {
        balance += _amount;
    }

    function removeFunds(uint256 _amount) external isOwner {
        require(balance >= _amount, "Err: Insufficient Funds");
        balance -= _amount;
    }

    function changeOwner(address _address) external isBank {
        require(_address != address(0), "Err: Cannot set account owner to address(0)");
        require(owner != _address, "Err: address already set as owner");
        owner = _address;
    }
}
