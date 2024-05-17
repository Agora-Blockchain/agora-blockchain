// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.20;

import "./Ballot.sol";

contract GeneralBallot is Ballot {

    uint256[] private candidateList;    
    mapping(uint256 => uint256) private candidateVotes;

    function addCandidate(uint256 _candidateId) public {
        candidateList.push(_candidateId);
    }

    function vote(uint256 _candidateId) external override {
        candidateVotes[_candidateId]++;
    }

    function getCandidateVotes(uint256 _candidateId) public view override returns (uint256) {
        return candidateVotes[_candidateId];
    }

    function getCandidateList() public view returns (uint256[] memory) {
        return candidateList;
    }
}
