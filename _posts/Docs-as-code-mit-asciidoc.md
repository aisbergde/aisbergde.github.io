---
title: Docs-as-Code mit Asciidoc und Antora
subtitle: Multi-Repository-Projekt-Dokumentation
tags:
  - Docs-as-Code
  - asciidoc
  - markdown
  - Antora
  - open source
last-updated: 2021-03-23T00:00:00.000Z
head-extra: head_extra.html
slug: docs-code-mit-asciidoc-und-antora
lastmod: 2021-03-23T10:18:19.373Z
---

Der AnalyticsCreator (AC) hat einen vorgesehenen Kontext: die Automatisierung der Erstellung von DWH, inklusive ETL und SSAS Datenbanken. Oft habe ich über Feature Requests versucht, den AC in ein Instrument für die Erstellung beliebiger Datenbanken zu verwandeln. Viele Features wurden implementiert und ich denke, dass ich mit meinen Ideen sehr zur Vielseitigkeit des AC beigetragen habe. Gleichzeitig kann ich vom Produkt-Management nicht erwarten, dass sich der AC nur an meinen Bedürfnissen orientiert. Der AC hat Kunden mit zum Teil anderen Bedürfnissen, und die Priorisierung der Entwicklung obliegt dem AC.

In den letzten 4 Jahren habe ich den AC für alle Arten von Datenbank-Entwicklungen verwendet. Dabei musste ich auf einige Features des SQL Servers verzichten, wie temporale Tabellen (die in den SQL Server eingebaute Historisierung von Daten) oder Graph-Tabellen (Node und Edge). **Azure Synapse Analytics** hat eine teilweise andere Syntax, als der *normale* SQL Server, und nicht einmal Microsoft selbst schafft es, eine einfache Migration vom normalen SQL Server zu Synapse zu ermöglichen. Da wäre es vermessen, so etwas von Fremdprodukten wie dem AC zu verlangen.

Statt mich zu ärgern, dass der AC nicht alles unterstützt, was ich mir wünsche, werde ich den AC zukünftig gemäß seinem vorgesehenen Kontext verwenden und für die allgemeine Arbeit mit Datenbanken mein eigenes Toolkit. So entstand das Open-Source-Projekt [DataHandwerk-toolkit-mssql (Dokumentation)](https://datahandwerk.github.io/docs).

## Warum dieser Name und dieses Logo

>Als **Handwerk** werden zahlreiche gewerbliche Tätigkeiten bezeichnet, die Produkte meist auf Bestellung fertigen oder Dienstleistungen auf Nachfrage erbringen. Die handwerkliche Tätigkeit steht der industriellen Massenproduktion gegenüber.

Ein passendes Logo gibt es auch, denn das Deutsche Handwerkszeichen wurde 1934 vom Reichspräsidenten Paul von Hindenburg für das deutsche Handwerk gestiftet.

Im Jahrbuch des deutschen Handwerks von 1935 heißt es dazu:

>Der Hammer, der den offenen Ring schließt, bringt zum Ausdruck, wie das unfertige Material vom Handwerk zum schönen, ganzen Stück vollendet wird. Das Malkreuz auf dem Hammer deutet als altes Symbol schöpferischen Geschehens auf das Wesen deutscher Handwerksarbeit hin… Eichenblatt und Eichel, die zusammen mit dem Hammerstiel in Form der alten Hagal-Rune angeordnet sind, sollen die Einfügung des Handwerks in die völkische Lebensordnung … versinnbildlichen. Die Farben des Zeichens sind Blau in Gold, Blau ist die Farbe der Treue, Beständigkeit und Klarheit, Gold ist die Farbe der Vollendung. Durch Klarheit zur Vollendung ist der Sinn dieser Farben.

Das Handwerkszeichen war von 1934 war bis 1994 das offizielle Emblem des deutschen Handwerks, auch in der DDR, in abgewandelter Form dort auch als Symbol der Produktionsgenossenschaften des Handwerks (PGH). Es wird auch heute noch verschiedentlich benutzt. 

![DHW](../assets/img/blog/DatenHandwerk-toolkit-mssql.svg)

## Architektur des Projekts

Die [Architektur](https://datahandwerk.github.io/docs/dhw/0.1.0/arc/architecture.html) wird in der Dokumentation ausführlich auf Englisch beschrieben. Hier die Grundideen.

Meine wichtigste Anforderung ist, dass man in einer Datenbank selbst entwickeln kann, mit all ihren Features, und dass das Toolkit bei Bedarf eingesetzt werden *kann*, wenn sich dadurch ein Vorteil für den Entwickler ergibt. Eine Grundidee dabei ist es, dass über **extended Properties** Metadaten mit einem **Repository** abgeglichen werden. Mit diesem Konzept können Entwicklungen in der Datenbank mit solchen, die im **Repository** verwaltet werden, kombiniert werden. Diese Metadaten bleiben auch mit den Datenbank-Objekten verknüpft, wenn man Objekte mit ihren extended Properties in eine andere Datenbank kopiert.

Hier einige Diagramme aus der Architekturbeschreibung:

![structurizr-SystemLandscape](../assets/img/blog/structurizr-SystemLandscape.svg)

![structurizr-DWHBDevelopment-Container](../assets/img/blog/structurizr-DWHBDevelopment-Container.svg)

![structurizr-DWHBDevelopment-DWHdbDevelopmentProjectB-Component](../assets/img/blog/structurizr-DWHBDevelopment-DWHdbDevelopmentProjectB-Component.svg)

![structurizr-DWHBDevelopment-RepositorydbProjectB-Component](../assets/img/blog/structurizr-DWHBDevelopment-RepositorydbProjectB-Component.svg)

## Stand der Entwicklung

Es gibt bereits

- die Verbindung und Synchronisation zwischen Rpeository- und DWH-Datenbank
- einen Generator für Prozeduren (mit Konditionen, Unter-Prozeduren, eingebautem Logging)
- Unterstützung zur Erstellung von Persistierungen (mit oder ohne Historisierung in temporalen Tabellen) einschließlich der dafür verwendeten Prozeduren
- die Extraktion von Spalten-Abhängigkeiten durch Parsen des SQL Codes von Sichten
- Die Ablage und Verwendung von Abhängigkeiten zwischen Objekten, Spalten, Prozeduraufrufen  
  auch unter Verwendung von Graph-Tabellen
- virtuelle Indizies (PK, unique, normal)
- Vererbung von Eigenschaften unter Verwendung von Objekt- und Spalten-Referenzen
- ein optionales Logging-System, aus dem heraus auch Sequenzdiagramme in PlantUML erstellt werden können

## Dokumentation

Mit diesem open-Source-Projekt möchte ich auch Erfahrungen zur Dokumentation zukünftiger anderer Projekte aufbauen.

### Auszeichungssprache Markdown?

Sehr oft erfolgt die Dokumentation unter Verwendung der Auszeichungssprache Markdown (https://www.markdownguide.org/, https://de.wikipedia.org/wiki/Markdown)

- in den mir bekannten Wiki-Systemen wird mit Markdown gearbeitet (manchmal auch mit weiteren Auszeichungssprachen)
- Es gibt sehr viel und sehr gute Software Unterstützung für Markdown
  - Am PC verwende ich [Visual Studio Code](https://code.visualstudio.com/) zum Editieren und zur Vorschau von Markdown. Und es gibt sehr viele andere Möglichkeiten, mit Markdown zu arbeiten
  - Auf Android verwende ich [Markor](https://gsantner.net/project/markor.html), gelegentlich auch [Epsilon Notes](http://epsilonexpert.com/e/index.php?i=1)
- Diese Website hier wird mit dem Generator für statische Seiten [Jekyll](https://jekyllrb.com/) erstellt und seine Inhalte sind in Markdown geschrieben
- Meine Notizen schreibe ich in Markdown, da somit auch ein sehr einfacher Austausch zwischen Smartphone und PC möglich ist und die Notizen auch mit jedem beliebigen Plain-Text-Editor gelesen und bearbeitet werden können. Ich werde nicht zum Sklaven irgendeiner Software.
- Zur technischen Projektbeschreibung in Markdown gibt ein tolles open-source-Projekt: https://www.mkdocs.org/. Darauf basierend [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)


Doch Markdown hat auch einige Schwächen:

- alles muss in einem Dokument enthalten sein, es gibt kein "include", um Blöcke oder Inhalte aus anderen Dateien zu verwenden
- einen automatischen eingebauten TOC (Table of Content, Inhaltsverzeichnis) gibt es nicht, dieser muss separat erstellt werden
- es gibt nicht "das eine Markdown", sondern Dutzende verschiedene Dialekte, wobei diese Dialekte teilweise auf unterschiedliche Art und Weise versuchen, Markdown um fehlende Funktionen zu ersetzen.  
  Hier kann man testen, wie Markdown von verschiedenen Dialekten unterschiedlich in HTML konvertiert wird: [Test mit johnmacfarlane.net](https://johnmacfarlane.net/babelmark2/?normalize=1&text=*+A%0A+*+B%0A++*+C%0A+++*+D%0A++++*+E%0A+++++*+F%0A++++++*+G)

### Auszeichnungssprache Asciidoc!

GitHub Wiki hat Markdown Support, will oder kann aber nicht einen automatischen TOC erstellen. Doch GitHub Wiki und readme Dateien unterstützen nicht nur Markdown, sondern auch Asciidoc. Und Asciidoc kann den TOC "out of the box" erstellen.

Ich bin begeistert von den Möglichkeiten, die asciidoc im Vergleich zu markdown bietet, wenn es darum geht, eine gut formatierte Dokumentation zu erstellen. Ich kann auch Inhalte aus anderen Dokumenten einbinden. Es gibt eine Syntax, und nicht dutzende Dialekte.

https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/

Allerdings wird man für normale Bemerkungen weiter Markdown verwenden müssen, wenn man beispielsweise sowohl auf Android als auch am Rechner an Dokumenten arbeiten will. Denn mein Android-Editor Markor hat noch keine Asciidoc-Unterstütung implementiert: https://github.com/gsantner/markor/issues/808

### Docs-as-Code

Über Asciidoc fand ich das Konzept "Docs-as-Code".

- https://docs-as-co.de/
- https://www.informatik-aktuell.de/entwicklung/methoden/docs-as-code-die-grundlagen.html
- https://www.writethedocs.org/guide/docs-as-code/

"Docs-as-Code" und Asciidoc passen auch sehr gut zu meinen Versuchen, eine gute Dokumentation






Noch ist das Projekt nicht ausreichend dokumentiert und somit noch nicht wirklich für andere Anwender geeignet.
