// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

// Layout of the contract
// Version
// Imports
// Errors
// Interface, Libraries, Contracts
// Type declarations
// State variables
// Events
// Modifiers
// Functions

// Layout of the functions:
// Constructor
// Receive function
// Fallback function
// External function
// Public function
// Internal function
// Private function
// View and Pure functions


abstract contract Ballot {

    /**
     * @dev Candidate Ids
     */
    uint256[] private candidateList;

    function addCandidate(uint256 _candidateId) public {
        candidateList.push(_candidateId);
    }

    function vote(uint256 _candidateId) external virtual;

    function getCandidateVotes(uint256 _candidateId) public view virtual returns (uint256);

    function getCandidateList() public view returns (uint256[] memory) {
        return candidateList;
    }

}