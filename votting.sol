pragma solidity ^0.4.11;
/// @title Voting smart contract with option to delegate.
contract Ballot {
 // This will declare a new complex data type, which we can use to represent individual voters.
 struct ballotVoter {
 uint delegateWeight; // delegateWeight is accumulated by delegation
 bool voteSpent; // if true, that person already used their vote
 address delegateTo; // the person that the voter chooses to delegate their vote to instead of voting themselves
 uint voteIndex; // index of the proposal that was voted for
 }
 // This is a type for a single proposal.
 struct Proposal {
 bytes32 proposalName; // short name for the proposal (up to 32 bytes)
 uint voteCount; // the number of votes accumulated
 }
 address public chairman;
 // Declare state variable to store a 'ballotVoter' struct for every possible address.
 mapping(address => ballotVoter) public ballotVoters;
 // A dynamically-sized array of 'Proposal' structs.
 Proposal[] public proposalsOption;
 /// New ballot for choosing one of the 'proposalNames'
 function Ballot(bytes32[] proposalNames) {
 chairman = msg.sender;
 ballotVoters[chairman].delegateWeight = 1;
 // For every provided proposal names, a new proposal object is created and added to the array's end.
 for (uint i = 0; i < proposalNames.length; i++) {
 // 'Proposal({...})' will create a temporary Proposal object 
 // 'proposalsOption.push(...)' will append it to the end of 'proposalsOption'.
 proposalsOption.push(Proposal({
 proposalName: proposalNames ,
 voteCount: 0
 }));
 }
 }
 // Give 'ballotVoter' the right to cast a vote on this ballot.
 // Can only be called by 'chairman'.
 function giveVotingRights(address ballotVoter) {
 // In case the argument of 'require' is evaluted to 'false',
 // it will terminate and revert all
 // state and Ether balance changes. It is often
 // a good idea to use this in case the functions are
 // not called correctly. Keep in mind, however, that this
 // will currently also consume all of the provided gas
 // (this is planned to change in the future).
 require((msg.sender == chairman) && !ballotVoters[ballotvoter].voteSpent && (ballotVoters[ballotvoter].delegateWeight == 0));
 ballotVoters[ballotvoter].delegateWeight = 1;
 }
 /// Delegate your vote to the voter 'to'.
 function delegateTo(address to) {
 // assigns reference
 ballotVoter storage sender = ballotVoters[msg.sender];
 require(!sender.voteSpent);
 // Self-delegation is not allowed.
 require(to != msg.sender);
 // Forward the delegation as long as
 // 'to' is delegated too.
 // In general, such loops can be very dangerous,
 // since if they run for too long, they might
 // need more gas than available inside a block.
 // In that scenario, no delegation is made
 // but in other situations, such loops might
 // cause a contract to get "stuck" completely.
 while (ballotVoters[to].delegateTo != address(0)) {
 to = ballotVoters[to].delegateTo;
 // We found a loop in the delegation, not allowed.
 require(to != msg.sender);
 }
 // Since 'sender' is a reference, this will modify 'ballotVoters[msg.sender].voteSpent'
 sender.voteSpent = true;
 sender.delegateTo = to;
 ballotVoter storage delegateTo = ballotVoters[to];
 if (delegateTo.voteSpent) {
 // If the delegated person already voted, directly add to the number of votes
 proposalsOption[delegateTo.voteIndex].voteCount += sender.delegateWeight;
 } else {
 // If the delegated did not vote yet,
 // add to her delegateWeight.
 delegateTo.delegateWeight += sender.delegateWeight;
 }
 }
 /// Give your vote (including votes delegated to you) to proposal 'proposalsOption[proposal].proposalName'.
 function voteIndex(uint proposal) {
 ballotVoter storage sender = ballotVoters[msg.sender];
 require(!sender.voteSpent);
 sender.voteSpent = true;
 sender.voteIndex = proposal;
 // If 'proposal' is out of the range of the array,
 // this will throw automatically and revert all
 // changes.
 proposalsOption[proposal].voteCount += sender.delegateWeight;
 }
 /// @dev Computes which proposal wins by taking all previous votes into account.
 function winnerProposal() constant
 returns (uint winnerProposal)
 {
 uint winnerVoteCount = 0;
 for (uint p = 0; p < proposalsOption.length; p++) {
 if (proposalsOption[p].voteCount > winnerVoteCount) {
 winnerVoteCount = proposalsOption[p].voteCount;
 winnerProposal = p;
 }
 }
 }
 /// Calls winnerProposal() function in order to acquire the index
 /// of the winner which the proposalsOption array contains and then
 /// returns the name of the winning proposal
 function winner() constant
 returns (bytes32 winner)
 {
 winner = proposalsOption[winnerProposal()].proposalName;
 }
}