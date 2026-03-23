# Private Agent Contract

> Venice-style private smart contracts for AI agents with confidential state

## Overview

This project implements private smart contracts for AI agents using Venice-style private computation. Agents can maintain private state, execute confidential transactions, and interact with other agents while preserving privacy.

## Why Private Agent Contracts?

- **Confidential State**: Private data encrypted on-chain
- **Access Control**: Fine-grained permissions for agents
- **Privacy-Preserving**: Venice-style private computation
- **Agent-Native**: Designed specifically for autonomous agents

## Key Features

1. **Access Levels**: PUBLIC, PRIVATE, CONFIDENTIAL
2. **Agent Authorization**: Grant/revoke access with expiration
3. **Private Data Storage**: Encrypted state management
4. **Private Transfers**: Encrypted balance transfers between agents

## Smart Contracts

### PrivateAgentContract

Manages agent access and private data storage.

**Functions:**
- `authorizeAgent(agent, level, duration)` - Authorize agent with access level
- `revokeAgent(agent)` - Revoke agent access
- `storePrivateData(dataId, encryptedHash, encryptionKeyHash)` - Store encrypted data
- `accessPrivateData(dataId, requestedLevel)` - Access private data
- `updatePrivateData(dataId, newEncryptedHash, newEncryptionKeyHash)` - Update data
- `deletePrivateData(dataId)` - Delete data (CONFIDENTIAL only)

### PrivateAgentWallet

Manages private agent wallets with encrypted balances.

**Functions:**
- `createWallet()` - Create private wallet
- `deposit(amount)` - Deposit funds
- `createPrivateTransfer(to, amount, encryptionKey)` - Create transfer
- `executePrivateTransfer(transferId)` - Execute transfer
- `getBalance(agent)` - Get encrypted balance

## Access Levels

| Level | Name | Description |
|-------|------|-------------|
| 0 | PUBLIC | Everyone can read/write |
| 1 | PRIVATE | Only owner and authorized agents |
| 2 | CONFIDENTIAL | Only owner |

## 🌐 Live Demo

**GitHub Pages**: [https://hardbrick21.github.io/Private-Agent-Contract/](https://hardbrick21.github.io/Private-Agent-Contract/)

### Demo Features

The live demo allows you to:
- 🔗 **Connect Wallet** - Connect your MetaMask wallet
- 🔐 **Authorize Agent** - Authorize agents with access levels (PRIVATE, CONFIDENTIAL)
- 📝 **Store Private Data** - Store encrypted private data
- 🔍 **Access Private Data** - Access private data with authorization check
- ⚠️ **Revoke Agent** - Revoke agent access

### How to Use the Demo

1. Open the [demo page](https://hardbrick21.github.io/Private-Agent-Contract/)
2. Click "Connect Wallet" and approve the connection
3. Use the forms to interact with the smart contract
4. View transaction logs in real-time

---

*Private Agent Contract - Venice-style privacy for autonomous agents.*