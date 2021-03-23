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

Mit meinem open-Source-Projekt [DataHandwerk-toolkit-mssql (Dokumentation)](https://datahandwerk.github.io/docs) möchte ich auch Erfahrungen zur Dokumentation zukünftiger anderer Projekte aufbauen. Warum habe ich mich für [Asciidoc](https://docs.asciidoctor.org/asciidoc/latest/syntax-quick-reference/) und [Antora](https://antora.org/) entschieden? Wie wurden einie Diagramme in der [Architektur-Beschreibung](https://datahandwerk.github.io/docs/dhw/0.1.0/arc/architecture.html) erstellt?

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
