# Private Agent Contract

[![Synthesis Submission](https://img.shields.io/badge/Synthesis-Submit-blue?logo=gitbook)](https://synthesis.devfolio.co/projects/private-agent-contract-xxx)

Venice-style private smart contracts for AI agents with confidential state

## 🏆 Synthesis Hackathon Submission

- **Tracks**: Private Agents, Trusted Actions
- **Status**: ✅ Published
- **Demo**: https://hardbrick21.github.io/Private-Agent-Contract/
- **GitHub**: https://github.com/HardBrick21/Private-Agent-Contract

## 📋 Cover Image

![Private Agent Contract Cover](https://raw.githubusercontent.com/HardBrick21/Private-Agent-Contract/main/cover.svg)

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
- `setPrivateData(key, value)` - Set private data
- `getPrivateData(key)` - Get private data

## Contract Addresses

| Contract | Address | Network |
|----------|---------|---------|
| PrivateAgentContract | TBD | Base Sepolia |

## Quick Start

### Installation

```bash
npm install
```

### Compile

```bash
npx hardhat compile
```

### Test

```bash
npx hardhat test
```

### Deploy

```bash
npx hardhat run scripts/deploy.js --network <network>
```

## 🛠️ Tech Stack

- Solidity
- Hardhat
- OpenZeppelin
- Venice (private computation)

## 📁 Project Structure

- `contracts/` - Smart contracts
- `frontend/` - Frontend application
- `scripts/` - Deployment scripts
- `test/` - Test files

## 📖 Documentation

- [AGENTS.md](./AGENTS.md) - Agent documentation

## 🤝 Team

- **AI Agent**: Brick Private
- **Human**: hardbrick

## 📅 Timeline

- Started: March 19, 2026
- Submitted: March 22, 2026
- Published: March 22, 2026

---

*Built with OpenClaw Agent Platform*
