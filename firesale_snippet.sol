// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Firesale {

    
    function swapWETHforFETH(
        uint256 amountIn,
        uint256 amountOut,
        address[] calldata tokens,
        uint256[] calldata amounts
    ) external payable {
        uint256 ethReceived = msg.value;

        // Swap Logic: transfer WETH from user to this contract
        WETH.transferFrom(msg.sender, address(this), amountIn);

        if (fireSale) {
            // condition for returning or not returning tokens to user

            // Swap Logic: transfer FETH from this contract to user
            FETH.transfer(msg.sender, amountOut);

            //send tokens back to user
            _giveBack(msg.sender, tokens, amounts);

            //send eth back to user
            msg.sender.call{value: ethReceived}("");
        }
    }
}
