# wasm version, download latest compiled assets, launch the web server example.py and then go to http://localhost:8080/example/example.html
mkdir -p dist
wget -P dist --backups=1 $(printf "https://github.com/busytex/busytex/releases/latest/download/%s " busytex_pipeline.js busytex_worker.js    busytex.wasm busytex.js texlive-basic.js texlive-basic.data    ubuntu-texlive-latex-extra.data ubuntu-texlive-latex-extra.js    ubuntu-texlive-latex-recommended.data ubuntu-texlive-latex-recommended.js    ubuntu-texlive-science.data ubuntu-texlive-science.js)
python3 example/example.py