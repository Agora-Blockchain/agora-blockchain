// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Ballot} from "./ballots/Ballot.sol";

contract Election is Ballot {
    //Authentication using db
    mapping(address voter => bool voted) public userVoted;

    struct ElectionInfo {
        string name;
        string description;
        // Election type: 0 for invite based 1 for open
    }

    ElectionInfo public electionInfo;

    //Change generalBallot to Ballot
    Ballot public ballot;
    uint public resultType;

    address public factoryContract;

    constructor(
        ElectionInfo memory _electionInfo,
        uint _ballotType,
        uint _resultType
    ) {
        electionInfo = _electionInfo;
        ballot = new Ballot();
        resultType = _resultType;
        factoryContract = msg.sender;
    }

    function userVote(
        uint _candidateID // uint weight, uint[] memory voteArr
    ) external {
        require(userVoted[msg.sender] == false, "User Voted");
        userVoted[msg.sender] = true;
        vote(_candidateID);
    }

    function ccipVote(address user, uint _candidateId) external {
        require(msg.sender == factoryContract, "Cannot call");
        userVoted[user] = true;
        vote(_candidateId);
    }

    function getResult() external view returns (uint[] memory) {
        return getCandidateVotes();
    }
}
