Aktuell diesen Code im cmd Terminal verwenden (im Ordner, wo sich die Dateien befinden).
Funktioniert so nicht in PowerShell, wegen %date%

```
pandoc -s -o Germo_Goertz_IT_profile.docx goertz_profile_de.md pandoc_seitenumbruch_docx.md goertz_project_history_de.md pandoc_seitenumbruch_docx.md goertz_references.md --metadata date=%date%
```

folgender Coder erstellt auch ein TOC, das wird eher nicht benötigt.

```
pandoc -s --toc -o Germo_Goertz_IT_profile.docx goertz_profile_de.md pandoc_seitenumbruch_docx.md goertz_project_history_de.md pandoc_seitenumbruch_docx.md goertz_references.md --reference-doc=custom-reference-profile.docx --metadata date=%date%
```
Das mit dem Date klappt im cmd, für Powershell braucht man was anderes

