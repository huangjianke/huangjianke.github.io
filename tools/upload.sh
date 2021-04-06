#!/usr/bin/env bash

JEKYLL_ENV=production bundle exec jekyll build
git add .
git commit -m "update"
git push -u origin master