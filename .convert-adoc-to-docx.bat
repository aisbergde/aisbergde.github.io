@ECHO OFF
rem use input filename as parameter
rem example:
rem .convert-adoc-to-docx.bat Germo_Goertz_IT_profile.adoc
rem .convert-adoc-to-docx.bat Germo_Goertz_IT_profile_2.adoc
rem .convert-adoc-to-docx.bat test.adoc
rem .convert-adoc-to-docx.bat "test ccc ddd.adoc"
rem .convert-adoc-to-docx.bat adoc-syntax-quick-reference.adoc
rem mit folgendem Aufruf werden Bilder nicht exportiert, Der Aufruf muss also im Verzeichnis der zu exportierenden Datei erfolgen
rem .convert-adoc-to-docx.bat .\datamart\betty-barklay-plandaten.adoc 

rem echo %1
rem asciidoctor -b docbook test.adoc
rem pandoc -f docbook -t markdown -s test.xml -o test.md
rem pandoc -f docbook -t docx -s test.xml -o test.md

rem asciidoctor -b docbook %1
rem pandoc -f docbook -t markdown -s android-editor.xml -o android-editor.md

rem for %%f in (.\*.md) do kramdoc --lazy-ids --auto-id-prefix=_ --auto-id-separator=_ "%%f"

rem notwendige Installationen: pandoc, asciidoctor
rem choco install pandoc -y
rem sometimes pandoc doesn't work, check version:
rem pandoc --version

rem Install asciidoctor:
rem - zuerst ruby installieren, dann mit ruby asciidoctor
rem choco install ruby -y
rem gem install asciidoctor
rem asciidoctor --version


FOR %%i IN (%*) DO (
ECHO %%i
ECHO filedrive=%%~di
ECHO filepath=%%~pi
ECHO filename=%%~ni
ECHO fileextension=%%~xi
ECHO fullpath=%%~fni
echo asciidoctor -b docbook "%%~fni"
echo pandoc -f docbook -t docx --reference-doc=reference.docx -s "%%~pi%%~ni.xml" -o "%%~pi%%~ni.docx"
asciidoctor -b docbook "%%~fni"
pandoc -f docbook -t docx --reference-doc=reference.docx -s "%%~pi%%~ni.xml" -o "%%~pi%%~ni.docx"
)
