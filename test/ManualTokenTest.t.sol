// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {ManualToken} from "src/ManualToken.sol";

contract ManualTokenTest is Test {

    ManualToken public manualToken;

    function setUp() external {
        manualToken = new ManualToken();
    }

    function testManualTokenName() public view {
        assert(keccak256(abi.encodePacked(manualToken.name())) == keccak256(abi.encodePacked("Dari's token")));
    }



}