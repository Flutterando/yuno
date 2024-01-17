# YuNO Architecture

## 1. Public

Encompasses all pages and subpages of the application.

- **Pages:**
  - Represents the user interface layer.
  - Should be decoupled as much as possible from non-essential UI packages.
- **Widgets:**
  - Contains visual components specific to different parts of the application.

## 2. Interactor

Encompasses business rules.

- **Atoms:**
  - Small building blocks representing atomic units of functionality.
- **Actions:**
  - Represents actions that can be performed in the system.
- **Interfaces of Repositories and Services:**
  - Defines contracts for interactions with data layers.

## 3. Data

Encompasses the execution of business rules.

- **Implementations:**
  - **Repositories and Services:**
    - Contains concrete implementations of contracts defined in the Interactor layer.
    - Responsible for interacting with external data sources such as databases or APIs.

## 4. Core

Encompasses global data for the application.

- **Themes:**
  - Defines visual styles and themes for the application.
- **Assets:**
  - Stores static resources such as images, icons, etc.
- **Widgets:**
  - Reusable components that can be used in different parts of the application.
- **Other Global Data:**
  - Includes other elements essential for the global operation of the application.

This architecture aims to clearly separate responsibilities into layers, making code maintenance, testability, and scalability easier. Each layer has a specific purpose, and dependencies are organized so that business logic is not tightly coupled to technical implementation, allowing flexibility and ease of system evolution.
