---
title: automatisierte Datenbank-Dokumentation mit AnalyticsCreator
subtitle: Markdown Kommentare in Datenbank-Dokumentationen
tags: [analyticscreator, schemaspy, markdown, dokumentation]
---

* [Ziel: vollständige, verständliche und mit geringem Aufwand aktualisierbare Datenbankdokumentation mit MarkDown-Beschreibungen](#ziel-vollständige-verständliche-und-mit-geringem-aufwand-aktualisierbare-datenbankdokumentation-mit-markdown-beschreibungen)
  * [Programme zur Erstellung der Dokumentation per Knopfdruck](#programme-zur-erstellung-der-dokumentation-per-knopfdruck)
    * [SqlSpec von Elsasoft](#sqlspec-von-elsasoft)
    * [SchemaSpy](#schemaspy)
      * [SchemaMeta, der Link zu AnalyticsCreator Repository](#schemameta-der-link-zu-analyticscreator-repository)
* [Wie vereinfacht der AnalyticsCreator die in-code-Dokumentation von DWH?](#wie-vereinfacht-der-analyticscreator-die-in-code-dokumentation-von-dwh)
  * [AC-Parameter für die Vererbung und automatische Erstellung von Beschreibungen](#ac-parameter-für-die-vererbung-und-automatische-erstellung-von-beschreibungen)
  * [individuelle Überschreibung der Vererbung der Beschreibung pro Transformation / Tabelle](#individuelle-überschreibung-der-vererbung-der-beschreibung-pro-transformation--tabelle)
  * [Vererbung pro Spalte, individuelle Überschreibung](#vererbung-pro-spalte-individuelle-überschreibung)
* [Erstellung einer Datenbank-Dokumentation](#erstellung-einer-datenbank-dokumentation)
  * [Datenbank-Dokumentation mit dem AC](#datenbank-dokumentation-mit-dem-ac)
  * [Datenbank-Dokumentation mit SchemaSpy](#datenbank-dokumentation-mit-schemaspy)
    * [Erstellung der benötigten XML-Dateien mit dem RepoManipulator](#erstellung-der-benötigten-xml-dateien-mit-dem-repomanipulator)

## Ziel: vollständige, verständliche und mit geringem Aufwand aktualisierbare Datenbankdokumentation mit MarkDown-Beschreibungen

Zu jedem meiner BI-Projekte gehört eine Dokumentation. Um Prozesse, allgemeine Zusammenhänge, Ideen oder analytischen Datenbanken zu erklären, verwendete ich bisher gerne **WIKI**'s, die einige Vorteile haben:

* Anwender können dort kommentieren und Fragen stellen
* Screenshots aus Frontends erleichtern das Verständnis
* mehrere Personen können gemeinsam dokumentieren
* Ich fand **Markdown** als Auszeichnungssprache einfach und ausreichend
* ...

Ein vollständiges DWH würde ich nicht manuell dokumentieren, da sich früher oder später Dokumentation und DWH voneinander unterscheiden würden. Daraus ergeben sich einige Ziele für die Dokumentation meiner Datenbanken. Im folgenden geht es um die Dokumentation relationaler Datenbanken:

* Eine vollständige Dokumentation der Datenbank soll **per Knopfdruck** erstellt und aktualisiert werden
* Es muss einen **einzigen Punkt der Wahrheit** geben
    * Möglichst viele Informationen und Metadaten sollen **direkt in der Datenbank** enthalten sein
* Jede für das Verständnis wichtige Tabelle und Spalte soll eine sinnvolle **Beschreibung** erhalten
    * **Zeilenumbrüche** in Beschreibungen müssen möglich sein und angezeigt werden
    * die optionale Verwendung von **Auszeichnungssprachen** (Markdown, AsciiDoc) in Beschreibungen wäre gut:  
    Diese Sprachen lassen sich auch dann noch gut lesen, wenn sie nicht für die Darstellung gerendert werden
    * Beschreibungen sollen erstellt werden, **während ich die Datenbank entwickle**
* **Beziehungen** zwischen Objekten sollen dokumentiert werden
* **Abhängigkeiten** zwischen Objekten sollen dokumentiert werden

Um **Beschreibungen** im der Datenbank zu speichern, bieten sich im MS SQL Server die [**extended properties**](https://www.mssqltips.com/sqlservertip/5384/working-with-sql-server-extended-properties/) an. erweiterten Eigenschaften

* gibt es für alle Objekte und "Unter-Objekte" (Tabellen, Sichten, Spalten, Prozeduren, Schemas, ...)
* können per sql hinzugefügt und geändert werden
* können im SSMS hinzugefügt und geändert werden
* können sehr lang sein (sql_variant: nvarchar(4000) oder varchar(8000)), Zeilenumbrüche und was auch immer bleiben enthalten, ...

Einige **Abhängigkeiten** werden vom SQL Server erkannt:

* Abhängigkeiten zwischen Objekten werden gut erkannt
    * Sichten basieren auf Quell-Sichten
    * Prozeduren haben Abhängigkeiten von anderen Objekten.
* recht schwer ist die Extraktion von Spalten-Abhängigkeiten
* Nicht erkannt werden können viele *logische* Abhängigkeiten
    * So erkennt der SQL Server zwar folgende *technische* Abhängigkeiten
        * Quelle => Historisierungs-Prozedur
        * Historisierungs-**Tabelle** => Historisierungs-**Prozedur**
    * was ich aber darstellen möchte, ist die Logik des Datenflusses:
        * Quelle => Historisierungs-Prozedur
        * Historisierungs-**Prozedur** => Historisierungs-**Tabelle**

**Beziehungen** zwischen Objekten lassen sich nur schwer in der Datenbank abbilden.

* Man kann **"echte"** Fremdschlüsselbeziehungen zwischen Tabellen erstellen, dabei müssen die verknüpften Spalten den gleichen Datentyp haben (bei Zeichenfolgen auch die gleiche Länge).
* Es gibt keine "Boardmittel" zur Hinterlegung von **"virtuellen"** Indizes oder Beziehungen, beispielsweise zwischen Sichten und Sichten, zwischen Sichten und Tabellen.

### Programme zur Erstellung der Dokumentation per Knopfdruck

[System Informations Schema-Sichten des SQL Servers](https://docs.microsoft.com/de-de/sql/relational-databases/system-information-schema-views/system-information-schema-views-transact-sql?view=sql-server-ver15) enthalten einige benötigten Informationen. Man kann diese auslesen und wie auch immer verwenden.

Man kann auch Tools verwenden, die solche und weitere Informationen auslesen. Es gibt viele Tools, kostenlose und kostenpflichtige, verschiedene Projekte auf github und vielleicht auch an anderen Stellen. Hier eine unvollständige Übersicht:

[74 Database documentation tools](https://dbmstools.com/categories/database-documentation-tools)

Auf zwei Tools möchte ich näher eingehen

#### SqlSpec von Elsasoft

[SqlSpec von elsasoft.org](http://elsasoft.org/)

2005 gab es bei Microsoft einen Technologie-Wechsel von MSAS zu SSAS. Das kostenlose Excel-Tool, welches in der Lage war, MSAS vollständig zu dokumentieren, funktionierte nicht mehr mit SSAS. Ich brauchte ein neues Dokumentations-Tool für SSAS, verglich verschiedene Tools und sqlspec hatte die besten Möglichlichkeiten, SSAS-Modelle zu dokumentieren. Und gleichzeitig konnten damit relationale Datenbanken dokumentiert werden. Der Funktionsumfang ~~ist~~ war auch in der Evaluierungsversion vollständig. Ich habe 2005 eine Vollversion gekauft.

* **XML Kommentare** werden unterstützt und können von SqlSpec geparst werden
* **FK-PK-Beziehungen** werden erkannt, dargestellt, auch in *ER-Diagrammen*, allerdings sind das statische Diagramme ohne Verlinkung
* **interaktive ER-Diagramme** werden erstellt!
* **virtuelle Abhängigkeiten** können über *XML-Kommentare* hinzugefügt werden:  
  "Quelle => Prozedur => Ziel" kann abgebildet werden
* Die Dokumentation wird als html erstellt
* Die html-Dokumente können in eine Windows-Hilfe-Datei umgewandelt werden, wobei dabei Umlaute in Namen von Tabellen, Sichten und Prozeduren zu ungültigen Links führen. Das ist ein Problem des Microsoft-Hilfe-Konverters.

~~[Hier ein Beispiel für eine SQL Server Datenbank](http://elsasoft.org/samples/sqlserver_adventureworks/AdventureWorks.htm)~~ Leider gibt es die Website und das Produkt nicht mehr.

SqlSpec ~~ist~~ war ein hervorragendes Tool. Es ist in der mir vorliegenden letzten Version also so, wie es ist:

* **ohne Markdown** Unterstützung in Beschreibungen
* kann man virtuelle PK für Sichten hinzufügen?
* könnte man verschiedene Beziehungs-Typen definieren?  
  Vielleicht, zumindest geht es wohl, auch spezielle ER-Diagramme zu erstellen.

#### SchemaSpy

Auf der Suche nach Markdown-Unterstützung für Datenbank-Dokumentationen fand ich [SchemaSpy](http://schemaspy.org/)

Hier sieht man die Darstellung einer [Tabellen-Beschreibung, die Markdown verwendet](http://schemaspy.org/sample/index.html)

Es gibt eine [aktive Entwicklung auf GitHub](https://github.com/schemaspy/schemaspy), womit es theoretisch möglich wäre, gewünschte Features implementieren zu lassen. Ich habe vor einem Jahr diverse Feature Requests erstellt, leider tut sich da nichts. Und da man mit SchemaSpy nicht einmal das Schema anzeigen lassen kann, ist es weniger gut geeignet, Datenbankan mit mehreren Schemas zu dokumentieren. Ich habe die Hoffnung aufgegeben, dass das implementiert wird:

* [current schema must be shown on the page](https://github.com/schemaspy/schemaspy/issues/682)
* [option to include the Schema Name everywhere](https://github.com/schemaspy/schemaspy/issues/683)

Dennoch habe ich das Tool vor einem Jahr ausführlich getestet. Es wird JDBC verwendet und es war gar nicht so einfach einen funktionierenden JDBC-Treiber für den SQL Server auszuwählen. Folgende Kombination funktionierte:

```
## funktioniert mit sqljdbc_7.2
schemaspy.t=mssql08
schemaspy.dp="C:\Program Files\Microsoft JDBC Driver 7.2 for SQL Server\sqljdbc_7.2\enu"
```

Noch ein paar Parameter, um nicht nur ein Schema zu dokumentieren, sondern mehrere oder alle:

```
## Liste von Schemas, werden in der Reihenfolge aufgelistet
# schemaspy.schemas=dm dmt sti sth
schemaspy.all
```

Die Verwendung von **MarkDown in Beschreibungen** ist möglich.  
Wobei man aufpassen muss, dass SQL Server Kommentare nicht als MarkDown interpretiert werden.

```sql
/*Das wird kursiv dargestellt*/
/* Hier bleibt der Kommentar erhalten */
```

sieht dann so aus:

/*Das wird kursiv dargestellt*/  
/* Hier bleibt der Kommentar erhalten */

Sehr angenehm: Per Knopfdruck können durch den Anwender in den HTML-Seiten die Kommentare ein- und ausgeblendet werden.

Dokumentiert werden:

* Schemas
* Tabellen
* Sichten
* Routinen (Prozeduren, Funktionen)
* "echte" Fremdschlüssel-Beziehungen zwischen Tabellen, die es bei mir selten gibt
* irgendwelche [**Rail-Notationen**](https://gist.github.com/iangreenleaf/b206d09c587e8fc6399e#relations-in-models) können verwendet werden, um "virtuelle" Beziehungen zwischen Objekten zu erkennen:
  * `profile_id` wird dann wohl mit `profile.id` verknüpft  
* Es gibt **interaktive ER-Diagramme**! Man kann durch die Grafiken navigieren.

##### SchemaMeta, der Link zu AnalyticsCreator Repository

Mit [SchemaMeta](https://schemaspy.readthedocs.io/en/latest/configuration/schemaMeta.html) kann die Dokumentation über zusätzliche XML Dateien ergänzt werden.

Ab der geplanten Version 7.0 soll das Schema erweitert oder ein neues Schema eingeführt werden, mit welchem es wohl einfacher wird, alles darzustellen, was ich benötige.

Was ist mit dem aktuelle XML-Schema möglich?

* pro Datenbank-Schema muss eine separate XML-Datei mit zusätzlichen Metadaten erstellt werden
* **Beschreibungen** für Schemas, Tabellen und Spalten können hinzugefügt werden 
    * brauche ich eher nicht, da bei mir bereits alle Beschreibungen in der Datenbank enthalten sein sollen
    * könnte nützlich sein für die Objekte, die der AnalyticsCreator jedem DWH hinzufügt, ohne diese Objekte zu beschreiben: Objekte in den Schemas `CFG`, `Log`, `dbo`
* Spalten können als PK markiert werden  
  Man kann so sehr gut **logische PK in Sichten** dokumentieren
* **FK-PK-Beziehungen** können pro Spalte hinzugefügt werden
    * Da allerdings die Definition immer vom jeweiligen Schema ausgeht, funktioniert das aktuell nur gut innerhalb des eigenen Schemas oder vom aktuellen Schema in ein Nachbarschema. Allerdings habe ich dazu ein paar Bugs und Feature-Requests erstellt, das sollte lösbar sein.
    * Ein AnalyticsCreator Repository enthält sehr viele Informationen zu Beziehungen. Man müsste überlegen, welche davon wie sinnvoll zur Darstellung genutzt werden können:
        * Beziehungen in DataMart-Layern, die zur Erstellung von Tabellen-Beziehungen im SSAS verwendet werden, lassen sich sehr gut darstellen
        * Beziehungen nur innerhalb des eigenen Schemas wären etwas mager
        * man könnte tatsächlich verwendete Beziehungen darstellen, wenn man konsequent mit AC-Beziehungen arbeitet
        * ...
* Man könnte das Feature der *virtuellen FK-PK-Beziehungen* auch nutzen, um andere Beziehungen darzustellen, bespielsweise [**Data-Lineage auf Spaltenebene**](https://de.wikipedia.org/wiki/Data-Lineage), denn diese wertvollen Informationen gibt es im AnalyticCreator.
    * nötig wäre dazu, dass die verschiedenen Beziehungs-Typen in der Darstellung nicht vermischt werden, sondern getrennt dargestellt werden. Feature-Requests dazu wurden angelegt
    * Ich habe es einmal mit der aktuellen Version getestet: Man kann sich so zwar von der Kind-Spalte auf die Eltern-Spalte durchnavigieren, aber nicht umgekehrt. Denn eine Eltern-Spalte im `SchemaA` hat dort aktuell keine Informationen zu ihren Kinder-Spalten in `SchemaB` 
* **Abhängigkeiten zwischen Objekten, nicht auf Zeilenebene**:  
  aktuell noch nicht möglich, aber angefragt. Denn wenn schon Abhängigkeiten auf Spalten-Ebene dargestellt werden können, dann könnte man das auch gröber auf Objekt-Ebene realisieren. Es sollte dann möglich sein, den logischen Datenfluss so darzustellen, wir er aktuell im AnalyticsCreator im Diagramm zu sehen ist.

## Wie vereinfacht der AnalyticsCreator die in-code-Dokumentation von DWH?

Jedes Objekt kann mit einer Description versehen werden, die als [**extended properties**](https://www.mssqltips.com/sqlservertip/5384/working-with-sql-server-extended-properties/) in der Datenbank angelegt wird.

Ein hervorragendes Feature des AC sind **verschiedene Vererbungen**: Relationen, FriendlyName, Markierungen zur Anonymisierung und natürlich **Beschreibungen (Descriptions)**. 

Auch können **Beschreibungen automatisch erstellt** werden:
* aus Formeln / Berechnungen
* für Standard-Spalten wie die Spalten der Historisierung

### AC-Parameter für die Vererbung und automatische Erstellung von Beschreibungen

Die grundlegenden Eigenschaften der Vererbung können vom Entwickler über Parameter gesteuert werden. Die Einstellung der Parameter erfolgt projektspezfisch über das Frontend. 

Schauen wir einmal in der Repository-Datenbank nach, welche Parameter es gibt, die etwas mit 'Description' zu tun haben. Das sind eine ganze Menge. Natürlich kann man sich diese Liste auch direkt im AC anschauen:

Menu > Help > Parameter  
Dann "Search criteria" eigeben. 

Allerdings lässt der Inhalt von dort nicht so einfach als Tabelle für diesen Artikel hier verwenden, also verwende ich eine Abfrage direkt auf das Repository:

```sql
SELECT
       Param_Name
     , Default_Value
     , Description
     , Settable
FROM
     INTERN.PARAMETERS
WHERE Param_Name LIKE '%Descript%'
ORDER BY
         Param_Name;
```

 **Param_Name**                                  | **Description**                                                                                                                                                                                                                                                                       | **Default_Value**                                    
-------------------------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------------
 DESCRIPTION\_INHERIT\_TABLECOLUMNS              | Description inheritance from the table columns to the dependent table columns: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                         | 0                                                    
 DESCRIPTION\_INHERIT\_TABLES                    | Description inheritance from the tables to the dependent tables: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                                       | 0                                                    
 DESCRIPTION\_INHERIT\_TRANS                     | Description inheritance from the first transformation table to the transformation: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                     | 0                                                    
 DESCRIPTION\_INHERIT\_TRANSCOLUMNS              | Description inheritance from the table columns to the transformation columns: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                          | 0                                                    
 DESCRIPTION\_INHERIT\_TRANSTABLE\_COLUMNS       | Description inheritance from the transformation columns to the transtable columns: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                     | 1                                                    
 DESCRIPTION\_INHERIT\_TRANSTABLES               | Description inheritance from the transformations to the transtables: 0 \- inherit if empty, 1 \- always, 2 \- never                                                                                                                                                                   | 1                                                    
 DESCRIPTION\_PATTERN\_CALENDAR\_ID              | Autogenerated description of HIST\_ID \(SATZ\_ID\) field in calendar dimension\. You can use \{SchemaName\}, \{TableName\}, \{FriendlyName\}, \{SchemaID\} and \{TableID\} placeholders                                                                                               | Calendar ID                                          
 DESCRIPTION\_PATTERN\_DATEFROM                  | Autogenerated description of DATEFROM \(DAT\_VON\_HIST\) field\. You can use \{SchemaName\}, \{TableName\}, \{FriendlyName\}, \{SchemaID\} and \{TableID\} placeholders                                                                                                               | \{TableName\}: Start of validity period              
 DESCRIPTION\_PATTERN\_DATETO                    | Autogenerated description of DATETO \(DAT\_BIS\_HIST\) field\. You can use \{SchemaName\}, \{TableName\}, \{FriendlyName\}, \{SchemaID\} and \{TableID\} placeholders                                                                                                                 | \{TableName\}: End of validity period                
 DESCRIPTION\_PATTERN\_HIST\_ID                  | Autogenerated description of HIST\_ID \(SATZ\_ID\) field\. You can use \{SchemaName\}, \{TableName\}, \{FriendlyName\}, \{SchemaID\} and \{TableID\} placeholders                                                                                                                     | \{TableName\}: Surrogate key                         
 DESCRIPTION\_PATTERN\_SNAPSHOT\_ID              | Autogenerated description of HIST\_ID \(SATZ\_ID\) field in snapshot dimension \. You can use \{SchemaName\}, \{TableName\}, \{FriendlyName\}, \{SchemaID\} and \{TableID\} placeholders                                                                                              | Snapshot ID                                          
 DESCRIPTION\_SET\_SPECIAL                       | Automatically set description of special columns \(SnapshotID, Surrogate key, CalendarID\) : 0 \- yes if empty, 1 \- always, 2 \- never                                                                                                                                               | 0                                                    
 DESCRIPTION\_USE\_STATEMENTS                    | Use statement as description: 0 \- yes if empty \(priority over inherited description\), 1 \- always, 2 \- yes if empty \(inherited description has priority\), 3 \- never                                                                                                            | 0                                                    
 SAP\_DESCRIPTION\_LANGUAGE                      | SAP language to get table and field descriptions                                                                                                                                                                                                                                      | E                                                    
 SOURCE\_REFERENCE\_DESCRIPTION\_PATTERN         | Autogenerated source reference description\. You can use \{SourceSchema1\}, \{SourceName1\}, \{SourceID1\}, \{FriendlyName1\}, \{SourceSchema2\}, \{SourceName2\}, \{SourceID2\} and \{FriendlyName2\} placeholders                                                                   | FK\_\{SourceName1\}\_\{SourceName2\}                 
 SOURCE\_REFERENCE\_ONECOL\_DESCRIPTION\_PATTERN | Autogenerated one\-column source reference description\. You can use \{SourceSchema1\}, \{SourceName1\}, \{SourceID1\}, \{FriendlyName1\}, \{SourceSchema2\}, \{SourceName2\}, \{SourceID2\}, \{FriendlyName2\}, \{ColumnName\}, \{ColumnID\} and \{ColumnFriendlyName\} placeholders | RC\_\{SourceName1\}\_\{SourceName2\}\_\{ColumnName\} 
 SYNCHRONIZATION\_UPDATE\_DESCRIPTIONS           | Update object descriptions\. 0\-no, 1\-yes                                                                                                                                                                                                                                            | 1                                                    
 TABLE\_REFERENCE\_DESCRIPTION\_PATTERN          | Autogenerated table reference description\. You can use \{TableSchema1\}, \{TableName1\}, \{TableID1\}, \{FriendlyName1\}, \{TableSchema2\}, \{TableName2\}, \{TableID2\} and \{FriendlyName2\} placeholders                                                                          | FK\_\{TableName1\}\_\{TableName2\}                   
 TABLE\_REFERENCE\_ONECOL\_DESCRIPTION\_PATTERN  | Autogenerated one\-column table reference description\. You can use \{TableSchema1\}, \{TableName1\}, \{TableID1\}, \{FriendlyName1\}, \{TableSchema2\}, \{TableName2\}, \{TableID2\}, \{FriendlyName2\}, \{ColumnName\}, \{ColumnID\} and \{ColumnFriendlyName\} placeholders        | RC\_\{TableName1\}\_\{TableName2\}\_\{ColumnName\}   

**Ich ändere normalerweise einige Parameter, um eine strengere Vererbung zu erzwingen.** Damit stelle ich sicher, dass Vererbungen der Beschreibungen "durch das das ganze DWH hindurch" erfolgen.

 **Param_Name**                                  | **Param_Value**                                            
-------------------------------------------------|------------------------------------------------------------
 **DESCRIPTION\_INHERIT\_TABLECOLUMNS**          | 1                                                          
 **DESCRIPTION\_INHERIT\_TABLES**                | 0 (sinnvoll auch: 2)
 DESCRIPTION\_INHERIT\_TRANS                     | 0                                                          
 **DESCRIPTION\_INHERIT\_TRANSCOLUMNS**          | 1                                                          
 DESCRIPTION\_PATTERN\_CALENDAR\_ID              | Date                                                       
 **DESCRIPTION\_SET\_SPECIAL**                   | 1                                                          
 **DESCRIPTION\_USE\_STATEMENTS**                | 1                                                          
 SOURCE\_REFERENCE\_DESCRIPTION\_PATTERN         | FK\_\_\{SourceName1\}\_\_\{SourceName2\}                   
 SOURCE\_REFERENCE\_ONECOL\_DESCRIPTION\_PATTERN | RC\_\_\{SourceName1\}\_\_\{SourceName2\}\_\_\{ColumnName\} 
 TABLE\_REFERENCE\_DESCRIPTION\_PATTERN          | FK\_\_\{TableName1\}\_\_\{TableName2\}                     
 TABLE\_REFERENCE\_ONECOL\_DESCRIPTION\_PATTERN  | RC\_\_\{TableName1\}\_\_\{TableName2\}\_\_\{ColumnName\}   

### individuelle Überschreibung der Vererbung der Beschreibung pro Transformation / Tabelle

Mit obigen Parametern wird eine existierende Beschreibung aus einer Transformation oder Tabelle an alle Nachfolger vererbt. Das ist manchmal gewünscht, wenn ich beispielsweise bereits in Import-Tabellen eine Beschreibung erstelle, die sich bis in ein analytisches Modell in Dimensionen oder Measuregruppen vererben sollen.

Normalerweise ist es sinnvoller, in jeder Transformation zu beschreiben, wozu sie da ist, wie sie funktioniert usw. Und die automatischen Vererbungen entsprechen dann oft nicht dem Inhalt einer Transformation. Mit `DESCRIPTION_INHERIT_TABLES = 2` kann man diese Vererbung auch ganz abschalten und dann nur bei Bedarf die Beschreibung vererben. So verhindert man "Besschreibungs-Müll".

Beschreibungen vererben sich parametergesteuert (`DESCRIPTION_INHERIT_TRANSTABLES`) von einer Transformation auf die "Transformations-Tabelle" (das kleine T am Rechten Rand jeder Transformation). Diese "Transformations-Tabellen" sind virtuelle Tabellen, die der Struktur der Transformation entsprechen. Wer mit dem AC schon gearbeitet hat, weiß, was gemeint ist.

Das Gute ist (ich habe immer wieder darum gebeten, bis es implementiert wurde): man kann in jeder Transformation und Tabelle den Parameter individuell überschreiben. Dazu gibt es rechts oben die Auswahl-Boxen **Inherit Description**. Verwendet man beispielsweise die Standard-Einstellung der Vererbung, mit welcher eine Vererbung nur erfolgt, wenn die Beschreibung leer ist, dann kann die Vererbung auf "always" gesetzt werden.

Wichtig sind Beschreibungen der Transformationen vor allem im Datamart-Layer an, da genau diese Beschreibungen die Anwender der relationalen oder analytischen Datenbanken zu sehen bekommen. Man kann sogar kleine Romane schreiben mit Zeilenumbrüchen, die eine Dimension gut beschreiben. Und man könnte mit dem richtigen Frontend sogar Markdown verwenden. Hier ein Beispiel:

```
### Dimension Mandant

### Key

- Mandant

Mandanten sind ein Konstrukt, um mehrere Portfolios zusammenzufassen.
Portfolios können zu unterschiedlichem Zeitpunkt mit unterschiedlichem share zu Mandanten zusammengefasst werden.
Bei der Zusammensetzung von Mandanten kann für Auswertungen zwischen Oberfond und Subfond unterschieden werden.
```

### Vererbung pro Spalte, individuelle Überschreibung

Für die Vererbung der Beschreibungen (und FriendlyName) von Spalten habe ich mir schon einiges im AC einbauen lassen, was es mir nun ermöglicht, die Vererbung gut zu steuern.

Mit `DESCRIPTION_INHERIT_TABLECOLUMNS = 1` erzwinge ich, dass eine Beschreibung immer vererbt wird. Ich kann so eine Beschreibung bereits in der Datenquelle oder beim ersten Auftreten einer Spalte ändern und alles vererbt sich.

Mit `DESCRIPTION_USE_STATEMENTS = 1` erzwinge ich, dass ein Statement, also eine Formel, als Beschreibung vererbt wird. Da man dort auch Kommentare verwenden kann, ist es so möglich, zu beschreiben, was und warum in einer Spalte passiert. Beispiel:

```
/* zusammengesetzter String aus dynamischen Portfolio-Attributen (können sich im Verlauf der Zeit ändern) */
CONCAT(AssetKlasse, ';', AssetManager, ';', Ausrichtung, ';', Länderzone, ';', Disponibilität_MM, ';', Disponibilität_PM)
```

**Für manche Spalten ist es notwendig, die Beschreibung zu ändern, weil die vererbte Beschreibung nicht passt.** Seit nun jede Spalte die Eigenschaft `Inherit Description` hat, mit dem Standardwert "default", kann man diesen Wert individuell auf "if empty" ändern und an dieser Stelle eine neue Beschreibung erzwingen, die sich von da an wieder automatisch auf die Nachfolger vererbt.

Noch wichtiger ist es oft `Inhert FriendlyName` auf "if empty" zu setzen und einen neuen FriendlyName zu erzwingen.

Mit den `DESCRIPTION_PATTERN_...` werden Standard-Beschreibungen für einige immer wieder vorkommende Spalten definiert. Mit `DESCRIPTION_SET_SPECIAL = 1` wird erzwungen, dass diese Pattern auch zur Anwendung kommen, wenn sich der Inhalt einen Platzhalters wie `{TableName}` geändert hat.

## Erstellung einer Datenbank-Dokumentation

### Datenbank-Dokumentation mit dem AC

### Datenbank-Dokumentation mit SchemaSpy

#### Erstellung der benötigten XML-Dateien mit dem RepoManipulator

Mein 

*[BI]: Business Intelligence

*[DWH]: date warehouse

*[AC]: AnalyticsCreator

*[MSAS]: Microsoft SQL-Server Analysis Services

*[SSAS]: SQL Server Analysis Services
