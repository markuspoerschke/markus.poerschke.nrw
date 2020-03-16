---
title: "Dependency Injection"
date: 2019-09-17
slug: "dependency-injection"
description: "Consistent compliance with dependency injection contributes to a better code base in object-oriented programming."
---

One of the most important principles of software development is the
Separation of Concerns, according to which different concerns are to take place
in separate sections of a program. The creation of objects and the execution of
business logic are two different concerns. The Dependency Injection design
pattern helps to separate the two concerns.

<!--more-->

> “Software systems should separate the startup process, when the application objects
> are constructed and the dependencies are ’wired’ together; from the runtime logic
> that takes over after startup.” -- Robert C. Martin in Clean Code

According to the Single Responsibility Principle, each class should serve only one purpose.
A class should either be used to create objects or to execute runtime logic. 
A class that executes runtime logic should therefore have dependent objects injected from outside.

## Definition

If a class A uses another class B (for example, by calling a method), then class B is a dependency of class A.
Since class A is no longer allowed to construct its own dependencies, the dependencies (in this case an instance of class B) must be injected from outside.
This applies the principle of Inversion of Control: the control over the creation of the dependencies is transferred to the framework, which controls the application flow.
Injecting dependencies "from outside" is called Dependency Injection.

## Benefits

The main advantages of Dependency Injection result from the implementation of the [S.O.L.I.D principles](https://en.wikipedia.org/wiki/SOLID).
Furthermore Dependency Injection enhances the testability of classes with the help of automated tests.
Dependency Injection provides the following benefits:

1. By separating the construction of objects from the execution of runtime logic, the _Single Responsibility Principle_ 
is implemented, according to which a class may only fulfill one single purpose.

2. The _Open-Closed Principle_, which states that classes should be open for extension, but closed for modification, 
is implemented by the ability to inject external dependencies into an object. 
The Dependency Injection makes it easy to replace dependencies, thus providing room for extension.

3. In unit tests, dependencies can be replaced by mocks so that individual classes 
can be tested independently of their environment.

4. The readability of the source code of a class is improved, since the number of lines of
code is reduced when external dependencies are injected. This allows to put the focus on the
development of the runtime logic.

5. The dependencies can be defined as interfaces. This avoids a direct dependency on a concrete implementation,
thus fulfilling the _Dependency Inversion Principle_.

## Types of Dependency Injection

The way dependencies are injected into a class is used to distinguish between the 
of Dependency Injection:

1. [Constructor Injection](#constructor-injection)
2. [Setter Injection](#setter-injection)
3. [Public Property Injection](#public-property-injection)
4. [Private/Protected Property Injection](#private-protected-property-injection)

Practical experience shows that Constructor Injection and Setter Injection are mainly used.

### Constructor Injection

With Constructor injection, the dependencies are injected to the constructor as arguments.
The dependencies are therefore available to an instance from the very beginning.
Type hinting ensures that the correct objects are passed.
Thus it is ensured that the dependencies are present and can be used immediately with the first call of a method of the instance.
The object is therefore always in a valid state.

The following source code shows a class that implements the constructor injection.
The dependency `ServiceB` is passed to the constructor of the `ServiceA` class and 
stored in a member property of the class so that the service can be used when the
`doSomething` method is called.

```php
<?php

final class ServiceA 
{
    private ServiceB $serviceB;

    public function __construct(ServiceB $serviceB)
    {
        $this->serviceB = $serviceB;
    }

    public function doSomething(): void
    {
        $this->serviceB->someMethod();
    }
}

// Instanziierung
$serviceA  = new ServiceA($serviceB);
```

Since the constructor is always called, the `doSomething` method can immediately make use of the `serviceB` dependency and call a method, for example.
Without passing the dependency to the constructor, no instance of the `ServiceA` class can be created, otherwise an error message would be thrown.

### Setter Injection

With the Setter Injection, the dependencies are injected by passing them to a setter method.

```php
<?php

final class ServiceA
{
    private ServiceB $serviceB;

    public function setServiceB(ServiceB $serviceB)
    {
        $this->serviceB = $serviceB;
    }

    public function doSomething(): void
    {
        $this->serviceB->someMethod();
    }
}

// Instanziierung
$serviceA = new ServiceA();
$serviceA->setServiceB($serviceB);
```

This way of injecting the dependency `ServiceB` may cause, that in a method of 
`ServiceA` the dependency is used before it was injected. This would result in 
a runtime error if the `doSomething` method were called before the setter. 
Therefore, this type is mostly suitable for dependencies that are optional and 
not absolutely necessary. The object can therefore be in an invalid state if the
setter methods are not called.

### Public Property Injection

The Public Property Injection works similar to the Setter Injection.
Instead of calling a setter method, the dependency is simply written directly into a public property of the object.

```php
<?php

final class ServiceA
{
    public ServiceB $serviceB;
}

// Instanziierung
$serviceA = new ServiceA();
$serviceA->serviceB = $serviceB;
```

Prior to PHP version `7.4`, this type of dependency injection could also write 
`NULL`, instances of incorrect classes or scalar data types into the public
property. As of PHP `7.4` this can be prevented by specifying the datatype.


### Private/Protected Property Injection

With Private/Protected Property Injection, access to a private or protected 
attribute is achieved through Reflection. Otherwise, the injection works the 
same way as the public property injection. This kind is used by some dependency
management classes.

```php
<?php

final class ServiceA
{
    private $serviceB;
}

$serviceA = new ServiceA();

$reflection = new ReflectionObject($serviceA);
$property = $reflection->getProperty('serviceB');
$property->setAccessible(true);
$property->setValue($serviceA, $serviceB);
```

Since the use of reflection means a strong manipulation of the logic of the
language and in fact bypasses the visibility of properties, this kind of
injection should not be used. Furthermore reflection also affects performance,
which can have a negative impact on execution times.

## Dependency Injection Container

The purpose of a Dependency Injection Container is to construct and wire the
dependencies with the classes. The classes themselves do not resolve their own
dependencies. Instead, the dependencies are injected when the dependency
injection container constructs a new instance of a class.

The responsibilities of the Dependency Injection Container are

1. to construct new objects,
2. to know which classes need which dependencies,
3. and to wire them all together.

The objects within the Dependency Injection Container that can usually be
identified by a unique name are called _Service_.

### Implementation

The implementation of a simple container is possible in a few lines of code and
without the use of a framework. The Dependency Injection Container is
implemented as a class. Each method of this class creates an object. The
following code shows a Dependency Injection Container that can create an instance of the class `ServiceA`.

```php
<?php

final class MyDependencyInjectionContainer 
{
    public function getServiceA(): ServiceA
    {
        return new ServiceA($this->getServiceB());
    }

    private function getServiceB(): ServiceB
    {
        return new ServiceB();
    }
}
```

By using method visibility, private and public services can be defined. In this
example, `ServiceA` is a publicly available service, whereas `ServiceB` is only
available inside the Dependency Injection Container.

### Frameworks

In addition to the manual programming of a Dependency Injection container,
frameworks exist that automate this process. Often (but not exclusively),
configurations in text formats such as YAML or XML are used to define the
services that can be used within an application.

Many frameworks also take over the wiring of dependencies automatically. This is
called _Autowiring_. Hereby the dependency injection container automatically
recognizes which dependencies of a service are required. For this purpose, the
signatures of the constructors are examined and the corresponding services (if
available) are injected.

For PHP the following libraries can be utilised to make use of Dependency 
Injection in your own project:

* [Symfony DependencyInjection Component](https://symfony.com/doc/current/components/dependency_injection.html)
* [PHP-DI](http://php-di.org/)
* [Pimple](https://pimple.symfony.com/)
