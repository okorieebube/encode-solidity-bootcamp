//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";

contract Proposal {
    enum Stage {
        PROPOSED,
        VOTING,
        ACCEPTED,
        REJECTED
    }

    Stage public currentStage;
    string public name;
    uint256 public vote;

    constructor(string memory _name) {
        name = _name;
    }
}
