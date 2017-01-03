########################################################################################

DESTDIR = _site
.PHONY = all clean build install

########################################################################################

all: clean build

build: clean
	bundle exec jekyll build

play:
	bundle exec jekyll serve --drafts --watch

install: build
	rm -f _site/Gemfile
	rm -f _site/Gemfile.lock
	rsync -aPvz --delete _site/ "$(DESTDIR)"

deps:
	gem install bundler
	bundle install

clean:
	rm -rf _site/
