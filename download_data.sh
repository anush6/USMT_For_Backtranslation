#!/bin/bash

CURRENT="$PWD"

mkdir Data
cd  'Data'
mkdir MonoLingual_corpus
mkdir Parallel_corpus


cd 'MonoLingual_corpus'
echo 'Downloading MonoLingual_corpus for unsupervised machine translation ...'
echo 'English'
wget http://data.statmt.org/news-crawl/en/news.2018.en.shuffled.deduped.gz
gunzip news.2018.en.shuffled.deduped.gz
echo 'Completed downloading English monolingual data'
echo 'Russian'
wget http://data.statmt.org/news-crawl/ru/news.2017.ru.shuffled.deduped.gz
wget http://data.statmt.org/news-crawl/ru/news.2018.ru.shuffled.deduped.gz
gunzip news.2017.ru.shuffled.deduped.gz
gunzip news.2018.ru.shuffled.deduped.gz
echo 'Completed downloading Russian monolingual data'
echo 'Finished downloading monolingual data ..!!'
echo 'Extracting top 10M sentences'
head -n 10000000 news.2018.en.shuffled.deduped > news.10M.en
head -n 10000000 news.2018.ru.shuffled.deduped news.2017.ru.shuffled.deduped > news.10M.ru
echo 'Finished extracting top 10M sentences ..!!'
cd ..

cd 'Parallel_corpus'
echo 'Downloading parallel corpus'
wget http://data.statmt.org/news-commentary/v14/training/news-commentary-v14.en-ru.tsv.gz
gunzip news-commentary-v14.en-ru.tsv.gz
echo 'Finished downloading parallel corpus'
cd ..

# Write a python script to split tsv data
