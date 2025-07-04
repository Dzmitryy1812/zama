// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import { FHE, euint8, externalEuint8 } from "@fhevm/solidity/lib/FHE.sol";
import { SepoliaConfig } from "@fhevm/solidity/config/ZamaConfig.sol";

/// @title Confidential Voting with FHE
contract ConfidentialVoting is SepoliaConfig {
    euint8 private _votesSum;
    mapping(address => bool) public hasVoted;

    /// @notice Returns the current encrypted sum of votes
    function getVotesSum() external view returns (euint8) {
        return _votesSum;
    }

    /// @notice Submit an encrypted vote (0 or 1) with ZK proof
    function vote(externalEuint8 inputEncryptedVote, bytes calldata inputProof) external {
        require(!hasVoted[msg.sender], "Already voted");

        euint8 encryptedVote = FHE.fromExternal(inputEncryptedVote, inputProof);
        _votesSum = FHE.add(_votesSum, encryptedVote);
        hasVoted[msg.sender] = true;

        // Grant FHE decryption permissions for this contract and sender
        FHE.allowThis(_votesSum);
        FHE.allow(_votesSum, msg.sender);
    }
} 
