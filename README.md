# Sliding Doors

This project demonstrates how different initial design choices impact code evolution as requirements change over time.

## Purpose

The repository contains two branches that diverge from a common starting point, each taking a different architectural approach to solving the same problem. As new requirements are added, the branches evolve independently, allowing us to compare how well each design accommodates change.

## Design Approaches

1. **Service Object Approach**: Implements business logic using a dedicated service object
2. **OOP Approach**: Uses a more object-oriented design with behavior distributed across domain objects

## Requirements Evolution

The project tracks how the code changes through the following requirement stages:

### R0: Initial State
User has a couple of addresses. We choose which address to write to based on whether the shipping address is complete. If not complete, fallback to using the billing address.

### R1: Multi-Geo Support
Add support for multiple countries. The rules for whether an address is usable now vary based on the country.

### R2: Merchant Addresses
Introduce a Merchant model that also has addresses. A Merchant has a registered address which should take priority over other addresses.

### R3: Address Normalization
Split addresses out from the User model into their own table for better data modeling.

### R4: Address Book
Add the concept of an AddressBook to manage multiple addresses per entity.

## Comparing the Branches

By examining commits across branches at each requirement stage, you can see:
- How much code needed to change
- Where complexity accumulated
- Which design was more resilient to each type of change
- The trade-offs between different architectural approaches
