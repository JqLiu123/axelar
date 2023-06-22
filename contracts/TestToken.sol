//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./Access.sol";
contract TestToken is ERC20, Access {
    address public bridgeAddr;

    modifier onlyBridge() {
        require(msg.sender == bridgeAddr, "WA3SToken: invalid caller");
        _;
    }

    constructor() ERC20("Test Token", "TT") {
        _mint(msg.sender, 10000);
    }

    function bridgeMint(address account, uint256 amount) external onlyBridge returns(bool) {
        _mint(account, amount);
        return true;
    }

    function bridgeBurn(address account, uint256 amount) external onlyBridge returns(bool) {
        _burn(account, amount);
        return true;
    }

    function setBridge(address _bridgeAddr) external onlyOwnerOrGovernor {
        bridgeAddr = _bridgeAddr;
    }
}