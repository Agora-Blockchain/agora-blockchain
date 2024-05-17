// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/proxy/Clones.sol";
import {Election} from "./Election.sol";

contract ElectionFactory is Ownable {

    address private immutable electionImplementation;
    mapping(uint256=>address) public ballotIdToType;
    mapping(uint256=>address) public resultCalculatorIdToType;

    event ElectionCreated(address electionAddress);

    constructor() Ownable(msg.sender) {
        electionImplementation = address(new Election());
    }

    function addBallotType(uint256 ballotId, address ballotType) public onlyOwner {
        ballotIdToType[ballotId] = ballotType;
    }

    function addResultCalculatorType(uint256 resultCalculatorId, address resultCalculatorType) public onlyOwner {
        resultCalculatorIdToType[resultCalculatorId] = resultCalculatorType;
    }

    function createElection(uint256 ballotId,uint256 resultCalculatorId) public onlyOwner {
        address electionAddress = Clones.clone(electionImplementation);
        Election(electionAddress).initialize(ballotIdToType[ballotId], resultCalculatorIdToType[resultCalculatorId]);
        emit ElectionCreated(electionAddress);
    }
   
}
