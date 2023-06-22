// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Access {
    address public owner;
    mapping(address => bool) public governors;

    modifier onlyOwner() {
        require(msg.sender == owner, "only owner");
        _;
    }

    modifier onlyOwnerOrGovernor() {
        require(governors[msg.sender] || msg.sender == owner, "only owner or governor");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function setGovernor(address _governor) external onlyOwner {
        governors[_governor] = true;
    }

    function revokeGovernor(address _governor) external onlyOwner {
        governors[_governor] = false;
    }

    function transferOwnership(address _owner) external onlyOwner {
        require(_owner != address(0), "invalid owner");
        owner = _owner;
    }
}