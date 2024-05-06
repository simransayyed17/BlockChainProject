# CS5833 
# BlockChains and Cryptocurrencies Project
By: Simran Sayyed.

# Decentralized Marketplace
This project is a marketplace that enables users to list water items for sale and purchase them using Ethereum, interacting directly with the Ethereum blockchain via smart contracts.

## Features

- **Connect to MetaMask**: Users can connect their MetaMask wallet to interact with the marketplace.
- **List Items**: Users can list items for sale by specifying the title, description, and price.
- **Purchase Items**: Users can buy listed items using Ethereum.
- **Address of seller and buyer**: Users can view the wallet address of the seller and buyer.
- **Transaction History**: Users can view transaction hashes linked to Etherscan for both listing and purchasing activities.

## Technologies Used

- **HTML/CSS**: For the frontend presentation.
- **JavaScript**: For the interactive elements of the frontend.
- **Solidity**: For writing the Ethereum smart contracts.
- **Remix IDE**: For developing and deploying smart contracts.
- **Ethers.js**: A library to interact with Ethereum blockchain from the web browser.
- **Netlify**: For hosting the frontend.

## Setup and Installation

### Requirements

- [Node.js](https://nodejs.org/)
- [Git](https://git-scm.com/)
- [MetaMask](https://metamask.io/) extension installed in your web browser.

### Smart Contract Development
The smart contracts are developed in Solidity using Remix IDE. Here are steps to deploy and test the smart contracts:

Open Remix IDE.
Create a new file and copy the Solidity code from the repository.
Compile the contract using the Solidity Compiler in Remix.
Deploy the contract on an environement - Injected Provider - Metamask.
Update the deployed contract ABI and contract address in the frontend application.
