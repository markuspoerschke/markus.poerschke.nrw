---
title: "Dependency-Injection"
date: 2019-09-17
slug: "dependency-injection"
---

Eines der wichtigsten Prinzipien der Softwareentwicklung ist die Seperation of Concerns,
nach der verschiedene Anliegen in getrennten Abschnitten eines Programms erfolgen sollen.
Die Erstellung von Objekten und die Ausführung von Geschäftslogik sind zwei verschiedene
Anliegen. Das Dependency-Injection Entwurfsmuster hilft bei der Trennung der beiden Anliegen.

<!--more-->

> »Softwaresysteme sollten den Startprozess, bei dem die Anwendungsobjekte erstellt werden
> und die Abhängigkeiten miteinander „verdrahtet“ werden, von der Laufzeitlogik,
> die nach dem Start übernimmt, trennen.« -- Robert C. Martin in Clean Code

Nach dem Single-Responsibility-Prinzip, sollte jede Klasse lediglich eine einzige
Aufgabe erfüllen. Eine Klasse sollte entweder dazu dienen Objekte zu erstellen 
oder Laufzeitlogik auszuführen. Einer Klasse, die Laufzeitlogik ausführt sollten 
daher abhängige Objekte von außen injiziert werden.

## Definition

Verwendet eine Klasse A eine andere Klasse B (z. B. durch das Aufrufen einer Methode), 
dann ist die Klasse B eine Abhängigkeit von der Klasse A. Da die Klasse A nun ihre Abhängigkeiten
nicht mehr selber erstellen darf, müssen die Abhängigkeiten (hier eine Instanz der Klasse B)
von außen übergeben werden. Hierdurch wird das Prinzip der Inversion of Control angewendet. 
Die Kontrolle über die Erstellung der Abhängigkeiten werden somit an das Framework 
übergeben. Das Injizieren der Abhängigkeiten „von außen“ wird als Dependency-Injection bezeichnet.

## Vorteile

Die wesentlichen Vorteile der Dependency-Injection ergeben sich vor allem aus der
Umsetzung der [S.O.L.I.D-Prinzipien](https://de.wikipedia.org/wiki/Prinzipien_objektorientierten_Designs#SOLID-Prinzipien).
Weiterhin fördert Dependency-Injection die Testbarkeit von Klassen mit Hilfe von automatisierten Tests.
Dependency-Injection bietet folgende Vorteile:

1. Durch die Trennung der Erstellung von Objekten von der Laufzeitlogik wird das _Single
Responsibility Principle_ umgesetzt, wonach eine Klasse nur eine Aufgabe erfüllen darf.

2. Durch die Möglichkeit, dass die Abhängigkeiten von außen in ein Objekt injiziert wird,
ist das _Open-Closed Principle_ umgesetzt, dass besagt, dass Klassen offen für Erweiterung,
jedoch geschlossen für Veränderungen sein sollen. Durch die Dependency-Injection können 
die Abhängigkeiten einfach ausgetauscht werden und bieten somit Spielraum für Erweiterungen.

3. In Unit-Tests können Abhängigkeiten durch Mocks ersetzt werden, sodass einzelne Klassen
unabhängig von ihrer Umgebung getestet werden können.

4. Die Lesbarkeit des Quelltextes einer Klasse wird verbessert, da die Anzahl der
Codezeilen einer Klasse verringert werden, wenn die Abhängigkeiten von außen 
injiziert werden. Dadurch kann der Fokus bei Entwicklung auf die Laufzeitlogik gerichtet werden.

5. Die Abhängigkeiten können als Interfaces definiert werden. Hierdurch besteht dann
keine direkte Abhängigkeit zu einer konkreten Implementierung mehr, wodurch das _Dependency Inversion
Principle_ erfüllt wird.

## Arten der Dependency-Injection

Anhand der Art, wie Abhängigkeiten in eine Klasse injiziert werden, wird zwischen den 
folgenden Arten der Dependency-Injection unterschieden:

1. [Constructor-Injection](#constructor-injection)
2. [Setter-Injection](#setter-injection)
3. [Public Property-Injection](#public-property-injection)
4. [Private/Protected Property-Injection](#private-protected-property-injection)

In der Praxis zeigt sich, dass vor allem die Constructor-Injection und die Setter-Injection verwendet wird.

### Constructor-Injection

Bei der Constructor-Injection werden die Abhängigkeiten als Argumente an den Konstruktor übergeben.
Die Abhängigkeiten stehen dadurch von Anfang an einer Instanz zur Verfügung. Durch Type-Hinting, wird
zusätzlich sichergestellt, dasss die richtigen Objekte übergeben werden. Es ist also sichergestellt,
dass die Abhängigkeiten vorhanden sind und können beim ersten Aufruf einer Methode der Instanz
sofort verwendet werden. Das Objekt befindet sich dadurch immer in einem validen Zustand.

Der folgende Quelltext zeigt eine Klasse, die die Constructor-Injection implementiert.
Die Abhängigkeit `ServiceB` wird der Klasse `ServiceA` an den Konstruktor übergeben und
in einem Attribut der Klasse gespeichert, sodass der Service beim Aufruf der Methode
`doSomething` verwendet werden kann.

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

Da der Konstruktor immer aufgerufen wird, kann die Methode `doSomething` sofort
von der Abhängigkeit `serviceB` gebrauch machen und beispielsweise eine Methode aufrufen.
Ohne das übergeben der Abhängigkeit an den Konstruktor kann keine Instanz der Klasse
`ServiceA` erstellt werden, da ansonsten eine Fehlermeldung geworfen werden würde.

### Setter-Injection

Bei der Setter-Injection werden die Abhängigkeiten durch eine Setter-Methode an die Klasse 
übergeben.

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

Bei dieser Art könnten Methoden der Klasse `ServiceA`, die die Klasse `ServiceB` verwenden,
aufgerufen werden, bevor die Abhängigkeit in die Instanz injiziert wurde. Dies könnte
zu einem Laufzeitfehler führen, wenn die Methode `doSomething` vor dem Setter aufgerufen
werden würde. Daher eignet sich diese Art zumeist für Abhängigkeiten, die optional sind 
und nicht unbeding benötigt werden. Das Objekt kann sich dadurch in einem invaliden
Zustand befinden, wenn die Setter-Methoden nicht aufgerufen werden.

### Public Property-Injection

Die Public Property-Injection funktioniert ähnlich wie die Setter-Injection. Statt 
eine Setter-Methode aufzurufen, wird einfach die Abhängigkeit direkt in ein öffentliches
Attribut des Objektes geschrieben.

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

Vor PHP Version `7.4` war bei dieser Art der Dependency-Injection, dass auch `NULL`,
Instanzen von falscher Klassen oder skalere Datentypen in das öffentliche Attribut
geschrieben werden konnten. Ab PHP `7.4` kann dies jedoch mit Angabe des Datentypes verhindert werden.

### Private/Protected Property-Injection

Bei der Private/Protected Property-Injection wird der Zugriff auf ein privates
oder geschütztes (protected) Attribut über Reflection erreicht. Ansonsten 
funktioniert die Injection genauso, wie die Public Property-Injection. Diese 
Art wird von einigen Dependency-Management-Frameworks verwendet.

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

Da die Verwendung von Reflection einen starken Eingriff in die Logik der Sprache bedeutet
und de-facto die Sichtbarkeiten von Attributen aushebelt, sollte diese Methode eher
nicht verwendet werden. Zudem beeinflusst Reflection die Performance, wodurch die 
sich Ausführungszeiten negativ verändern könnten.

## Dependency-Injection-Container

Die Aufgabe eines Dependency-Injection-Containers ist es, die Abhängigkeiten mit einer Klasse zu
verknüpfen und zu instanziieren. Die Klassen selbst lösen ihre Abhängigkeiten nicht selbst auf.
Die Abhängigkeiten werden injiziert, wenn der Dependency-Injection-Container eine neue Instanz der Klasse erzeugt.

Die Aufgaben des Dependency-Injection-Containers sind

1. das Erstellen von Objekten,
2. zu wissen, welche Klassen welche Abhängigkeiten benötigen
3. und ihnen all diese Abhängigkeiten zur Verfügung zu stellen.

Die Objekte innerhalb des Dependency-Injection-Containers, die in der Regel
durch einen eindeutigen Namen identifiziert werden können, werden als _Service_
bezeichnet.

### Implementierung

Die Implementierung eines einfachen Containers ist in wenigen Zeilen Code und ohne die Nutzung
eines Frameworks möglich. Der Dependency-Injection-Container wird als Klasse implementiert.
Jede Methode dieser Klasse erstellt ein Objekt. Der Nachfolgende Code zeigt einen Dependency-Injection-Container,
der eine Instanz der Klasse `ServiceA` erzeugen kann.

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

Durch verwendung der Methoden-Sichtbarkeit können private und öffentliche Services definiert werden.
In dem vorliegendem Beispiel ist `ServiceA` öffentlich aufrufbar, wohingegen `ServiceB` nur innerhalb
des Dependency-Injection-Containers vorliegt.

### Frameworks

Neben der manuellen Programmierung eines Dependency-Injection-Containers, existieren
Frameworks, die diesen Prozess automatisieren. Es werden oft (aber nicht ausschließlich),
Konfigurationen in Textformaten wie beispielsweise YAML oder XML verwendet, um die Services zu definieren,
die in einer Anwendung verwendet werden können. Als Service wird hierbei die Instanz einer Klasse
verstanden, die mit Hilfe einem eindeutigen Service-Namen identifziert werden kann.

Das Verdrahten der Abhängigkeiten wird zudem von vielen Frameworks automatisch übernommen.
Dies wird als _Autowiring_ bezeichnet. Hierbei erkennt der Dependency-Injection-Container
automatisch, welche Abhängigkeiten ein Service benötigt. Hierzu werden die Signaturen
der Konstruktoren untersucht und die entsprechenden Services (sofern vorhanden) injiziert.

Für die PHP können z. B. folgende Bibliotheken verwendet werden, um Dependency-Injection 
im eigenem Projekt zu nutzen:

* [Symfony DependencyInjection Component](https://symfony.com/doc/current/components/dependency_injection.html)
* [PHP-DI](http://php-di.org/)
* [Pimple](https://pimple.symfony.com/)
