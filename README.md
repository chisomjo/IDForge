# IDForge

## Overview

IDForge is a decentralized identity verification smart contract built on the Stacks blockchain. It allows users to register, verify, and manage their identities securely without relying on centralized authorities. By leveraging blockchain transparency and immutability, IDForge ensures that identity data remains tamper-proof, user-controlled, and verifiable.

## Key Features

* **Identity Registration**: Users can register their name and email address directly on the blockchain.
* **Identity Verification**: The contract owner can verify registered users to confirm authenticity.
* **Identity Management**: Users retain control over their identity data and can delete it at any time.
* **Secure Access**: Only the contract owner has the authority to verify identities, preventing unauthorized actions.
* **On-Chain Retrieval**: Anyone can query the blockchain to check the registration and verification status of a user.

## Contract Components

1. **Data Structures**

   * `identities`: A map that stores user identity information including name, email, and verification status.

2. **Error Handling**

   * `ERR_UNAUTHORIZED`: Thrown when a non-owner attempts restricted actions.
   * `ERR_ALREADY_VERIFIED`: Thrown when a user attempts to register an identity that already exists.
   * `ERR_NOT_FOUND`: Thrown when the requested identity does not exist.

3. **Public Functions**

   * `register-identity(name, email)`: Allows users to register their identity.
   * `verify-identity(user)`: Enables the contract owner to verify a user’s identity.
   * `delete-identity()`: Allows users to remove their identity from the system.

4. **Read-Only Functions**

   * `get-identity(user)`: Retrieves a user’s identity information.

## Usage

1. **Register an Identity**

   ```clarity
   (contract-call? .idforge register-identity "Alice" "alice@example.com")
   ```

2. **Verify an Identity** (Owner only)

   ```clarity
   (contract-call? .idforge verify-identity 'ST1234...)
   ```

3. **Get Identity Information**

   ```clarity
   (contract-call? .idforge get-identity 'ST1234...)
   ```

4. **Delete Identity**

   ```clarity
   (contract-call? .idforge delete-identity)
   ```

## Security Considerations

* Only the designated contract owner can perform identity verification.
* Users maintain control of their identity and may delete it at will.
* Data is stored on-chain, so sensitive information should be used carefully.