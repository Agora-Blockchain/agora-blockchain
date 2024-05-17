// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;


interface IBallot {
    
    function addCandidate(uint256 _candidateId) external;

    function vote(uint256 _candidateId) external ;

    function getCandidateVotes(uint256 _candidateId) external view returns (uint256);

    function getCandidateList() external view  returns (uint256[] memory);

}