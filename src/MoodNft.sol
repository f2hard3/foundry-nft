// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    // errors
    error MoodNft__CantFlipMoodIfNotOwner();

    uint256 private s_tokenCounter;
    string private s_sadSvgImageUri;
    string private s_happySvgImageUri;

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory sadSvgImageUri,
        string memory happySvgImageUri
    ) ERC721("Mood NFT", "MN") {
        s_sadSvgImageUri = sadSvgImageUri;
        s_happySvgImageUri = happySvgImageUri;
        s_tokenCounter = 0;
    }

    function mintNft() external {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;

        s_tokenCounter++;
    }

    function _isAuthorized(
        address spender,
        uint256 tokenId
    ) internal view returns (bool) {
        address owner = ERC721.ownerOf(tokenId); // Get the actual owner of the token

        // Case 1: Spender is the owner
        if (spender == owner) {
            return true;
        }

        // Case 2: Spender is approved for this specific tokenId
        if (ERC721.getApproved(tokenId) == spender) {
            return true;
        }

        // Case 3: Spender is an operator approved for all tokens by the owner
        if (ERC721.isApprovedForAll(owner, spender)) {
            return true;
        }

        return false;
    }

    function flipMood(uint256 tokenId) external {
        if (!_isAuthorized(msg.sender, tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            s_tokenIdToMood[tokenId] = Mood.SAD;
        } else {
            s_tokenIdToMood[tokenId] = Mood.HAPPY;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(
        uint256 tokenId
    ) public view override returns (string memory) {
        string memory imageURI;

        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageURI = s_happySvgImageUri;
        } else {
            imageURI = s_sadSvgImageUri;
        }

        string memory dataURI = string.concat(
            '{"name": "',
            name(),
            '"',
            '"description": "An NFT that reflects the owners mood."',
            '"attributes": [{"trait_type": "moodiness", "value": 100}], "image": "',
            imageURI,
            '"}'
        );

        return string.concat(_baseURI(), Base64.encode(bytes(dataURI)));
    }
}
