// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract Voting {
  
  mapping (string => uint8) public votesReceived;
  address[] public votersWhoVoted;
  string[] public candidateList;

  constructor(string[] memory candidateNames) {
    candidateList = candidateNames;
  }

  // This function returns the total votes a candidate has received so far
  function totalVotesFor(string memory candidate) view public returns (uint8) {
    require(validCandidate(candidate));
    return votesReceived[candidate];
  }

  // This function increments the vote count for the candidate. This
  // is equivalent to casting a vote
  function voteForCandidate(string memory candidate) public {
    require(validCandidate(candidate));
    require(hasNotVoted(msg.sender), "You have already Voted");
    votersWhoVoted.push(msg.sender);
    votesReceived[candidate] += 1;
  }

  function validCandidate(string memory candidate) view public returns (bool) {
    for(uint i = 0; i < candidateList.length; i++) {
      if (keccak256(abi.encodePacked(candidateList[i])) == keccak256(abi.encodePacked(candidate))) {
        return true;
      }
    }
    return false;
  }

  function hasNotVoted(address voter) view internal returns (bool){
    for(uint i = 0; i < votersWhoVoted.length; i++) {
        if(voter == votersWhoVoted[i]){
            return false;
        }
    }
    return true;
  }
}