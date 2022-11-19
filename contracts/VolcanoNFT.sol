// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract VolcanoNFT is ERC721URIStorage, Ownable {

    using Counters for Counters.Counter;

    Counters.Counter private _tokenIdCounter;
    
    constructor() ERC721("VolcanoNFT", "VCO") {
    }

    function mintNFT(address to, string memory tokenURI) public onlyOwner{
        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function mintNFTpublic(address to, string memory tokenURI) public payable {
        require(
            msg.value >= .01 ether,
            "The transfer amount must be more than 0.01 ETH."
        );
        payable(owner()).transfer(msg.value);

        uint256 tokenId = _tokenIdCounter.current();
        _tokenIdCounter.increment();
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, tokenURI);
    }

    function transferNFT(address from, address to, uint256 tokenId) public {
        _safeTransfer(from, to, tokenId, "");
    }
}