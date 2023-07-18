// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./IRemoteCallPrecompile.sol";

address constant _REMOTE_STATIC_CALL_PRECOMPILE = address(
    0x0000000000000000000000000000000000009000
);
address constant _REMOTE_GET_BALANCE_PRECOMPILE = address(
    0x0000000000000000000000000000000000009001
);
address constant _REMOTE_GET_STORAGE_AT_PRECOMPILE = address(
    0x0000000000000000000000000000000000009002
);
address constant _REMOTE_GET_CODE_PRECOMPILE = address(
    0x0000000000000000000000000000000000009003
);
address constant _REMOTE_CODE_SIZE_PRECOMPILE = address(
    0x0000000000000000000000000000000000009004
);

interface IL1BlockNumber {
    function number() external view returns(uint64);
}

IL1BlockNumber constant _REMOTE_L1_BLOCK = IL1BlockNumber(0x4200000000000000000000000000000000000015);

library RemoteCall {
    // ===================================================
    // Historical block query
    // ===================================================

    function remoteStaticCall(
        uint256 blockNumber,
        address from,
        address to,
        uint256 value,
        bytes calldata data
    ) public view returns (bytes memory result) {
        return
            IRemoteCallPrecompile(_REMOTE_STATIC_CALL_PRECOMPILE).eth_call(
                blockNumber,
                from,
                to,
                value,
                data
            );
    }

    function remoteGetBalance(
        uint256 blockNumber,
        address target
    ) public view returns (uint256) {
        return
            IRemoteCallPrecompile(_REMOTE_GET_BALANCE_PRECOMPILE)
                .eth_getBalance(blockNumber, target);
    }

    function remoteGetStorageAt(
        uint256 blockNumber,
        address target,
        uint256 position
    ) public view returns (bytes32) {
        return
            IRemoteCallPrecompile(_REMOTE_GET_STORAGE_AT_PRECOMPILE)
                .eth_getStorageAt(blockNumber, target, position);
    }

    function remoteGetCode(
        uint256 blockNumber,
        address target
    ) public view returns (bytes memory) {
        return
            IRemoteCallPrecompile(_REMOTE_GET_CODE_PRECOMPILE).eth_getCode(
                blockNumber,
                target
            );
    }

    function remoteCodeSize(
        uint256 blockNumber,
        address target
    ) public view returns (uint256) {
        return
            IRemoteCallPrecompile(_REMOTE_CODE_SIZE_PRECOMPILE).eth_codeSize(
                blockNumber,
                target
            );
    }

    // ===================================================
    // Latest block query
    // ===================================================

    function remoteStaticCall(
        address from,
        address to,
        uint256 value,
        bytes calldata data
    ) public view returns (bytes memory result) {
        return remoteStaticCall(_REMOTE_L1_BLOCK.number(), from, to, value, data);
    }

    function remoteGetBalance(
        address target
    ) public view returns (uint256) {
        return remoteGetBalance(_REMOTE_L1_BLOCK.number(), target);
    }

    function remoteGetStorageAt(
        address target,
        uint256 position
    ) public view returns (bytes32) {
        return remoteGetStorageAt(_REMOTE_L1_BLOCK.number(), target, position);
    }

    function remoteGetCode(
        address target
    ) public view returns (bytes memory) {
        return remoteGetCode(_REMOTE_L1_BLOCK.number(), target);
    }

    function remoteCodeSize(
        address target
    ) public view returns (uint256) {
        return remoteCodeSize(_REMOTE_L1_BLOCK.number(), target);
    }
}
