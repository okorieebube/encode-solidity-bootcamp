//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "hardhat/console.sol";
import "./Proposal.sol";

contract Factory {
    Proposal[] public proposals;

    function createProposal(string memory _name) public {
        Proposal newProposal = new Proposal(_name);
        proposals.push(newProposal);
    }

    function getProposal(uint256 _proposalId) public view returns (Proposal) {
        return proposals[_proposalId];
    }
}
