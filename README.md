# crawl

## How to run

### docker
```bash
$ docker build -t fetch-syllabus .
$ docker run --name fetch-syllabus -it -v `pwd`:/usr/app --rm fetch-syllabus /bin/bash
$ ruby .src/main.rb syllabuses.csv  # in container
```

## create Gemfile.lock
```bash
$ docker run --rm -v "$PWD":/usr/src/app -w /usr/src/app ruby:2.6 bundle install
```