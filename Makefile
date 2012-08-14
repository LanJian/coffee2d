.PHONY: build clean

build:
	coffee -o build/ -c src/
	cat build/*.js > build/engine-all.js
	cat lib/*.js >> build/engine-all.js
	cp build/engine-all.js example/

clean:
	rm -f src/*.js
	rm -f build/*.js
	find . -name *~ | xargs rm -fv
