const { MerkleTree } = require('merkletreejs');
const keccak256 = require('keccak256');

// The whitelisted addresses
const addresses = [
  '0x3b3fbF9050e9C0753AD85Ac1344bC917338877B1',
  '0x0E807B38bb9d54487fAF50e2177ab39BaaD59D33',
  '0x3d256a306675839f389B55E458D3bF899aae1F17',
  
];

// Generate the leaves of the Merkle Tree
const leaves = addresses.map((address, index) => keccak256(Buffer.from(index + address.slice(2), 'hex')));

// Create the Merkle Tree
const tree = new MerkleTree(leaves, keccak256);

// Get the Merkle Root
const merkleRoot = tree.getHexRoot();