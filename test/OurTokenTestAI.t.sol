// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import {DeployOurToken} from "../script/DeployOurToken.s.sol";
import {OurToken} from "../src/OurToken.sol";
import {Test, console} from "forge-std/Test.sol";
import {StdCheats} from "forge-std/StdCheats.sol";

interface MintableToken {
    function mint(address, uint256) external;
}

contract OurTokenTestAI is StdCheats, Test {
    OurToken public ourToken;
    DeployOurToken public deployer;
    address public user1;
    address public user2;


    uint256 public constant INITIAL_SUPPLY = 1000 * 10 ** 18;

    function setUp() public {
        deployer = new DeployOurToken();
        ourToken = deployer.run();
        user1 = address(0x123);
        user2 = address(0x456);
        // Label the addresses for easier debugging
        vm.label(user1, "User1");
        vm.label(user2, "User2");
    }

    function testInitialSupply() public view {
        assertEq(ourToken.totalSupply(), deployer.INITIAL_SUPPLY());
    }

    function testUsersCantMint() public {
        vm.expectRevert();
        MintableToken(address(ourToken)).mint(address(this), 1);
    }

    function testAllowance() public {
        // Check initial allowance (should be 0)
        assertEq(ourToken.allowance(address(this), user1), 0);
        
        // Approve an allowance
        uint256 amount = 100 * 10 ** ourToken.decimals();
        ourToken.approve(user1, amount);
        assertEq(ourToken.allowance(address(this), user1), amount);
    }


    function testIncreaseDecreaseAllowance() public {
        // Increase allowance
        uint256 increaseAmount = 500 * 10 ** ourToken.decimals();
        ourToken.increaseAllowance(user1, increaseAmount);
        assertEq(ourToken.allowance(address(this), user1), increaseAmount);
        
        // Decrease allowance
        uint256 decreaseAmount = 300 * 10 ** ourToken.decimals();
        ourToken.decreaseAllowance(user1, decreaseAmount);
        assertEq(ourToken.allowance(address(this), user1), increaseAmount - decreaseAmount);
    }

}
