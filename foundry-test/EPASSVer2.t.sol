// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import "../contracts/EPASSVer1.sol";
import "../contracts/EPASSVer2.sol";
import "@openzeppelin/contracts/proxy/transparent/ProxyAdmin.sol";
import "@openzeppelin/contracts/proxy/transparent/TransparentUpgradeableProxy.sol";

contract TestEPASSVer2 is Test {
    ProxyAdmin public proxyAdmin;
    TransparentUpgradeableProxy public proxy;
    EPASSVer1 public impV1;
    EPASSVer2 public impV2;
    EPASSVer1 public epassV1;
    EPASSVer2 public epassV2;

    uint256 public constant MINT_LIMIT = 20000;

    function setUp() public {
        // Deploy contract
        impV1 = new EPASSVer1();
        impV2 = new EPASSVer2();
        proxyAdmin = new ProxyAdmin();
        bytes memory data = abi.encodePacked(EPASSVer1.initialize.selector);
        proxy = new TransparentUpgradeableProxy(address(impV1), address(proxyAdmin), data);
        // Cast contract to implementation
        epassV1 = EPASSVer1(address(proxy));
        epassV2 = EPASSVer2(address(proxy));
        // Prepapre V1
        epassV1.setMintLimit(MINT_LIMIT);
    }

    function testUpgrade() public {
        // Mint
        epassV1.adminMintTo(vm.addr(1), 10);
        assertEq(epassV1.balanceOf(vm.addr(1)), 10);
        // Upgrade
        proxyAdmin.upgrade(proxy, address(impV2));
        // Check balance
        assertEq(epassV2.balanceOf(vm.addr(1)), 10);
        
    }

    function testCallInitalizeOnImplementation() public {
        impV2.initialize();
    }
}
