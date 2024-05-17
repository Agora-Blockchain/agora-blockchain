// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IBallot} from "../ballots/IBallot.sol";
import {IResultCalculator} from "./IResultCalculator.sol";

contract ResultCalculator is IResultCalculator{

    error ResultCalculator__NoWinner();

    function calculateResult(address ballotAddress) public view override returns (uint256) {
        IBallot ballot = IBallot(ballotAddress);
        uint256[] memory candidateList = ballot.getCandidateList();
        uint256 maxVotes = 0;
        uint256 winnerId = candidateList.length;
        for (uint256 i = 0; i < candidateList.length; i++) {
            uint256 candidateVotes = ballot.getCandidateVotes(candidateList[i]);
            if (candidateVotes > maxVotes) {
                maxVotes = candidateVotes;
                winnerId = i;
            }
        }
        if (winnerId == candidateList.length) {
            revert ResultCalculator__NoWinner();
        }
        return candidateList[winnerId];
    }

}