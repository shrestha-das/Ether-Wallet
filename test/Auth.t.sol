// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test} from "forge-std/Test.sol";
import {EtherWallet} from "src/EtherWallet.sol";

contract AuthTest is Test {
    EtherWallet public etherWallet;

    function setUp() external {
        etherWallet = new EtherWallet();
    }

    function testSetOwner() external {
        etherWallet.setOwner(address(1));
        assertEq(etherWallet.owner(), address(1));
    }

    function test_ReverIf_NotOwner() external {
        vm.prank(address(2));
        vm.expectRevert();
        etherWallet.setOwner(address(1));
    }

    function test_RevertIf_SetOwnerAgain() external {
        // msg.sender = address(this).balance;
        etherWallet.setOwner(address(1));

        vm.startPrank(address(1));

        etherWallet.setOwner(address(1));
        etherWallet.setOwner(address(1));
        etherWallet.setOwner(address(1));

        vm.stopPrank();

        // msg.sender = address(this).balance;
    }
}
