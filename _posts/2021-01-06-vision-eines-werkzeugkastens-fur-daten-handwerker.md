---
title: Meine Vision eines Werkzeugkastens für Daten-Handwerker
subtitle: Handwerk statt Massenproduktion, Werkzeugkasten statt beengendem Korsett
tags:
  - Handwerk
  - DWH
  - mssql
  - DataHandwerk
  - DHW
last-updated: 2021-01-06T00:00:00.000Z
head-extra: head_extra.html
slug: meine-vision-eines-werkzeugkastens-fur-daten-handwerker
---

Als Handwerk werden zahlreiche gewerbliche Tätigkeiten bezeichnet, die Produkte meist auf Bestellung fertigen oder Dienstleistungen auf Nachfrage erbringen. Die handwerkliche Tätigkeit steht der industriellen Massenproduktion gegenüber.  
"Handwerk" entspricht somit meiner Arbeit in BI-Projekten. Das ausdrückliche Ziel "meines" Werkzeugkastens ist die Unterstützung der Arbeit eines Daten-Handwerkers und nicht die Fabrik mit automatischer Fertigung.

![Deutsches_Handwerkszeichen_Hindenburg](../assets/img/Deutsches_Handwerkszeichen_Hindenburg.svg.200x200.png)

## AnalyticsCreator und Daten-Handwerker

Seit 2017 verwende ich den [AnalyticsCreator](www.analyticscreator.com). Das Konzept des AnalyticsCreators besteht u. a. darin, ein DWH mit den dazugehörigen ETL-Prozessen und sogar SSAS-Datenbanken *vollständig* über ein Repository zu definieren und mit dem AnalyticsCreator zu erstellen. Neben vielen Vorteilen, die ich in einem anderen Artikel ["Warum AnalyticsCreator"](../2020-04-26-warum-analyticscreator.md) beschrieb, gibt es auch *Einschränkungen*:

- Es können nur die **Features und Methoden** des SQL Server oder der Azure Produkte verwendet werden, die sich im Repository und durch den AC abbilden lassen.
- Wenn etwas nicht funktionieren sollte oder man nicht weiß, wie man es mit dem AC realisieren kann, ist man auf **Sofort-Support** angewiesen oder benötigt ausreichende Erfahrung, um einen Workaround zu finden und anzuwenden.
- Die Arbeit mit dem AnalyticsCreator kann man mit einer *Autobahn* vergleichen, im Gegensatz zur *Landstraße* der herkömmlichen Arbeit.
  - Gut ist, dass man die Autobahn jederzeit in Richtung Landstraße verlassen kann. Problematisch ist, dass es zwischen Autobahn und Landstraße aktuell nur **Einbahnstraßen** gibt:
  - Der Weg von der Landstraße auf die Autobahn ist mühsam bis unmöglich. Ich habe dazu ein Projekt zum **Reverse Engineering** in den AnalyticsCreator angestoßen: [SchemaCompare-DWH-into-AC](https://dev.azure.com/AnalyticsCreator/AnalyticsCreator/_wiki/wikis/AnalyticsCreator.wiki/80/SchemaCompare-DWH-into-AC).  
  Allerdings bin ich schnell an dem Punkt angelangt, da das auch vom AC unterstützt werden muss. Dieses von mir seit langem immer wieder angeregte Reverse Engineering hat für den AnalyticsCreator keine hohe Priorität. Daher habe ich meine Arbeit daran auf Eis gelegt. Mein Versuch scheint in seiner aktuellen Form auch zu kompliziert in der Anwendung zu sein.

### Zur Arbeit mit Werkzeugen im Allgemeinen

- Vor allem *neue Anwender* haben gelegentlich Angst, dass sie irgendwann nicht weiterkommen, weil sie ein Werkzeug nicht gut genug kennen, auf das sie zwingend angewiesen sind und für das es keine Alternativen gibt. Sie sind insbesondere dann auf *Sofort-Support* angewiesen, wenn es sich um ein Zeit-kritisches Projekt handelt und sie keinen offensichtlichen Work-Around kennen. Eine Lösung wird es in den meisten Fällen geben, was aber in diesem Moment nichts nützt, wenn sie dem Anwender nicht bekannt ist.  
  Ein Forum wird für solche Support-Anfragen eher nicht genutzt, da man eine Lösung nicht irgendwann benötigt, sondern sofort.
- Manch *erfahrener Entwickler* möchte ein Werkzeug nicht verwenden, wenn er das Werkzeug als zu einschränkend empfindet.  
  Ein Entwickler, der ein Werkzeug nicht verwenden will, weil er es nicht als Bereicherung sondern als beengendes Korsett empfindt, findet immer Gründe, warum in *seinem* Projekt dieses Werkzeug nicht geeignet ist. Das kenne ich aus eigener Erfahrung, und darin bin ich gut. Und wenn ein Entwickler doch gegen seinen Willen gezwungen wird, dann wird die Abwehr um so größer.

Um die beiden Probleme zu entschärfen, ist es wünschenswert bis notwendig

- dass ein Werkzeug nicht obligatorisch eingesetzt werden muss, sondern in möglichst vielen Situationen über Alternativen verfügt,
- dass ein Werkzeug nur da verwendet werden braucht, wo es als Bereicherung empfunden wird.

Und das betrifft jedes Werkzeug, also auch das Werkzeug "AnalyticsCreator".

## Werkzeugkasten Konzept

Obengenannte Erfahrungen induzierten meine Vision eines *fakultativen Werkzeugkastens*:

- Es soll ein Werkzeugkasten (toolkit, toolbox) für Daten-Handwerker bereitgestellt werden:  
  für BI Entwickler, die DWH, analytische Anwendungen, Reporting-Lösungen, ETL oder ELT Prozesse im Kontext der Microsoft BI Plattform (mssql, Azure, Power BI, ...) entwerfen, entwickeln oder warten.
- Dieser Werkzeugkasten wird nach und nach mit Werkzeugen gefüllt und erweitert.
- BI Entwickler erhalten die Möglichkeit, *schneller und besser zu arbeiten* und bei Bedarf Teile zu automatisieren, wenn (und nur wenn) sie das wünschen.
- Der Werkzeugkasten soll **als Bereicherung und Hilfsmittel empfunden werden**, gerne als stützendes, nie als beengendes Korsett.
- Werkzeuge und Methoden *können* bei Bedarf **fakultativ** eingesetzt werden.  
  Ein Entwickler wird nicht ungewollt zum Sklaven der Werkzeuge und Methoden. Er lässt sich partiell und bewusst einschränken, wenn für ihn subjektiv die Vorteile überwiegen. Er kann selbst entscheiden, in welchem Umfang er welche Werkzeuge zu seiner Unterstützung verwenden will, oder eben nicht.
- Es soll **keine Einbahnstraße** geben. Der Wechsel zwischen *"Autobahn mit Werkzeugkasten"* und *"Landstraße mit Handarbeit"* muss einfach und in beiden Richtungen mehrfach möglich sein.

### mssql und Azure Features

Es muss für BI Entwickler **immer** möglich sein, **alle** gewünschten mssql und Azure Features zu verwenden. Letztendlich also auch [Azure Synapse Analytics](https://azure.microsoft.com/de-de/services/synapse-analytics/), Data Factory, BLOB Storage und andere Azure Produkte.

Wann immer möglich oder gewünscht, kann ein Entwickler zur Realisierung von Zielen bevorzugt mssql Features verwenden, statt proprietärer Lösungen. Beispiele:

- Für Historisierungen könnten *temporale Tabellen* verwendet werden, die es seit mssql 2016 gibt.
- Für die Auswertung von Abhängigkeiten und Referenzen könnte man die Möglichkeiten von *Graph-Datenbanken* (brauchbar ab mssql 2019) verwenden.

### Unabhängigkeit von Sofort-Support

Man soll auch arbeiten können, wenn ein Werkzeug nicht wie erwartet funktioniert. Es soll keine blockierende Abhängigkeit von einem Tool oder einer Methode entstehen, die Feuerwehr-Support-Einsätze erfordert, sondern es soll immer auch einen manuellen Ausweg geben.

Die Abhängigkeit von einem Sofort-Support soll vermieden oder minimiert werden, sodass insbesondere die Verwendung eines Forums attraktiver wird.

### Repository

Ein Repository braucht nicht alle Metadaten zur vollständigen Definition eines DWH enthalten, sondern es scheint sinnvoll und ausreichend, ein **bestehendes DWH und seine Metadaten um fehlende Funktionalität zu ergänzen**. Beim Repository könnte es sich um eine Ergänzung zu einem DWH handeln. Das Repository könnte in ein DWH (mit seinen bestehenden System-Sichten und -Prozeduren) integriert werden, statt es in eine separate Datenbank auszulagern.

Repository-Metadaten sollen möglichst auch **mit extended properties korrespondieren**. So können u. a. auch Objekte oder Objektgruppen inklusive ihrer Ergänzungen einfacher zwischen verschiedenen Datenbanken ausgetauscht werden. Dabei muss es möglich sein, dass *sowohl über das Repository als auch direkt in der Datenbank Objekte definiert werden können* und man diese kombinieren kann: also etwa repository-gesteuerte Sichten mit manuellen Sichten.

### Modularer Aufbau und Erweiterbarkeit

Eine **Kombination mit Werkzeugen anderer "Hersteller" und "Marken"** ist möglich. Denn es gibt viele gute Werkzeuge auf dem Markt, kostenlose und kostenpflichtige.

Der Werkzeugkasten kann von verschiedenen Anwendern mit Modulen (Werkzeugen, Tools) erweitert werden kann. In der Art von VSC oder Azure Data Studio. Diese Tools lassen sich öffentlich oder nicht-öffentlich austauschen, verkaufen, oder wie es sich der Tool-Anbieter eben vorstellt.

Das Repository ist wie der Werkzeugkasten modular und auf Erweiterbarkeit ausgelegt. Es kann von verschiedenen Anwendern oder in verschiedenen Projekten um neue Features ergänzt werden.

Beispiele für mögliche Module:

- Historisierungs- und Persistierungs-Assistent
- Data Lineage Visualizer
- Dokumentations-Assistent (inklusive Erstellung und Vererbung von Beschreibungen und Friendly Name entlang einer Data Lineage)
- Relation Management
  - virtuelle PK und UK und deren Vererbung
- ELT und ETL Generatoren
  - SSIS Generator
  - Data Factory Generator
- SSAS Tabular Generator
- Verbindungs-Definitionen für SAP oder andere Standard-Datenquellen
- Import Assistent
- Data Vault Assistent
- DSGVO Assistent
- ...

### Dokumentation und Support

Das Repository, seine Funktionsweise und die Methoden sind **verständlich dokumentiert**. Eine gute Dokumentation

- bietet Transparenz
- schafft Verständnis
- erleichtert das selbständige Arbeiten
- erleichtert den Einstieg
- verringert die Abhängigkeit vom Support

Die wichtigsten Ressourcen für Dokumentation und Support sind **Wiki** und **Forum**.  
Module und Methoden müssen so aufgebaut sein, dass kein Sofort-Support notwendig ist, sondern das Forum als geeignetes Support-Medium angenommen werden kann.

### Open source

Die Entwicklung sollte open source erfolgen, um die Zusammenarbeit verschiedener Entwickler zu ermöglichen.

### Agile Softwareentwicklung

Für die Entwicklung des Werkzeugkastens werden *formale* Methoden der agilen Softwareentwicklung verwendet. Inklusive Sprints und Meilensteinen.

Für Anwender und Mit-Entwickler ist transparent, woran mit welcher Priorität gearbeitet wird und was in konkreten Sprints erreicht werden soll.
