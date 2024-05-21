// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.24;

import {Election} from "./Election.sol";
import {Client} from "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import {CCIPReceiver} from "@chainlink/contracts-ccip/src/v0.8/ccip/applications/CCIPReceiver.sol";

contract ElectionFactory is CCIPReceiver {
    /// @notice this stores all the elections
    address[] public openBasedElections;
    // address[] public inviteBasedElections;

    /// @notice this stores the addresses of whitelisted sender contracts for CCIP
    address[] public approvedSenderContracts;

    // Create election using db
    // election info, ballot, resultcalculator
    function createElection(
        Election.ElectionInfo memory _electionInfo,
        uint _ballotType,
        uint _resultType
    ) external {
        Election election = new Election(
            _electionInfo,
            _ballotType,
            _resultType
        );
        openBasedElections.push(address(election));
    }

    function deleteElection() external {}

    function updateElection() external {}

    struct CCIPVote {
        address election;
        address user;
        uint candidateId;
    }

    function ccipVote(CCIPVote memory _vote) internal {
        Election _election = Election(_vote.election);
        _election.ccipVote(_vote.user, _vote.candidateId);
    }

    event MessageReceived(
        bytes32 indexed messageId, // The unique ID of the message.
        uint64 indexed sourceChainSelector, // The chain selector of the source chain.
        address sender, // The address of the sender from the source chain.
        string text //The text that was received.
    );

    /// @notice Constructor initializes the contract with the router address.
    constructor(address router) CCIPReceiver(router) {}

    /// handles crosschain vote
    // any2EvmMessage.messageId shows the address of senderContract
    function _ccipReceive(
        Client.Any2EVMMessage memory any2EvmMessage
    ) internal override {
        CCIPVote memory _vote = abi.decode(any2EvmMessage.data, (CCIPVote)); // abi-decoding of the sent vote
        ccipVote(_vote);
        emit MessageReceived(
            any2EvmMessage.messageId,
            any2EvmMessage.sourceChainSelector, // fetch the source chain identifier
            abi.decode(any2EvmMessage.sender, (address)), // abi-decoding of the sender address,
            "User voted"
        );
    }
}
