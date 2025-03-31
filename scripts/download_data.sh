#! /bin/bash

scripts=$(dirname "$0")
base=$scripts/..

data=$base/data

mkdir -p $data

tools=$base/tools

# link default training data for easier access

mkdir -p $data/wikitext-2

for corpus in train valid test; do
    absolute_path=$(realpath $tools/pytorch-examples/word_language_model/data/wikitext-2/$corpus.txt)
    ln -snf $absolute_path $data/wikitext-2/$corpus.txt
done

# download a different interesting data set!

mkdir -p $data/frankenstein

mkdir -p $data/frankenstein/raw

curl -O https://www.gutenberg.org/cache/epub/84/pg84.txt
mv pg84.txt $data/frankenstein/raw/frankenstein.txt

# preprocess slightly

cat $data/frankenstein/raw/frankenstein.txt | python $base/scripts/preprocess_raw.py > $data/frankenstein/raw/frankenstein.cleaned.txt

# tokenize, fix vocabulary upper bound

cat $data/frankenstein/raw/frankenstein.cleaned.txt | python $base/scripts/preprocess.py --vocab-size 5000 --tokenize --lang "en" --sent-tokenize > \
    $data/frankenstein/raw/frankenstein.preprocessed.txt

# split into train, valid and test

head -n 787 $data/frankenstein/raw/frankenstein.preprocessed.txt | tail -n 750 > $data/frankenstein/valid.txt
head -n 1537 $data/frankenstein/raw/frankenstein.preprocessed.txt | tail -n 750 > $data/frankenstein/test.txt
tail -n 6200 $data/frankenstein/raw/frankenstein.preprocessed.txt | head -n 6100 > $data/frankenstein/train.txt
