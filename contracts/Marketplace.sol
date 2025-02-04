// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A contract for creating and managing a marketplace for items
contract Marketplace {
    // Structure to store information about an item
    struct Item {
        uint256 id;                // Unique identifier for the item
        string title;              // Title 
        string description;        // Description 
        uint256 price;             // Price in Wei 
        address payable seller;    // Address of the seller, which is payable
        address buyer;             // Address of the buyer
        bool isSold;               // Status to check if the item is sold
    }

    uint256 public itemCount;                  // Counter to keep track of number of items listed
    mapping(uint256 => Item) public items;     // Mapping from item ID to the Item struct

    // event for listing item
    event ItemListed(               
        uint256 indexed id,
        string title,
        string description,
        uint256 price,
        address indexed seller
    );

    // even for buying item
    event ItemPurchased(                
        uint256 indexed id,
        string title,
        uint256 price,
        address indexed seller,
        address indexed buyer
    );

    // Function to list an item on the marketplace with title, description and price
    function listItem(string memory _title, string memory _description, uint256 _priceInWei) public {
        require(_priceInWei > 0, "Price must be positive"); // Ensure the price is greater than 0
        // price is converted from wei to eth in frontend

        itemCount++;  // Increment the count of items

        // Create a new item and add it to the map
        items[itemCount] = Item(itemCount, _title, _description, _priceInWei, payable(msg.sender), address(0), false);

        // Emit an event for the newly listed item
        emit ItemListed(itemCount, _title, _description, _priceInWei, msg.sender);
    }

    // Function to buy an item 
    function buyItem(uint256 _id) public payable {
        require(_id > 0 && _id <= itemCount, "Item ID does not exist"); // Check if item ID is valid
        Item storage item = items[_id];
        require(msg.sender != item.seller, "Seller cannot be buyer");  // The seller should not be able to buy their own item
        require(msg.value == item.price, "Incorrect value");           // Check if the correct amount of Ether is sent
        require(!item.isSold, "Item already sold");                    // Check if the item is already sold

        item.seller.transfer(msg.value);  // Transfer the amount to the seller
        item.isSold = true;               // Mark the item as sold
        item.buyer = msg.sender;          // Record the buyer's address

        // Emit an event for the purchase
        emit ItemPurchased(_id, item.title, item.price, item.seller, msg.sender);
    }
    
}
