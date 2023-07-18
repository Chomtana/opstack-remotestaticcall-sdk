// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IRemoteCallPrecompile {
    function eth_call(
        uint256 blockNumber,
        address from,
        address to,
        uint256 value,
        bytes calldata data
    ) external view returns (bytes memory);

    function eth_getBalance(
        uint256 blockNumber,
        address target
    ) external view returns (uint256);

    function eth_getStorageAt(
        uint256 blockNumber,
        address target,
        uint256 position
    ) external view returns (bytes32);

    function eth_getCode(
        uint256 blockNumber,
        address target
    ) external view returns (bytes memory);

    function eth_codeSize(
        uint256 blockNumber,
        address target
    ) external view returns (uint256);
}
