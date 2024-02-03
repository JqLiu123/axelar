// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./interfaces/IAxelarGateway.sol";
import "./interfaces/IFeeService.sol";
import "./interfaces/ITestToken.sol";
import "./Access.sol";
contract Bridge is Access {
    struct BridgeInfo {
        string bridgeAddr;
        bool set;
        bool open;
    }

    IAxelarGateway public axelarGateway;
    IFeeService public feeService;
    ITestToken public TestToken;
    mapping(string => BridgeInfo) public bridges;

    constructor(address _axelarGateway, address _feeService, address _TestToken) {
        axelarGateway = IAxelarGateway(_axelarGateway);
        feeService = IFeeService(_feeService);
        TestToken = ITestToken(_TestToken);
    }

    function bridgeOut(
        string calldata desChain,
        uint256 amount
    ) external payable {
        BridgeInfo memory bridge = bridges[desChain];
        require(bridge.set, "Bridge: invalid bridge");

        bytes memory payload = abi.encode(msg.sender ,amount);
        feeService.payNativeGasForContractCall{value: msg.value}(
            address(this), 
            desChain, 
            bridge.bridgeAddr, 
            payload, 
            msg.sender
        );
        TestToken.bridgeBurn(msg.sender, amount);
        axelarGateway.callContract(desChain, bridge.bridgeAddr, payload);
    }

    function execute(
        bytes32 commandId,
        string calldata sourceChain,
        string calldata sourceAddress,
        bytes calldata payload
    ) external {
        bytes32 bridgeAddrHash = keccak256(abi.encode(bridges[sourceChain].bridgeAddr));
        bytes32 sourceAddressHash = keccak256(abi.encode(sourceAddress));
        require(bridgeAddrHash == sourceAddressHash, "Bridge: invalid caller");

        bytes32 payloadHash = keccak256(payload);
        require(
            axelarGateway.validateContractCall(commandId, sourceChain, sourceAddress, payloadHash),
            "Bridge: invalid call"
        );

        (address account, uint256 amount) = abi.decode(payload, (address, uint256));
        TestToken.bridgeMint(account, amount);
    }

    function setBridges(
        string[] memory chains, 
        string[] memory bridgeAddrs, 
        bool[] memory open
    ) external onlyOwnerOrGovernor {
        for (uint256 i = 0; i < chains.length; i++) {
            bridges[chains[i]] = BridgeInfo(bridgeAddrs[i], true, open[i]);
        }
    }

    function setBridgeConnections(string[] memory chains, bool[] memory open) external onlyOwnerOrGovernor {
        for (uint256 i = 0; i < chains.length; i++) {
            require(bridges[chains[i]].set, "Bridge: unset bridge");
            bridges[chains[i]].open = open[i];
        }
    }

}
