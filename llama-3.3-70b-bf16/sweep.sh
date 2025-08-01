# usage: MODEL=YOUR_MODEL BASE_URL=YOUR_URL OUTFILE=YOUR_OUTFILE ./sweep.sh

CONCURRENCIES=(1 10 20 30 40 50 60 70 80 90)

INPUT_LEN=1000
OUTPUT_LEN=100
CC_MULT=20

for CONCURRENCY in "${CONCURRENCIES[@]}";
do
    NUM_PROMPTS=$(($CONCURRENCY * $CC_MULT))

    echo ""
    echo "===== RUNNING $MODEL FOR $NUM_PROMPTS PROMPTS WITH CONCURRENCY $CONCURRENCY ====="
    echo ""

    python3 vllm/benchmarks/benchmark_serving.py \
        --base-url ${BASE_URL} \
        --model ${MODEL} \
        --dataset-name random \
        --random-input-len ${INPUT_LEN} \
        --random-output-len ${OUTPUT_LEN} \
        --max-concurrency ${CONCURRENCY} \
        --num-prompts ${NUM_PROMPTS} \
        --seed $(date +%s) \
        --percentile-metrics ttft,tpot,itl,e2el \
        --metric-percentiles 90,95,99 \
        --ignore-eos \
        --save-result \
        --result-filename ${OUTFILE} \
        --append-result

done
