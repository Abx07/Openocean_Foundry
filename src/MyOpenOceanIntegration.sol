// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

interface IOpenOceanCaller {
    struct CallDescription {
        uint256 target;
        uint256 gasLimit;
        uint256 value;
        bytes data;
    }

    function makeCall(CallDescription memory desc) external;

    function makeCalls(CallDescription[] memory desc) external payable;
}
struct SwapDescription {
    IERC20 srcToken;
    IERC20 dstToken;
    address srcReceiver;
    address dstReceiver;
    uint256 amount;
    uint256 minReturnAmount;
    uint256 guaranteedAmount;
    uint256 flags;
    address referrer;
    bytes permit;
}

// Interface for the IOpenOceanCaller contract
interface IOpenOceanCallerSwap {
    function swap(
        IOpenOceanCaller caller,
        SwapDescription calldata desc,
        IOpenOceanCaller.CallDescription[] calldata calls
    ) external payable returns (uint256 returnAmount);
}

// Integrating OpenOcean's swap function
contract MyOpenOceanIntegration {
    // Define state variables and constructor
    address public openOceanAddress; // Address of the OpenOceanExchange contract

    constructor(address _openOceanAddress) {
        openOceanAddress = _openOceanAddress;
    }

    // Function to perform a swap using OpenOcean's swap function
    function performSwap(
        // IOpenOceanCaller caller,
        // SwapDescription calldata desc,
        IOpenOceanCaller.CallDescription[] calldata calls
    ) external payable returns (uint256) {
        IOpenOceanCaller caller = IOpenOceanCaller(msg.sender);
        SwapDescription memory desc = SwapDescription(
            IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F), // Source token contract address
            IERC20(0x853d955aCEf822Db058eb8505911ED77F175b99e), // Destination token contract address
            msg.sender, // Source token receiver (user's address)
            address(this), // Destination token receiver (this contract's address)
            250000000000000000000000, // Amount of source tokens to swap
            250397318010102958899408, // Minimum return amount (0 means no minimum)
            250522579299752835317066, // Guaranteed amount (0 means no guarantee)
            2, // Flags (set to 0)
            0x5521C3dfd563d48cA64e132324024470f3498526, // Referrer (set to 0x0)
            new bytes(0) // Permit (empty bytes array)
        );

        // Check the user's balance and allowance
        // uint256 balanceOfUser = desc.srcToken.balanceOf(msg.sender);
        // // console.log("balanceOfUser");
        // // console.log(balanceOfUser);

        // uint256 allowance = desc.srcToken.allowance(msg.sender, address(this));
        // console.log("allowance");
        // console.log(allowance);

        // Ensure allowance and balance are sufficient
        // require(allowance >= desc.amount, "Allowansce not sufficient");
        // require(balanceOfUser >= desc.amount, "Balance not sufficient");

        // Transfer tokens from the user to this contract
        require(
            desc.srcToken.transferFrom(msg.sender, address(this), desc.amount),
            "Transfer failed"
        );

        // Checking the contract's balance after the transfer
        // uint256 contractBalance = desc.srcToken.balanceOf(address(this));
        // console.log("contractBalance");
        // console.log(contractBalance);

        // Approve the OpenOcean contract to spend the tokens
        require(
            desc.srcToken.approve(openOceanAddress, desc.amount),
            "Approval failed"
        );

        // Defining call descriptions
        // IOpenOceanCaller.CallDescription[] memory callDescriptions = calls;

        // Defining call descriptions with the inputs
        // IOpenOceanCaller.CallDescription[]
        //     memory calls = new IOpenOceanCaller.CallDescription[](1);
        // calls[0] = IOpenOceanCaller.CallDescription(
        //     0,
        //     0,
        //     0,
        //     hex"eb5625d90000000000000000000000006b175474e89094c44da98b954eedeac495271d0f00000000000000000000000089b78cfa322f6c5de0abceecab66aee45393cc5a0000000000000000000000000000000000000000000034f086f3b33b68400000"
        // );

        // Calling the OpenOcean swap function
        // uint256 returnAmount = caller.swap{value: msg.value}(desc, calls);

        // Calling the swap function from the IOpenOceanCallerSwap contract
        uint256 returnAmount = IOpenOceanCallerSwap(openOceanAddress).swap(
            caller,
            desc,
            calls
        );
        // console.log("returnAmount");
        // console.log(returnAmount);
        return returnAmount;
    }
}
