// SPDX=License-Identifier: MIT

pragma soldiity ^0.8.0;

library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;

        assembly {
            size := extcodesize(account) 
        } 

        // The size of the
        return size > 0; 
    }

    /* 
    What does it mean for a contract to not adhere to the ABI?

    Replaces Solidity's `transfer`: sends `amount` wei to `recipient`
    - Forwards **ALL** available gas, reverts on error
    - Deals w/ EIP 1884:
        + Increases gas cost of certain opcodes
            * Potentially makes contract exceed 2300 gas limit for `transfer`
        + sendValue provides an alternative

        Take care to not use this in functions with reentracy vulns
        - Use {ReentrancyGuaurd}
     */
    function sendValue(address payable recipient, unint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        // creates a function call message that encodes function/parameters,
        // first paratemeter is required
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

}

