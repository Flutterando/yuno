# Arquitetura - MiniCore

**Objective**: Propose a simplified and easily understandable architecture, focusing on the FrontEnd. The proposed structure is based on three distinct layers: User Interactor, Adaptation, and External.

### Layers

**User Interactor**: Should be responsible for declaring the inputs, outputs, and interactions of the application.

**Adaptation**: Should be responsible for translating and facilitating communication between the User Interactor and External layers.

**External**: Should be responsible for handling information external to your application.
<br>
<br>

<p align="center">
<img src="assets/vai.png" width="512" alt="Achitecture diagram"/>
</p>

<br>
<br>

<p align="center">
<img src="assets/volta.png" width="512" alt="Achitecture diagram"/>
</p>

### Limits

Within the established architectural boundaries, it is highlighted that the User Interactor layer should not have direct access to the External layer. To overcome this restriction, the Adaptation layer acts as an intermediary, facilitating communication between the User Interactor and External layers.

With the aim of enhancing development efficiency and flexibility, the architecture ensures low coupling through a clear separation of responsibilities in each layer.


## Architecture Structure

### UI (User Interface)
This layer must contain the visual elements of the application.

### Interactor
This layer should encompass the states or reactivities of the application, the representation of business rules, abstractions for communication between the other layers, and the operations executed by its UI.

- #### Atoms: 
    They must store an application state.

- #### Actions: 
    They must have the purpose of changing the application states.

- #### DTO: 
    Data Transfer Object is a design pattern used to transfer data between layers.

- #### Models: 
    They represent business rules.

- #### Interfaces:
    They must contain interfaces to achieve loose coupling, reducing direct dependency and providing easy replacement of implementations.
 
## Data
They must interact with external sources.

- #### Adapter: 
    There must be adaptations to ensure that external data follows the standards defined by the application.

- #### Tratamento de erros:  
    As a good practice, we must handle errors in our application, ensuring stability and reducing the occurrence of failures.
  
- #### Repository: 
    It must contain the concrete class, coming from the abstraction, for communication between layers.
    
- #### Service: 
    It must contain the concrete class, coming from the abstraction, for communication between layers.

## Core
It must contain global and reusable information for all layers of the application.

## Benefits of Using MiniCore Architecture:

- #### Ease of Understanding: 
    It provides a clear and intuitive structure, making the code easier for developers to understand.

- #### Maintainability:
    Layering and clarifying responsibilities makes the code easier to maintain and update.

- #### Code Scalability:
    The architecture is designed to handle application growth, ensuring it can scale effectively.

- #### Easy Access to Global Variables and Methods:
    Facilitates access to global variables and methods, promoting efficient communication between different parts of the system.

- #### Facilitates Testing (Without the Need to Mock the Atoms):
    Simplify testing by eliminating the need to simulate or mock Atoms, making the testing process more efficient and less complex.

Another important point will be the global state, and with this, we gain:

Universal Accessibility: The global state allows data to be accessed from anywhere in the application. This can be useful when you need to share information between different parts of the user interface or across multiple pages.

Reduced Complexity: Instead of passing data through various components as parameters, the use of a global state can simplify the code, making it more readable and easier to understand.

Ease of Maintenance: By centralizing the state in a global location, it becomes easier to maintain and modify the application state. This can facilitate bug resolution and the implementation of new features.

Improved Performance: Depending on the implementation, a well-managed global state can lead to better performance, especially compared to approaches where data needs to be passed through many components.


<br>

By adopting the MiniCore architecture, developers gain a more robust, efficient, and easily maintainable system development, promoting a more positive and sustainable development experience.

## Examples

According to the proposed architecture, the folder structure is defined.

```
.
└── app/
    ├── public/
    │   └── pages/
    ├── core/
    │   ├── assets/
    │   ├── themes/
    │   └── widgets/
    ├── data/
    │   ├── adapters/
    │   ├── repositories/
    │   └── services/
    └── interactor/
        ├── atoms/
        ├── actions/
        ├── dtos/
        ├── models/ 
        ├── repositories/
        └── services/
```

See some [examples](https://github.com/FelCarv01/mini-core-examples).
