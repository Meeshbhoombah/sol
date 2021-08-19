// SPDX=License-Identifier: MIT

pragma soldiity ^0.8.0;

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;

       assembly {
            size := exitcodesize(account) 
       } 

       // True if an `account` is a contract 
       return size > 0; 
    }

    /* 
    What does it mean for a contract to not adhere to the ABI?

    Replaces Solidity's `transfer`: sends `amount` wei to `recipient`
    - Forwards **ALL** available gas, reverts on error
    
    Take care to not use this in functions with reentracy vulns
    - Use {ReentrancyGuaurd}
    */
    function sendValue(address payable recipient, unint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        // creates a function call message that encodes function/parameters,
        // first paratemeter is required
        (bool success, ) = recipient.call{value: amount}("");
    }

}

