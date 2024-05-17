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

import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol";

contract Election is Initializable {

    error Election__FailedToAddCandidate();
    error Election__ResultsNotDeclared();
    error Election__FailedToDeclareResult();

    uint256[] private candidateList;
    mapping(uint256 => uint256) private candidateVotes;

    uint256 private winnerId;
    bool private resultDeclared;

    address private ballot;
    address private resultCalculator;
    

    event ElectionInitialized(address ballot, address resultCalculator);
    event CandidateAdded(uint256 candidateId);
    event Voted(uint256 candidateId);
    event ResultDeclared(uint256 winnerId);

    function initialize(address _ballotAddress, address _resultCalculatorAddress) public initializer {
        resultDeclared = false;
        ballot = _ballotAddress;
        resultCalculator = _resultCalculatorAddress;
        emit ElectionInitialized(ballot, resultCalculator);
    }

    function addCandidate(uint256 _candidateId) public {
        (bool success,) = address(ballot).delegatecall(abi.encodeWithSignature("addCandidate(uint256)",_candidateId));
        if (!success) {
            revert Election__FailedToAddCandidate();
        }
        emit CandidateAdded(_candidateId);
    }

    function vote(uint256 _candidateId) public {
        (bool success,) = address(ballot).delegatecall(abi.encodeWithSignature("vote(uint256)",_candidateId));
        if (!success) {
            revert Election__FailedToAddCandidate();
        }
        emit Voted(_candidateId);
    }

    function getResults() public {
        (bool success,) = address(resultCalculator).delegatecall(abi.encodeWithSignature("calculateResult()"));
        if (!success) {
            revert Election__FailedToDeclareResult();
        }
        emit ResultDeclared(winnerId);
    }

    function getWinner() public view returns (uint256) {
        if(!resultDeclared){
            revert Election__ResultsNotDeclared();
        }
        return winnerId;
    }

    function getCandidateVotes(uint256 _candidateId) public view returns (uint256) {
        return candidateVotes[_candidateId];
    }

    function getCandidateList() public view returns (uint256[] memory) {
        return candidateList;
    }
    
}