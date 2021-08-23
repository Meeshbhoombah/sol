// SPDX=License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

library Address {
    /**
    Within the EVM, addresses for externally owned account === smart contract

    A design goal of Ethereum is be impartial in treatment to accounts. As a 
    result, there exists no function to determine if a particular address is 
    a contract. This function returns true if, and only if there exists a 
    constructed contract at the given account address.
    */
    function isContract(address account) internal view returns (bool) {
        uint256 size;

        assembly {
            // `extcodesize` is the Opcode for the length of the account's 
            // contract bytecode
            size := extcodesize(account) 
        } 

        // During construction, the contract bytecode is initalized with 0,
        // after which, it is filled in with the length, which is greater than
        // 0 by default, thus returning true for all constructed contracts
        return size > 0; 
    }

    /**
    Solidity's default transfer forwards a fixed amount of gas 
    */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        // creates a function call message that encodes function/parameters,
        // first paratemeter is required
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

}

