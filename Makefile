worker.js: worker.hs worker-funs.js
	hastec worker.hs --with-js=worker-funs.js --start=asap

main.js: main.hs main-funs.js
	hastec main.hs --with-js=main-funs.js

clean:
	rm -rf worker.js main.js *.o *.hi main

all: worker.js main.js
