// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployBasicNft} from "../../script/DeployBasicNft.s.sol";
import {BasicNft} from "../../src/BasicNft.sol";

contract BasicNftTest is Test {
    DeployBasicNft private deployer;
    BasicNft private basicNft;
    address private user = makeAddr("user");
    string private constant TOKEN_URI =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() external {
        deployer = new DeployBasicNft();
        basicNft = deployer.run();
    }

    function testNameIsCorrect() external view {
        // Arrange
        string memory expectedName = "Dogie";

        // Act
        string memory actualName = basicNft.name();

        // Assert
        // assertEq(expectedName, actualName);
        assert(
            keccak256(abi.encodePacked(expectedName)) ==
                keccak256(abi.encodePacked(actualName))
        );
    }

    function testCanMintAndHaveBalance() external {
        // Arrange & Act
        vm.prank(user);
        basicNft.mintNft(TOKEN_URI);

        // Assert
        assert(basicNft.balanceOf(user) == 1);
        assert(
            keccak256(abi.encodePacked(TOKEN_URI)) ==
                keccak256(abi.encodePacked(basicNft.tokenURI(0)))
        );
    }
}
