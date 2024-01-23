# YuNO Architecture

This architecture aims to clearly separate responsibilities into layers, making code maintenance, testability, and scalability easier. Each layer has a specific purpose, and dependencies are organized so that business logic is not tightly coupled to technical implementation, allowing flexibility and ease of system evolution.

<img src="assets/images/YuNO-Arch.png" width="512" alt="Achitecture diagram"/>

## 1. Layers

### 1.1 Public

Encompasses all pages and subpages of the application.

- **Pages:**
  - Represents the user interface layer.
  - Should be decoupled as much as possible from non-essential UI packages.
- **Widgets:**
  - Contains specific visual components for a single page.

### 1.2 Interactor

Encompasses business rules and yours interfacer.

- **Atoms:**
  - Small building blocks representing atomic units of functionality.
- **Actions:**
  - Represents actions that can be performed in the system.
- **Interfaces of Repositories and Services:**
  - Defines contracts for interactions with data layers.

### 1.3 Data

Encompasses the execution of business rules.

- **Implementations:**
  - **Repositories and Services:**
    - Contains concrete implementations of contracts defined in the Interactor layer.
    - Responsible for interacting with external data sources such as databases or APIs.

### 1.4 Core

Encompasses global data for the application.

- **Themes:**
  - Defines visual styles and themes for the application.
- **Assets:**
  - Stores static resources such as images, icons, etc.
- **Widgets:**
  - Reusable components that can be used in different parts of the application.
- **Other Global Data:**
  - Includes other elements essential for the global operation of the application.

## 2. Tests

Testing is a crucial part of software development. It ensures code quality and functionality, and helps in maintaining the software over time. Our testing approach adheres to the triple-A pattern (Arrange, Act, Assert) for its clarity and structure.

For an in-depth understanding, refer to this article on the [Triple-A Pattern](https://medium.com/@pjbgf/title-testing-code-ocd-and-the-aaa-pattern-df453975ab80).

### Example

```dart
test('should execute a sum correctly', () {

  // arrange
  int number1 = 2;
  int number2 = 1;

  // act
  final result = sumFunction(number1, number2);

  // assert
  expect(result, 3);

});
```

### 2.1 Test Description

The description of each test should clearly articulate the expected outcome based on the specific action or condition being tested. Avoid generic or obvious descriptions. Instead, focus on what is being verified in each test case.

### Guidelines for Test Descriptions

- Clearly state the purpose of the test.
- Describe the specific condition or scenario.
- Indicate the expected result or behavior.

### Examples of Good Descriptions

- Correct: "should return the sum of two numbers when both inputs are positive".
- Avoid: "Should return a result".

### 2.2 Test Grouping

Grouping tests is essential for organization and readability, especially in large codebases. Group names should correspond to the class or functionality they are testing, with an optional method name if applicable. Use " | " (space, pipe, space) at the end of each group name for clarity.

### Guidelines for Test Grouping

- Group tests by functionality or class.
- Use descriptive names that reflect the group's purpose.
- Optionally include the specific method being tested.

### Example of Action Test Group

```dart
group('SaveGameAction | ', () {
    // Tests for SaveGameAction
});
```

### Example of Repository Test Group

```dart
group('AndroidAppsRepository.openAppSettings | ', () {
    // Tests for AndroidAppsRepository.openAppSettings
});
```

## 2.3 Additional Best Practices

- **Test Isolation:** Ensure each test is independent and can run alone.
- **Code Coverage:** Aim for high test coverage, but prioritize meaningful tests over merely inflating coverage metrics.
- **Mocking and Stubbing:** Use mocks and stubs where necessary to isolate the unit of test.

Remember, good tests not only check for correct outcomes but also contribute to the overall quality and maintainability of the software.
