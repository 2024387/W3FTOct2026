// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleBank {
    mapping(address => uint256) private balances;
    
    // Deposit Ether into the bank
    function deposit() public payable {
        balances[msg.sender] += msg.value;
    }
    
    // Check your balance
    function getBalance() public view returns (uint256) {
        return balances[msg.sender];
    }
    
    // Withdraw your Ether
    function withdraw(uint256 amount) public {
        // 1. Check user balance in our internal ledger
        require(balances[msg.sender] >= amount, "Insufficient balance");

        // 2. Effects (update state before external call)
        balances[msg.sender] -= amount;

        // 3. Interaction: send Ether via call
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Transfer failed");
    }
}
