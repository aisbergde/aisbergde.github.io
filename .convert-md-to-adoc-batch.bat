REM @ECHO OFF
REM use https://github.com/asciidoctor/kramdown-asciidoc
REM read there, how to install
REM kramdown --version
REM gem install kramdown-asciidoc
REM test list files
REM for %%f in (.\a*.md) do @echo %%f

for %%f in (.\*.md) do kramdoc --lazy-ids --auto-id-prefix=_ --auto-id-separator=_ "%%f"
