// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.2 <0.9.0;

// For these type of contracts - Can I Deploy NFT's via this contract itself ? - Best way to test as address keeps changing

// Have not included the ERC721 but still this works contract ERC721EnumerablePrime is ERC721, ERC721Enumerable
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

// Why do I need to inherit ERC721 when ERC721Enumerable already inherits ERC721
contract ERC721EnumerablePrime is ERC721, ERC721Enumerable {
    constructor() ERC721("NFTPRIME", "NFTPRIME") {}

    // Since only 1-20 TokenIds are allowed, is there a better way to accomplish the former
    modifier checkTokenIdValidity(uint8 tokenId) {
        require(tokenId >= 1 && tokenId <= 20, "TokenId not in range");
        _;
    }

    // Try the ERC721Consecutive.sol
    function mint(uint8 tokenId) external checkTokenIdValidity(tokenId) {
        super._mint(msg.sender, tokenId);
    }

    // Read more about this - if implemented in 2 parents why not call from the first super
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 tokenId,
        uint256 batchSize
    ) internal override(ERC721, ERC721Enumerable) {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    // Read more about this - if implemented in 2 parents why not call from the first super
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721Enumerable) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
