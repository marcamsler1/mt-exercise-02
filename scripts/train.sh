#! /bin/bash

scripts=$(dirname "$0")
base=$(realpath $scripts/..)

models=$base/models
data=$base/data
tools=$base/tools
logs=$base/logs

mkdir -p "$models"
mkdir -p "$logs"

num_threads=4
device=""

SECONDS=0

dropouts=(0 0.3 0.4 0.5 0.6)

for dropout in "${dropouts[@]}"; do
    echo "Training model with dropout = $dropout"

    model_file="$models/model_dropout_${dropout}.pt"
    log_file="$logs/log_dropout_${dropout}.txt"

    (cd "$tools/pytorch-examples/word_language_model" &&
        CUDA_VISIBLE_DEVICES=$device OMP_NUM_THREADS=$num_threads python main.py --data "$data/frankenstein" \
            --epochs 40 \
            --log-interval 100 \
            --emsize 200 --nhid 200 --dropout "$dropout" --tied \
            --save "$model_file" \
            --logfile "$log_file"
    )
done

echo "time taken:"
echo "$SECONDS seconds"
