#!/bin/bash
# Please provide input filename and output filename
bpe_operations=90000
bpe_threshold=50

moses_scripts=
prefix=
src=
trg=
data_dir=

cat $data_dir/$prefix.$src | \
$moses_scripts/tokenizer/normalize-punctuation.perl -l $src | \
$moses_scripts/tokenizer/tokenizer.perl -a -l $src > $data_dir/$prefix.tok.$src

cat $data_dir/$prefix.$trg | \
$moses_scripts/tokenizer/normalize-punctuation.perl -l $trg | \
$moses_scripts/tokenizer/tokenizer.perl -a -l $trg > $data_dir/$prefix.tok.$trg

$moses_scripts/training/clean-corpus-n.perl $data_dir/corpus.tok $src $trg $data_dir/corpus.tok.clean 1 80

$moses_scripts/recaser/train-truecaser.perl -corpus $data_dir/corpus.tok.clean.$src -model $model_dir/truecase-model.$src
$moses_scripts/recaser/train-truecaser.perl -corpus $data_dir/corpus.tok.clean.$trg -model $model_dir/truecase-model.$trg

$moses_scripts/recaser/truecase.perl -model $model_dir/truecase-model.$src < $data_dir/$prefix.tok.clean.$src > $data_dir/$prefix.tc.$src
$moses_scripts/recaser/truecase.perl -model $model_dir/truecase-model.$trg < $data_dir/$prefix.tok.clean.$trg > $data_dir/$prefix.tc.$trg

$moses_scripts/recaser/truecase.perl -model $model_dir/truecase-model.$src < $data_dir/$prefix.tok.$src > $data_dir/$prefix.tc.$src
$moses_scripts/recaser/truecase.perl -model $model_dir/truecase-model.$trg < $data_dir/$prefix.tok.$trg > $data_dir/$prefix.tc.$trg

$bpe_scripts/learn_joint_bpe_and_vocab.py -i $data_dir/corpus.tc.$src $data_dir/corpus.tc.$trg --write-vocabulary $data_dir/vocab.$src $data_dir/vocab.$trg -s $bpe_operations -o $model_dir/$src$trg.bpe

$bpe_scripts/apply_bpe.py -c $model_dir/$src$trg.bpe --vocabulary $data_dir/vocab.$src --vocabulary-threshold $bpe_threshold < $data_dir/$prefix.tc.$src > $data_dir/$prefix.bpe.$src
$bpe_scripts/apply_bpe.py -c $model_dir/$src$trg.bpe --vocabulary $data_dir/vocab.$trg --vocabulary-threshold $bpe_threshold < $data_dir/$prefix.tc.$trg > $data_dir/$prefix.bpe.$trg
