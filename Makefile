ffi.js: ffi.hs wrapper.js
	hastec ffi.hs --with-js=wrapper.js --debug

worker.js: worker.hs worker-functions.js
	hastec worker.hs --with-js=worker-functions.js --debug --start=asap

all: worker.js ffi.js
