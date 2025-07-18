// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {DeployMoodNft} from "../../script/DeployMoodNft.s.sol";
import {MoodNft} from "../../src/MoodNft.sol";

contract DeployMoodNftTest is Test {
    DeployMoodNft private deployer;
    MoodNft private moodNft;

    address private immutable USER = makeAddr("user");

    function setUp() external {
        deployer = new DeployMoodNft();
    }

    function testConvertSvgToUri() external view {
        // Arrange
        string
            memory expectedUri = "data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHdpZHRoPSI1MDAiIGhlaWdodD0iNTAwIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0iYmxhY2siPmhpISB5b3VyIGJyb3dzZXIgZGVjb2RlZCB0aGlzITwvdGV4dD48L3N2Zz4=";
        string
            memory svg = '<svg xmlns="http://www.w3.org/2000/svg" width="500" height="500"><text x="0" y="15" fill="black">hi! your browser decoded this!</text></svg>';

        // Act
        string memory actualUri = deployer.svgToImageUri(svg);

        // Assert
        assertEq(expectedUri, actualUri);
    }
}
