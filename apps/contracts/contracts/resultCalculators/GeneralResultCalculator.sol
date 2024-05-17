// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {IBallot} from "../ballots/IBallot.sol";
import {IResultCalculator} from "./IResultCalculator.sol";

contract GeneralResultCalculator is IResultCalculator{

    uint256[] private candidateList;
    mapping(uint256 => uint256) private candidateVotes;

    uint256 private winnerId;
    bool private resultDeclared;

    error ResultCalculator__NoWinner();

    function calculateResult() public override {
        uint256 maxVotes = 0;
        uint256 winner = candidateList.length;
        for (uint256 i = 0; i < candidateList.length; i++) {
            uint256 votes = candidateVotes[candidateList[i]];
            if (votes > maxVotes) {
                maxVotes = votes;
                winner = i;
            }
        }
        if (winner == candidateList.length) {
            revert ResultCalculator__NoWinner();
        }
        winnerId = candidateList[winner];
        resultDeclared = true;
    }

}