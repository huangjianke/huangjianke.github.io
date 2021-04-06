#!/usr/bin/env bash

bundle exec jekyll build --incremental
git add .
git commit -m "update"
git push -u origin master