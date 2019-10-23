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
	rm ./_posts/2013-01-15-113579.html # Because it’s a placeholder; could not read from API.


cache:
	rvm `cat .ruby-version` do ruby downloader.rb
.PHONY: cache

clean:
	rm -v \
		cache/topics.json \
		cache/topic-`jq .ygData.lastTopic cache/topics.json`.json

stats:
	@jq '.ygData.numTopics' cache/topics.json
	@ls -1 cache/ | wc -l
	@du -shc cache/ | tail -1

edit:
	code -n .

e: edit
