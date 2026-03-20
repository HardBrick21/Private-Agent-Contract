# AGENTS.md - Private Agent Contract

## Overview

Private Agent Contract provides Venice-style private computation for AI agents. Agents can maintain confidential state, execute private transactions, and interact with other agents while preserving privacy.

## What It Does

- **Confidential State**: Private data encrypted on-chain
- **Access Control**: Fine-grained permissions (PUBLIC, PRIVATE, CONFIDENTIAL)
- **Private Wallets**: Encrypted balance management
- **Agent-Native**: Designed specifically for autonomous agents

## How to Interact

### Smart Contract Interface

**PrivateAgentContract** (deploy on Base)

```solidity
// Authorize an agent with specific access level
function authorizeAgent(
    address agent,
    AccessLevel level,
    uint256 duration
) external onlyOwner;

// Store encrypted private data
function storePrivateData(
    bytes32 dataId,
    bytes32 encryptedHash,
    bytes32 encryptionKeyHash
) external;

// Access private data (with authorization check)
function accessPrivateData(
    bytes32 dataId,
    AccessLevel requestedLevel
) external returns (bool granted, bytes32 encryptedHash);

// Check if agent has access
function hasAccess(address agent, AccessLevel requiredLevel) 
    external view returns (bool hasAccess, AccessLevel currentLevel);
```

**PrivateAgentWallet** (deploy on Base)

```solidity
// Create a private wallet for an agent
function createWallet() external;

// Deposit funds (encrypted)
function deposit(uint256 amount) external;

// Create a private transfer
function createPrivateTransfer(
    address to,
    uint256 amount,
    bytes32 encryptionKey
) external returns (bytes32 transferId);

// Execute a private transfer
function executePrivateTransfer(bytes32 transferId) external;

// Get wallet balance
function getBalance(address agent) external view returns (uint256);
```

### Access Levels

- `0` = PUBLIC (everyone can read/write)
- `1` = PRIVATE (owner and authorized agents)
- `2` = CONFIDENTIAL (only owner)

## Network Information

| Network | Chain ID | RPC |
|---------|----------|-----|
| Base Sepolia | 84532 | https://sepolia.base.org |
| Base Mainnet | 8453 | https://mainnet.base.org |

## Integration Guide

### Grant Agent Access

```javascript
// Grant PRIVATE access for 24 hours
await contract.authorizeAgent(
  agentAddress,
  1, // PRIVATE
  86400 // 24 hours
);
```

### Store Private Data

```javascript
// Store encrypted data
await contract.storePrivateData(
  dataId,
  encryptedHash,  // Hash of encrypted data
  encryptionKeyHash  // Hash of encryption key
);
```

### Create Private Transfer

```javascript
// Create private transfer
const transferId = await wallet.createPrivateTransfer(
  recipientAddress,
  ethers.parseUnits("10", 18),  // 10 tokens
  encryptionKey
);

// Execute transfer
await wallet.executePrivateTransfer(transferId);
```

## Target Track

**Private Agents, Trusted Actions** ($5,750)

---

*Private Agent Contract - Venice-style privacy for autonomous agents.*