default: posts

rsync:
	rsync -avz _site/ root@ssh.sandradodd.com:/var/www/site/archive/UnschoolingDiscussion/

build:
	bundle exec jekyll build

start:
	bundle exec jekyll serve

s: start

.ONESHELL:

posts:
	rvm `cat .ruby-version` do ruby create-posts.rb
	rm -vf _posts/*-1515.html

cache:
	rvm `cat .ruby-version` do ruby downloader.rb
.PHONY: cache

clean-cache:
	rm -v \
		cache/topics.json \
		cache/topic-`jq .ygData.lastTopic cache/topics.json`.json

clean:
	find _posts -type f -delete
	rm -rf _site

stats:
	@jq '.ygData.numTopics' cache/topics.json
	@ls -1 cache/ | wc -l
	@du -shc cache/ | tail -1

edit:
	code -n .

e: edit

a: audit
audit:
	bundle exec bundle-audit

au: audit-update
audit-update:
	bundle exec bundle-audit update

i: install
install:
	bundle install

u: update
update:
	bundle update
