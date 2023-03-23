// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract BillNFT is ERC721 {
    bytes32 public merkleRoot;
    mapping(uint256 => bool) public claimed;

    constructor(bytes32 _merkleRoot) ERC721("BillNFT", "BFT") {
        merkleRoot = _merkleRoot;
    }

    function claim(uint256 index, address account, bytes32[] calldata merkleProof) external {
        require(!claimed[index], "Already claimed");

        // Verify the merkle proof
        bytes32 node = keccak256(abi.encodePacked(index, account));
        require(MerkleProof.verify(merkleProof, merkleRoot, node), "Invalid proof");

        // Mark as claimed and mint the NFT
        claimed[index] = true;
        _safeMint(account, index);
    }
}