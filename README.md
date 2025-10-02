# Foundry NFT Workspace Analysis

This repository is a Foundry-based Ethereum smart contract project focused on NFT (Non-Fungible Token) development and deployment. It leverages [Foundry](https://book.getfoundry.sh/) for Solidity development, testing, and scripting.

---

## Workspace Structure

```
.env
.gitignore
.gitmodules
foundry.toml
Makefile
README.md
broadcast/
cache/
images/
lib/
script/
src/
test/
```

### Key Directories & Files

- **src/**  
  Contains core smart contracts:

  - [`BasicNft.sol`](src/BasicNft.sol): A simple ERC721 NFT contract with customizable token URIs.
  - [`MoodNft.sol`](src/MoodNft.sol): An ERC721 NFT that reflects the owner's mood (happy/sad) and allows flipping the mood.

- **script/**  
  Deployment and interaction scripts:

  - [`DeployBasicNft.s.sol`](script/DeployBasicNft.s.sol): Deploys the BasicNft contract.
  - [`DeployMoodNft.s.sol`](script/DeployMoodNft.s.sol): Deploys the MoodNft contract, encoding SVG images as base64.
  - [`Interactions.s.sol`](script/Interactions.s.sol): Scripts for minting and flipping NFTs.

- **test/**  
  Contains unit and integration tests for both NFT contracts, ensuring correct deployment, minting, and mood flipping.

- **images/**  
  SVG and PNG assets used for NFT image URIs.

- **lib/**  
  External dependencies managed as git submodules:

  - `forge-std`: Foundry standard library for testing.
  - `openzeppelin-contracts`: Standard ERC contracts.
  - `foundry-devops`: DevOps utilities for Foundry.

- **Makefile**  
  Provides shortcuts for common tasks: build, test, deploy, format, and more.

- **foundry.toml**  
  Foundry configuration, including remappings and file system permissions for reading images and broadcast logs.

- **.env**  
  Stores sensitive environment variables (RPC URLs, API keys, private keys) for deployment and verification.

---

## Main Features

- **NFT Contracts**:

  - [`BasicNft`](src/BasicNft.sol): Standard mintable NFT with IPFS-based metadata.
  - [`MoodNft`](src/MoodNft.sol): NFT with dynamic mood (happy/sad), mood flipping, and on-chain SVG image encoding.

- **Deployment & Interaction**:

  - Scripts automate deployment and interaction with contracts, using Foundry's scripting capabilities and DevOps tools.

- **Testing**:

  - Comprehensive unit and integration tests using Forge's testing framework.

- **Image Handling**:
  - SVG images are read from the `images/` directory, encoded to base64, and embedded in NFT metadata.

---

## Usage

### Install Dependencies

```sh
make install
```

### Build Contracts

```sh
make build
```

### Run Tests

```sh
make test
```

### Deploy Contracts

```sh
make deploy
```

### Mint and Flip NFTs

```sh
make mint
make mintMoodNft
make flipMoodNft
```

### Format Code

```sh
make format
```

---

## Security

- **.env** contains sensitive keys. Do not commit this file to public repositories.
- Uses OpenZeppelin contracts for security best practices.

---

## References

- [Foundry Book](https://book.getfoundry.sh/)
- [OpenZeppelin Contracts](https://github.com/OpenZeppelin/openzeppelin-contracts)
- [Forge Standard Library](https://github.com/foundry-rs/forge-std)

---
