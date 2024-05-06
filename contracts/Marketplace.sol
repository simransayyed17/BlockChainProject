// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Marketplace {
    struct Item {
        uint256 id;
        string title;
        string description;
        uint256 price; // Price stored in Wei for precision
        address payable seller;
        address buyer; // Add buyer to track who purchased the item
        bool isSold;
    }

    uint256 public itemCount;
    mapping(uint256 => Item) public items;

    event ItemListed(
        uint256 indexed id,
        string title,
        string description,
        uint256 price,
        address indexed seller
    );

    event ItemPurchased(
        uint256 indexed id,
        string title,
        uint256 price,
        address indexed seller,
        address indexed buyer
    );

    function listItem(string memory _title, string memory _description, uint256 _priceInWei) public {
        require(_priceInWei > 0, "Price must be positive");

        itemCount++;
        items[itemCount] = Item(itemCount, _title, _description, _priceInWei, payable(msg.sender), address(0), false);

        emit ItemListed(itemCount, _title, _description, _priceInWei, msg.sender);
    }

    function buyItem(uint256 _id) public payable {
        require(_id > 0 && _id <= itemCount, "Item ID does not exist");
        Item storage item = items[_id];
        require(msg.sender != item.seller, "Seller cannot be buyer");  // Ensure the seller is not the buyer
        require(msg.value == item.price, "Incorrect value");
        require(!item.isSold, "Item already sold");

        item.seller.transfer(msg.value);
        item.isSold = true;
        item.buyer = msg.sender;

        emit ItemPurchased(_id, item.title, item.price, item.seller, msg.sender);
    }


    function getAllItems() public view returns (Item[] memory) {
        Item[] memory allItems = new Item[](itemCount);
        for (uint256 i = 1; i <= itemCount; i++) {
            allItems[i - 1] = items[i];
        }
        return allItems;
    }
}
