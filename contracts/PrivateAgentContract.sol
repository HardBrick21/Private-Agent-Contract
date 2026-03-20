// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";

/**
 * @title PrivateAgentContract
 * @notice Private smart contract for AI agents with confidential state
 * @dev Venice-style private computation with encrypted state
 */
contract PrivateAgentContract is Ownable {
    
    // ============ Enums ============
    
    enum AccessLevel {
        PUBLIC,     // 0 - Everyone can read/write
        PRIVATE,    // 1 - Only owner and authorized agents
        CONFIDENTIAL // 2 - Only owner
    }
    
    // ============ Structs ============
    
    struct AgentAccess {
        address agent;
        AccessLevel level;
        uint256 expiresAt;
        bool isActive;
    }
    
    struct PrivateData {
        bytes32 encryptedHash;  // Hash of encrypted data
        bytes32 encryptionKey;  // Encryption key hash
        uint256 createdAt;
        uint256 updatedAt;
    }
    
    // ============ State Variables ============
    
    mapping(address => AgentAccess) public agentAccess;
    mapping(bytes32 => PrivateData) public privateData;
    
    address public owner;
    uint256 public totalPrivateRecords;
    
    // ============ Events ============
    
    event AgentAuthorized(
        address indexed agent,
        AccessLevel level,
        uint256 expiresAt
    );
    
    event PrivateDataStored(
        bytes32 indexed dataId,
        address indexed agent,
        bytes32 encryptedHash
    );
    
    event PrivateDataAccessed(
        bytes32 indexed dataId,
        address indexed agent,
        bool granted
    );
    
    // ============ Constructor ============
    
    constructor() Ownable(msg.sender) {
        owner = msg.sender;
    }
    
    // ============ Agent Management ============
    
    /**
     * @notice Authorize an agent with specific access level
     * @param agent Agent address
     * @param level Access level (PUBLIC, PRIVATE, CONFIDENTIAL)
     * @param duration Duration in seconds
     */
    function authorizeAgent(
        address agent,
        AccessLevel level,
        uint256 duration
    ) external onlyOwner {
        require(agent != address(0), "Invalid agent address");
        require(level != AccessLevel.PUBLIC, "Use public contract for PUBLIC level");
        
        agentAccess[agent] = AgentAccess({
            agent: agent,
            level: level,
            expiresAt: block.timestamp + duration,
            isActive: true
        });
        
        emit AgentAuthorized(agent, level, block.timestamp + duration);
    }
    
    /**
     * @notice Revoke agent access
     */
    function revokeAgent(address agent) external onlyOwner {
        require(agent != address(0), "Invalid agent address");
        require(agentAccess[agent].isActive, "Agent not authorized");
        
        agentAccess[agent].isActive = false;
        emit AgentAuthorized(agent, AccessLevel(0), 0);
    }
    
    /**
     * @notice Check if agent has access
     */
    function hasAccess(address agent, AccessLevel requiredLevel) 
        external view returns (bool hasAccess, AccessLevel currentLevel)
    {
        AgentAccess storage access = agentAccess[agent];
        currentLevel = access.level;
        hasAccess = access.isActive && 
            uint8(access.level) >= uint8(requiredLevel) && 
            (access.expiresAt == 0 || block.timestamp < access.expiresAt);
    }
    
    // ============ Private Data Management ============
    
    /**
     * @notice Store encrypted private data
     * @param dataId Unique data identifier
     * @param encryptedHash Hash of encrypted data
     * @param encryptionKeyHash Hash of encryption key
     */
    function storePrivateData(
        bytes32 dataId,
        bytes32 encryptedHash,
        bytes32 encryptionKeyHash
    ) external {
        AgentAccess storage access = agentAccess[msg.sender];
        require(access.isActive, "Not authorized agent");
        require(access.level != AccessLevel.PUBLIC, "PUBLIC level cannot store private data");
        
        privateData[dataId] = PrivateData({
            encryptedHash: encryptedHash,
            encryptionKey: encryptionKeyHash,
            createdAt: block.timestamp,
            updatedAt: block.timestamp
        });
        
        totalPrivateRecords++;
        
        emit PrivateDataStored(dataId, msg.sender, encryptedHash);
    }
    
    /**
     * @notice Access private data (with authorization check)
     * @param dataId Data identifier
     * @param requestedLevel Requested access level
     */
    function accessPrivateData(
        bytes32 dataId,
        AccessLevel requestedLevel
    ) external returns (bool granted, bytes32 encryptedHash) {
        AgentAccess storage access = agentAccess[msg.sender];
        require(access.isActive, "Not authorized agent");
        
        PrivateData storage data = privateData[dataId];
        require(data.encryptedHash != bytes32(0), "Data not found");
        
        // Check access level
        granted = uint8(access.level) >= uint8(requestedLevel);
        
        emit PrivateDataAccessed(dataId, msg.sender, granted);
        
        return (granted, data.encryptedHash);
    }
    
    /**
     * @notice Update private data
     */
    function updatePrivateData(
        bytes32 dataId,
        bytes32 newEncryptedHash,
        bytes32 newEncryptionKeyHash
    ) external {
        AgentAccess storage access = agentAccess[msg.sender];
        require(access.isActive, "Not authorized agent");
        
        PrivateData storage data = privateData[dataId];
        require(data.encryptedHash != bytes32(0), "Data not found");
        
        data.encryptedHash = newEncryptedHash;
        data.encryptionKey = newEncryptionKeyHash;
        data.updatedAt = block.timestamp;
        
        emit PrivateDataStored(dataId, msg.sender, newEncryptedHash);
    }
    
    /**
     * @notice Delete private data
     */
    function deletePrivateData(bytes32 dataId) external {
        AgentAccess storage access = agentAccess[msg.sender];
        require(access.isActive, "Not authorized agent");
        require(access.level == AccessLevel.CONFIDENTIAL, "Need CONFIDENTIAL level");
        
        PrivateData storage data = privateData[dataId];
        require(data.encryptedHash != bytes32(0), "Data not found");
        
        delete privateData[dataId];
        
        emit PrivateDataStored(dataId, msg.sender, bytes32(0));
    }
    
    // ============ View Functions ============
    
    /**
     * @notice Get agent access info
     */
    function getAgentAccess(address agent) external view returns (AgentAccess memory) {
        return agentAccess[agent];
    }
    
    /**
     * @notice Get private data info
     */
    function getPrivateData(bytes32 dataId) external view returns (PrivateData memory) {
        return privateData[dataId];
    }
    
    /**
     * @notice Check if data exists
     */
    function dataExists(bytes32 dataId) external view returns (bool) {
        return privateData[dataId].encryptedHash != bytes32(0);
    }
    
    // ============ Owner Functions ============
    
    /**
     * @notice Set owner (transfer control)
     */
    function setOwner(address newOwner) external onlyOwner {
        require(newOwner != address(0), "Invalid address");
        owner = newOwner;
    }
    
    /**
     * @notice Get contract owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
}
