// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

interface IFeeService {
    function payNativeGasForContractCall(
        address sender,
        string calldata destinationChain,
        string calldata destinationAddress,
        bytes calldata payload,
        address refundAddress
    ) external payable;
}
