// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

interface ITestToken {
    function bridgeMint(address account, uint256 amount) external returns(bool);
    function bridgeBurn(address account, uint256 amount) external returns(bool);
    function balanceOf(address owner) external view returns(uint256);
}