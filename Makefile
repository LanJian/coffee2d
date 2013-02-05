.PHONY: build clean

build:
	coffee -o build/ -c src/
	cat build/*.js > build/engine-all.js
	cat build/isometric/*.js >> build/engine-all.js
	cat lib/*.js >> build/engine-all.js

clean:
	rm -f src/*.js
	rm -rf build/*
	find . -name *~ | xargs rm -fv
