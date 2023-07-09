Coding Standards
Add a single space after comma delimiters
Add a single space around binary operators
Add a single space around binary operators
Use braces to indicate control structure body
Define one class per file
Declare properties before methods
Declare methods in the following order: public, protected & private

- https://symfony.com/doc/current/contributing/code/standards.html

Naming conventions
Use camelCase for: variables, functions, methods & arguments
Use snake_case for configuration parameters and Twig template variables
Namespaces should be UpperCamelCase
Suffix the following with:
 Interfaces with Interface
 Traits with Trait
 Exceptions with Exception

How to approach this course
Mailing & Notifications
Tests
Service & Service Container
Authorization
Database & Dcotrine
Views & Assets
Controllers & Assets
Configuration
Configuration
Installation
Introduction

Why to use a Framework
Developers we're responsible for writing business logic
Use packages that are available
Where would you start without a framework?

MVC

Model
- Manages the fundamental behaviors and data
- Ineracts with the requests from input fields
- Respond to instructions
- Notify observers in event-driven systems

View
- Interface of your application
- Pull data from database, translate it into the view

Controller
- Take HTTP requests & gets the right data
- Validates user input
- Sends responses back to the user517221

DO NOT...
- Use the View or Controller in your Model
NO SQL inside your controller, let alone views
