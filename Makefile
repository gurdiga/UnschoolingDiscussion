default: posts

build:
	bundle exec jekyll build --incremental

start:
	bundle exec jekyll serve --incremental

s: start

# Group: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/
# Topics: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/topics?count=100
# Photos: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/photos
# Links: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/links
# API docs: https://www.archiveteam.org/index.php?title=Yahoo!_Groups

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

include .env
upload:
	lftp -u gurdiga@sandradodd.com ftp.sandradodd.com \
		--password $(LFTP_PASSWORD) \
		-e '\
			mirror --delete --reverse --parallel=5 --continue _site archive/UnschoolingDiscussion; \
			quit \
		'
