// SPDX-License-Identifier: MIT
pragma solidity ^0.8.31;

contract EtherWallet {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable { }

    function withdraw(uint256 _amount) external {
        require(msg.sender == owner, "Caller is not Owner!");
        //payable(msg.sender).transfer(_amount);
        (bool sent,) = msg.sender.call{value: _amount}("");
        require(sent,"Failed to sent Ether!");
    }

    function getBalance() external view returns(uint256) {
        return address(this).balance;
    }
}