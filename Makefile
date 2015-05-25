.PHONY: build clean

build:
	coffee -o build/ -c src/
	cat build/*.js > build/engine-all.js
	cat build/isometric/*.js >> build/engine-all.js
	cat lib/*.js >> build/engine-all.js
	cp build/engine-all.js examples/hibiki/
	cp build/engine-all.js examples/isometric/
	find build -mindepth 1 -maxdepth 1 ! -name engine-all.js -exec rm -rf {} +


clean:
	rm -f src/*.js
	rm -rf build/*
