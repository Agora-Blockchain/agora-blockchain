// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

contract GeneralResultCalculator {
    error NoWinner();

    function calculateResult(
        uint[] memory candidateList
    ) external pure returns (uint) {
        uint256 maxVotes = 0;
        uint256 winner = candidateList.length;
        for (uint256 i = 0; i < candidateList.length; i++) {
            uint256 votes = candidateList[i];
            if (votes > maxVotes) {
                maxVotes = votes;
                winner = i;
            }
        }
        if (winner == candidateList.length) {
            revert NoWinner();
        }
        return winner;
    }
}
