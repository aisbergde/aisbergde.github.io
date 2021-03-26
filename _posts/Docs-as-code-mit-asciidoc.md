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

Mit meinem open-Source-Projekt [DataHandwerk-toolkit-mssql (Dokumentation)](https://datahandwerk.github.io) möchte ich auch Erfahrungen zur Dokumentation zukünftiger anderer Projekte aufbauen. Warum habe ich mich für die Auszeichnungssprache [Asciidoc](https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/) statt Markdown und für das Dokumentations-Framework [Antora](https://antora.org/) entschieden? Wie wurden einige Diagramme in der [Architektur-Beschreibung](https://datahandwerk.github.io/dhw/0.1.0/arc/architecture.html) erstellt?

### Auszeichungssprache Markdown?

Sehr oft erfolgt die Dokumentation unter Verwendung der Auszeichungssprache Markdown (https://www.markdownguide.org/, https://de.wikipedia.org/wiki/Markdown)

- in den mir bekannten Wiki-Systemen wird mit Markdown gearbeitet (manchmal auch mit weiteren Auszeichungssprachen)
- Es gibt sehr viel und sehr gute Software-Unterstützung für Markdown
  - Am PC verwende ich [Visual Studio Code](https://code.visualstudio.com/) zum Editieren und zur Vorschau von Markdown. Und es gibt sehr viele andere Möglichkeiten, mit Markdown zu arbeiten
  - Auf Android verwende ich [Markor](https://gsantner.net/project/markor.html), gelegentlich auch [Epsilon Notes](http://epsilonexpert.com/e/index.php?i=1)
- Diese Website hier wird mit dem Generator für statische Seiten [Jekyll](https://jekyllrb.com/) erstellt und seine Inhalte sind in Markdown geschrieben
- Meine Notizen schreibe ich in Markdown, womit auch ein sehr einfacher Austausch zwischen Smartphone und PC möglich ist. Die Notizen können auch mit jedem beliebigen Plain-Text-Editor gelesen und bearbeitet werden. Ich werde nicht zum Sklaven einer Notiz-Software.
- Zur technischen Projektbeschreibung in Markdown gibt ein gutes open-source-Projekt: https://www.mkdocs.org/. Darauf basierend [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)

Doch Markdown hat auch einige Schwächen:

- alles muss in einem Dokument enthalten sein, es gibt kein "include", um Blöcke oder Inhalte aus anderen Dateien zu verwenden
- einen automatischen eingebauten TOC (Table of Content, Inhaltsverzeichnis) gibt es nicht, dieser muss separat erstellt werden
- es gibt nicht "das eine Markdown", sondern Dutzende verschiedene Dialekte, wobei diese Dialekte teilweise auf unterschiedliche Art und Weise versuchen, Markdown um fehlende Funktionen zu ersetzen.  
  Hier kann man testen, wie Markdown von verschiedenen Dialekten unterschiedlich in HTML konvertiert wird: [Test mit johnmacfarlane.net](https://johnmacfarlane.net/babelmark2/?normalize=1&text=*+A%0A+*+B%0A++*+C%0A+++*+D%0A++++*+E%0A+++++*+F%0A++++++*+G)

### Auszeichnungssprache Asciidoc!

Die GitHub Wiki hat Markdown Support, will oder kann aber nicht einen automatischen TOC erstellen. Doch GitHub Wiki und readme Dateien unterstützen nicht nur Markdown, sondern auch Asciidoc. Und Asciidoc kann den TOC "out of the box" erstellen. So fand ich zu Asciidoc.

Und ich bin begeistert von den Möglichkeiten, die asciidoc im Vergleich zu Markdown bietet, wenn es darum geht, eine gut formatierte Dokumentation zu erstellen. Ich kann auch Inhalte aus anderen Dokumenten einbinden. Es gibt eine Syntax, und nicht dutzende Dialekte. Variablen können verwendet werden. Dabei ist die Syntax ähnlich einfach, wie die von Markdown.

https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/

Allerdings werde ich für normale Bemerkungen weiter Markdown verwenden müssen, wenn ich sowohl auf Android als auch am Rechner an Dokumenten arbeiten will. Denn mein Android-Editor **Markor** hat leider noch keine Asciidoc-Unterstütung implementiert: https://github.com/gsantner/markor/issues/808

### Docs-as-Code und Code-as-Docs

Über Asciidoc fand ich das Konzept "Docs-as-Code".

- https://docs-as-co.de/
- https://www.informatik-aktuell.de/entwicklung/methoden/docs-as-code-die-grundlagen.html
- https://www.writethedocs.org/guide/docs-as-code/

"Docs-as-Code" und Asciidoc passen auch sehr gut zu meinen Versuchen mit "Code-as-Docs", also eine aktuelle Dokumentation direkt aus dem Code oder unter Verwendung des Codes zu erstellen. Denn mit Asciidoc kann man den Inhalt anderer Dokumente einbeziehen.

Ein Beispiel sieht man auf dieser Seite: https://datahandwerk.github.io/dhw/0.1.0/manual/create-update-connect-repo-db.html  
Hier werden

- Text-Inhalte anderer Dokumente zitiert
- die gleichen in PlantUML definierten Diagramme verwendet, wie auch in den Architektur-Dokumenten
- Am Ende des Dokuments werden SQL-Dateien aus dem Datenbank-Projekt eingebunden. Wenn sich dort der Code ändert, kommen diese Änderungen auch in der Dokumentation an.

### docToolchain

https://doctoolchain.github.io/docToolchain/

>docToolchain is an implementation of the docs-as-code approach for software architecture plus some additional automation. The basis of docToolchain is the philosophy that software documentation should be treated in the same way as code together with the arc42 template for software architecture.

Ich war begeistert, wie schnell sich das nicht nur installieren ließ, sondern dass auch sofort alles auf Anhieb funktionierte. Ein Kommando im Terminal, und kurz darauf war alles in schönstem HTML5 gerendert: Die Inhalte eingesammelt aus verschiedenen Dateien, Diagramme in PlantUML definiert, man kann sogar Excel verwenden, um auch entwas komplizierte Tabellen in Excel zu erstellen und in Asciidoc zu exportieren (zur weiteren Verarbeitung).

Genau so einfach war es, basierend auf einem Template https://github.com/docToolchain/arc42-template-project auf Knopfdruck eine fertige Mico-Site zu erstellen: https://arc42-demo.netlify.app/ Diese Idee gefiel mir so gut, dass ich ursprünglich damit auch meine Projekt-Dokumentation erstellen wollte. Im Beispiel sieht das auch alles sehr schön aus, in der Praxis ist aber der TOC auf der linken Seite fest eingebaut und hat keine vertikale Scrollbar. So dass damit Inhalte am unteren Rand abgeschnitten werden und nicht erreichbar sind:  

![](/assets/img/blog/Docs-as-code-mit-asciidoc_2021-03-26-01-41-35.png)

Leider habe ich nicht gefunden, wie man das im CSS (oder wo auch immer) ändern müsste. Und irgendwann aufgegeben: https://github.com/docToolchain/arc42-template-project/issues/7

doctoolchain funktioniert sehr gut innerhalb eines eigenen Repositories. Wenn man Daten aus anderen Repositories einsammeln will, dann geht das auch, wenn man lokal arbeitet.

### arc42

doctoolchain ist mit den Leuten von [arc42](https://arc42.org/) verbandelt.

>arc42 enthält ein erprobtes und pragmatisches Template zur Entwicklung, Dokumentation und Kommunikation von Softwarearchitekturen. Tausende zufriedene Nutzer weltweit.

Also habe ich mir das angeschaut und für gut befunden. Mein Architektur-Dokument basiert auf diesem Template: https://datahandwerk.github.io/dhw/0.1.0/arc/architecture.html

### Structurizr DSL und das C4 Modell für die Visualizierung von Software-Architektur




### Antora

DBML?