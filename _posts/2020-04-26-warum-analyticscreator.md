---
title: Warum ich seit 2017 den AnalyticsCreator verwende
subtitle: Und wartum mich Wherscape nicht überzeugt hat
tags: [analyticscreator, dwh-automatisierung, etl, elt, dwh, wherescape, data-lineage, slow-changing-dimension, scd, ssas-tabular, ssas]
---

Der AnalyticsCreator ist seit 2017 mein Standard-Werkzeug zur Automatisierung der Erstellung von DWH (data warehouse) inklusive ELT (oder ETL) und optionaler analytischer Datenbanken (mit SSAS Tabular), nachdem mich diverse andere Automatisierungs-Tools nicht so recht überzeugen konnten ([Wherescape](https://www.wherescape.com/), [DeltaMaster Modeler](https://www.bissantz.de/know-how/crew/deltamaster-modeler-individuelle-datenmodel-lanpassung-nach-deploy/), [PowerBuilder](https://www.appeon.com/products/powerbuilder), verschiedene Mindmap-to-Datenbank-Programme, ...).

## Wie hat mich der AnalyticsCreator überzeugt?

- Entwickler werden nicht zu Sklaven der Software, sondern können den AnalyticsCreator verwenden, um ihre Ideen zeitsparend und automatisiert umzusetzen  
- was es im Standard (noch) nicht gibt, lässt sich über manuelle Transformationen, eigene TSQL-Skripte, Prozeduren usw. ergänzen  
- exzellenter Support  
- Konzentration auf fachliche Inhalte  
- automatisierte Erstellung der DWH, welche dann auch ohne AnalyticsCreator funktionieren  
- automatisierte Erstellung von [SSIS](https://docs.microsoft.com/de-de/sql/integration-services/sql-server-integration-services?view=sql-server-ver15) Projekten (ELT, ETL), zukünftig auch Azure [Data Factory](https://azure.microsoft.com/de-de/services/data-factory/)  
- automatisierte Erstellung analytischer Modelle ([SSAS Tabular](https://docs.microsoft.com/de-de/analysis-services/tabular-models/tabular-models-ssas?view=asallproducts-allversions), PowerPivot, [Tableau](https://www.tableau.com/de-de), Qlik-Skripte)  
- [Data-Lineage](https://de.wikipedia.org/wiki/Data-Lineage) auf Spaltenebene (Datenherkunft, Data Provenance, Data Pedigree, Datenabstammung, Datenstammbaum)  
- Trennung der technischen Namen von fachlichen Namen und deren Vererbung durch alle Schichten, um in der analytischen Schicht automatisch angewendet werden zu können  
- einfaches und robustes Refactoring  
- einfache Erstellung und Verwendung historisierter Daten ([Slow Changing Dimensions](https://de.wikipedia.org/wiki/Slowly_Changing_Dimensions): SCD2, SCD1, SCD0)  
- transparente und übersichtliche Implementierung von Anonymisierungen, um beispielsweise DSGVO Anforderungen zu erfüllen  
- offene und von außen manipulierbare Repositories in Form von SQL Server Datenbanken  
- Dokumentation der Datenbank in der Zieldatenbank über extended Properties, die von da auch wieder ausgelesen werden können:  
  Code und Dokumentation in einem  
- einfache Anbindung verschiedener Datenquellen, inklusive SAP über den Theobald Konnektor für SAP (Industrie-Standard für SAP Anbindungen)  
- OpenSource Erweiterungen: [github.com/aisbergde/AnalyticsCreator_Toolkit](https://github.com/aisbergde/AnalyticsCreator_Toolkit)  
- man braucht keinen "Junior" für die stupide Fleißarbeit, sondern automatisiert, was sich automatisieren lässt  
- Der Kunde verringert Kosten, bekommt fehler-freieren Code und kann sich auch fachlich viel einfacher einbringen  
- Die Zusammenarbeit zwischen fachlichen Anforderungen und technischer Umsetzung kann sehr viel enger erfolgen  
- ich habe noch nichts Besseres gefunden und der AnalyticsCreator ist eines der sehr wenigen Produkte, das ich uneingeschränkt weiterempfehle  

## Warum hat mich [Wherescape](https://www.wherescape.com/) nicht überzeugt?

Dieses Produkt habe ich 2015/2016 in einem Projekt eingesetzt. Man konnte dort zwar auch das Repository von außen manipulieren, aber ich empfand das als sehr aufwendig. In dem Projekt gab es bereits ein DWH und ETL mit SSIS, allerdings war der SQL Server inklusive SSIS kein Firmenstandard, sondern das Monster Informatica, Wherescape wurde gerade promoted und sollte / durfte verwendet werden.  

Unter anderem sollten von mir auch bestehende ETL Prozesse zum Import von Daten aus Microsoft MDS ([Master Data Services](https://docs.microsoft.com/de-de/sql/master-data-services/master-data-services?view=sql-server-2014&viewFallbackFrom=sqlallproducts-allversions "Master Data Services")) in das DWH, die mit SSIS realisiert waren, auf die Verwendung von Wherescape umgestellt werden. Während man die SSIS Pakete relativ einfach als Template verwenden konnte, um so neue Sichten aus MDS in den SQL Server zu importieren, funktionierte das bei Wherescape so gar nicht mit einer Automatisierung. Es mussten hunderte von Importen immer wieder nach gleichem Muster manuell erstellt werden. Es gibt zwar auch im Wherescape eine große Flexibiliät, allerdings nur im Rahmen dessen, was Wherescape für Historisierungen usw. vorsah. Ich wollte aber einiges anderes machen, als im Standard vorgesehen und musste das aufwändig von hinten durch die Brust über Umwege realisieren. Ich konnte also nicht so modellieren, wie ich es wollte, sondern musste mich im Kontext der Vorgaben von Wherescape bewegen, ich wurde zum Wherescape-Sklaven. Und es gab da noch vieles andere, was mir an Wherescape nicht gefallen hatte.  

So nebenbei: andere Entwickler verwendeten fast nur das, was man im AnalyticsCreator "manuelle Tranformationen" nennt, also von Hand erstellten Code für Sichten und Prozeduren. Wozu ein Automatisierungstool verwenden, wenn der Code in großen Teilen nicht automatisiert erstellt wird?  

Auch der **AnalyticsCreator** hatte bei meinen ersten Tests sehr vieles nicht, was ich mir wünschte. Allerdings war und ist der Entwickler extrem kooperativ und sehr aufgeschlossen meinen Vorschlägen gegenüber. Es gibt auch immer die Möglichkeit manueller Transformationen. So gab es beispielsweise lange Zeit keine formalisierte UNION Transformation, und man konnte das sehr einfach mit einer manuellen Transformation überbrücken. Oder Historisierungen: Viele Features der aktuellen Historisierung sind meinen Feature-Requests zu verdanken, so auch die Übernahme eine bestehenden Historisierung. Und solange das nicht implementiert war, konnte man sich den Code der Historisierungs-Prozedur automatisch erstellen, dann auf manuell umstellen und manipulieren.
