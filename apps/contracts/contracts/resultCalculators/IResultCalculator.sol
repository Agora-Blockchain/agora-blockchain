// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

interface ResultCalculator {
    function calculateResult(address ballotAddress) external view returns (uint256);
}