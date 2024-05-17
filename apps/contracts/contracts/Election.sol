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

import {IBallot} from "./ballots/IBallot.sol";
import {IResultCalculator} from "./resultCalculators/IResultCalculator.sol";


contract Election {

    error Election__FailedToAddCandidate();
    error Election__ResultsNotDeclared();

    uint256[] private candidateList;
    mapping(uint256 => uint256) private candidateVotes;

    IBallot private ballotAddress;
    IResultCalculator private resultCalculatorAddress;
    uint256 private winnerId;
    bool private resultDeclared;

    event CandidateAdded(uint256 candidateId);
    event Voted(uint256 candidateId);
    event ResultDeclared(uint256 winnerId);

    constructor(address _ballotAddress, address _resultCalculatorAddress){
        resultDeclared = false;
        ballotAddress = IBallot(_ballotAddress);
        resultCalculatorAddress = IResultCalculator(_resultCalculatorAddress);
    }

    function addCandidate(uint256 _candidateId) public {
        (bool success,) = address(ballotAddress).delegatecall(abi.encodeWithSignature("addCandidate(uint256)",_candidateId));
        if (!success) {
            revert Election__FailedToAddCandidate();
        }
        emit CandidateAdded(_candidateId);
    }

    function vote(uint256 _candidateId) public {
        (bool success,) = address(ballotAddress).delegatecall(abi.encodeWithSignature("vote(uint256)",_candidateId));
        if (!success) {
            revert Election__FailedToAddCandidate();
        }
        emit Voted(_candidateId);
    }

    function getResults() public {
        winnerId =  resultCalculatorAddress.calculateResult(address(ballotAddress));
        emit ResultDeclared(winnerId);
    }

    function getWinner() public view returns (uint256) {
        if(!resultDeclared){
            revert Election__ResultsNotDeclared();
        }
        return winnerId;
    }
    
}