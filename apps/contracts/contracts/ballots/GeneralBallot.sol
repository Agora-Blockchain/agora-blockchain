// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "./Ballot.sol";

contract GeneralBallot is Ballot {
    
    mapping(uint256 => uint256) private candidateVotes;

    function vote(uint256 _candidateId) external override {
        candidateVotes[_candidateId]++;
    }

    function getCandidateVotes(uint256 _candidateId) public view override returns (uint256) {
        return candidateVotes[_candidateId];
    }
}
