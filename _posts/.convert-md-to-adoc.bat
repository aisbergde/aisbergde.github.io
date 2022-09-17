@ECHO OFF
rem use input filename as parameter
rem example:
rem .convert-md-to-adoc.bat 2021-04-20-docs-as-code-mit-asciidoc.md
rem .convert-md-to-adoc.bat "test 03.md"

REM use https://github.com/asciidoctor/kramdown-asciidoc
REM read there, how to install
REM kramdown --version
REM gem install kramdown-asciidoc
REM test list files
REM for %%f in (.\a*.md) do @echo %%f

rem echo %1
rem asciidoctor -b docbook test.adoc
rem pandoc -f docbook -t markdown -s test.xml -o test.md

rem asciidoctor -b docbook %1
rem pandoc -f docbook -t markdown -s android-editor.xml -o android-editor.md

rem for %%f in (.\*.md) do kramdoc --lazy-ids --auto-id-prefix=_ --auto-id-separator=_ "%%f"

FOR %%i IN (%*) DO (
ECHO %%i
ECHO filedrive=%%~di
ECHO filepath=%%~pi
ECHO filename=%%~ni
ECHO fileextension=%%~xi
ECHO fullpath=%%~fni
echo kramdoc --lazy-ids --auto-id-prefix=_ --auto-id-separator=_ "%%~fni"
kramdoc --lazy-ids --auto-id-prefix=_ --auto-id-separator=_ "%%~fni"
)
