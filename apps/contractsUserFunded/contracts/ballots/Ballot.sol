// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Ballot {
    //Candidates Struct
    struct Candidate {
        uint candidateID;
        string name;
        // string description;
    }

    Candidate[] public candidates;

    uint[] private candidateVotes;

    function addCandidate(string calldata _name) external {
        Candidate memory newCandidate = Candidate(candidates.length, _name);
        candidates.push(newCandidate);
    }

    function removeCandidate(uint _id) external {
        candidates[_id] = candidates[candidates.length - 1];
        candidates[_id].candidateID = _id;
        candidates.pop();
    }

    function getCandidateList() external view returns (Candidate[] memory) {
        return candidates;
    }

    function vote(uint256 _candidateId) internal {
        if (candidateVotes.length == 0) initializeVotes();
        candidateVotes[_candidateId]++;
    }

    function initializeVotes() internal {
        candidateVotes = new uint[](candidates.length);
    }

    function getCandidateVotes() internal view returns (uint256[] memory) {
        return candidateVotes;
    }
}
