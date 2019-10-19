build:
	bundle exec jekyll build

start:
	bundle exec jekyll serve

s: start

# Group: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/
# Topics: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/topics?count=100
# Photos: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/photos
# Links: https://groups.yahoo.com/api/v1/groups/AlwaysLearning/links
# API docs: https://www.archiveteam.org/index.php?title=Yahoo!_Groups

.ONESHELL:

download:
	/Users/vlad/.rvm/rubies/ruby-2.3.4/bin/ruby downloader.rb

stats:
	@jq '.ygData.numTopics' topics.json
	@ls -1 topic-*.json | wc -l
	@du -shc topic-*.json | tail -1

edit:
	code -n .

e: edit
