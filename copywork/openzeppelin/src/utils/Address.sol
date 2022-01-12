// SPDX=License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

library Address {
    /**
    @notice Returns true IFF a given address is a **constructed** contract

    @param    account 	The account to check for a constructed contract
    @return           	True if an account is a constracted contract, false 
			otherwise

    Within the EVM, addrs for EOAs === addrs for smart contracts, because a
    design goal of Ethereum is be impartial in treatment of accounts. As a 
    result, there exists no function to determine if a particular address is 
    a contract.

    @dev `isContract` evaluating to false does not provide any garuntees about
    the value of its inputs. E.g: among other cases, this function will return
    false for: an EOA, a contract in construction, an addr where a contract
    will be created, or an addr where a contract lived but was destroyed
    */
    function isContract(address account) internal view returns (bool) {
        uint256 size;

        assembly {
            // `extcodesize` is the Opcode for retriving the length of the 
	    // given account's contract bytecode
            size := extcodesize(account) 
        } 

        // During construction, the contract bytecode is initalized with 0,
        // after which, it is then filled in with the length, which is greater 
	// than 0 by default, thus returning true for all constructed contracts
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

