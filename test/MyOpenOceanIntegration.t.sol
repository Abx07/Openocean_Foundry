// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/MyOpenOceanIntegration.sol";
import "forge-std/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract CounterTest is Test {
    IERC20 public dai;
    MyOpenOceanIntegration public myOpenOceanIntegration;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
        myOpenOceanIntegration = new MyOpenOceanIntegration(0x6352a56caadC4F1E25CD6c75970Fa768A3304e64);
    }

    function testSwap() public {
        vm.prank(0x25B313158Ce11080524DcA0fD01141EeD5f94b81); // Replace this with your address which has tokens of the given source token 0x10350802eF8643B15596567c85a6868399C3940e 0x10350802eF8643B15596567c85a6868399C3940e (usdc bal)
        uint256 balance = dai.balanceOf(0x25B313158Ce11080524DcA0fD01141EeD5f94b81);
        console.log("Balance: ", balance / 1e18);

        dai.approve(address(myOpenOceanIntegration), 25 * 1e25); // 250000000000000000000000
        // IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F).approve(address(myOpenOceanIntegration), 25 * 1e25);
        // deal(address(dai), address(myOpenOceanIntegration), 200 * 10e18, true);
        // uint256 contractDaiBalance = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F).balanceOf(address(myOpenOceanIntegration));
        // console.log("Contract Dai Balance: ", contractDaiBalance / 1e18);
        // IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F).allowance(0x25B313158Ce11080524DcA0fD01141EeD5f94b81, address(myOpenOceanIntegration));
        // IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F).transferFrom(0x25B313158Ce11080524DcA0fD01141EeD5f94b81, address(myOpenOceanIntegration), 2000000000000000000);
        IOpenOceanCaller.CallDescription[] memory calls = new IOpenOceanCaller.CallDescription[](1);
        calls[0] = IOpenOceanCaller.CallDescription(0, 0, 0, "0x90411a3200000000000000000000000023ebcd701fd92867235aeb0174b7c444b9b2b3ad000000000000000000000000000000000000000000000000000000000000006000000000000000000000000000000000000000000000000000000000000001c00000000000000000000000006b175474e89094c44da98b954eedeac495271d0f000000000000000000000000853d955acef822db058eb8505911ed77f175b99e00000000000000000000000023ebcd701fd92867235aeb0174b7c444b9b2b3ad00000000000000000000000025b313158ce11080524dca0fd01141eed5f94b810000000000000000000000000000000000000000000034f086f3b33b6840000000000000000000000000000000000000000000000000348320a58b66f70b5f4900000000000000000000000000000000000000000000350aeaac636fc33c9e4e000000000000000000000000000000000000000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000140000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000024000000000000000000000000000000000000000000000000000000000000006a000000000000000000000000000000000000000000000000000000000000007c000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000104e5b07cdb0000000000000000000000005777d92f208679db4b9778590fa3cab3ac9e216800000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000034f086f3b33b6840000000000000000000000000000023ebcd701fd92867235aeb0174b7c444b9b2b3ad00000000000000000000000000000000000000000000000000000000000000a0000000000000000000000000000000000000000000000000000000000000002e6b175474e89094c44da98b954eedeac495271d0f000064a0b86991c6218b36c1d19d4a2e9eb0ce3606eb4800000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000003a451a74316000000000000000000000000a0b86991c6218b36c1d19d4a2e9eb0ce3606eb4800000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000034000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000040000000000000000000000000000000000000000000000000000000000000016000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000064eb5625d9000000000000000000000000a0b86991c6218b36c1d19d4a2e9eb0ce3606eb48000000000000000000000000dcef968d416a41cdac0ed8702fac8128a64241a2000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000dcef968d416a41cdac0ed8702fac8128a64241a200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000843df0212400000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000020000000000000000000000000000000000000000000000000000000000000044000000000000000000000000000000000000000000000000000000000000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000000648a6a1e85000000000000000000000000853d955acef822db058eb8505911ed77f175b99e000000000000000000000000353c1f0bc78fbbc245b3c93ef77b1dcc5b77d2a027100000000000000000000000000000000000000000350aeaac636fc33c9e4e00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008000000000000000000000000000000000000000000000000000000000000001a49f865422000000000000000000000000853d955acef822db058eb8505911ed77f175b99e00000000000000000000000000000001000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000080000000000000000000000000000000000000000000000000000000000000004400000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000800000000000000000000000000000000000000000000000000000000000000064d1660f99000000000000000000000000853d955acef822db058eb8505911ed77f175b99e00000000000000000000000025b313158ce11080524dca0fd01141eed5f94b8100000000000000000000000000000000000000000000000000000000000000010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000");
        myOpenOceanIntegration.performSwap(calls);
        // myOpenOceanIntegration.performSwap();
    }
}