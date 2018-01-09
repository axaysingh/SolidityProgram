pragma solidity ^0.4.0;
contract Subcurrency {
 // The "public" keyword allows external accounts to read the variable
 address public minter;
 uint sum;
 mapping (address => uint) public coinBalances;
 // Light clients can react on changes efficiently thanks to events.
 event Sent(address from, address to, uint sum);
 // The code of this constructor is run only once the contract is created.
 function Coin() {
 minter = msg.sender;
 }
 function mint(address receiver, uint sum) {
 if (msg.sender != minter) return;
 coinBalances[receiver] += sum;
 }
 function send(address receiver, uint amount) {
 if (coinBalances[msg.sender] < sum) return;
 coinBalances[msg.sender] -= sum;
 coinBalances[receiver] += sum;
 Sent(msg.sender, receiver, sum);
 }
 
 function coinBalances(address _account) returns (uint) {
 return coinBalances[_account];
}
Coin.Sent().watch({}, '', function(error, result) {
 if (!error) {
 console.log("Coin transfer: " + result.args.amount +
 " coins were sent from " + result.args.from +
 " to " + result.args.to + ".");
 console.log("Coin balances now:\n" +
 "Sender: " + Coin.coinBalances.call(result.args.from) +
 "Receiver: " + Coin.coinBalances.call(result.args.to));
 }
})
}