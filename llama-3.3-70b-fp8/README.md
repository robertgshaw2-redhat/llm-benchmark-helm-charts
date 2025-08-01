# Interactive Benchmark

### 1. Create the interactive pod

```bash
kubectl apply -f manifest.yaml
```

### 2. Exec into the pod and run a benchmark

```bash
NAMESPACE="test"

just exec-bench $NAMESPACE
```

#### Eval

- From within the pod, run the following to run `lm-eval`:

```bash
MODEL=RedHatAI/Llama-3.3-70B-Instruct-FP8-dynamic
NAMESPACE=test
GATEWAY_URL=http://10.16.0.216
CONCURRENT=100
LIMIT=1000

just eval $MODEL $GATEWAY_URL $CONCURRENT $LIMIT

>> |Tasks|Version|     Filter     |n-shot|  Metric   |   |Value|   |Stderr|
>> |-----|------:|----------------|-----:|-----------|---|----:|---|-----:|
>> |gsm8k|      3|flexible-extract|     5|exact_match|↑  |0.938|±  |0.0076|
>> |     |       |strict-match    |     5|exact_match|↑  |0.908|±  |0.0091|
```

#### Benchmark

- From within the pod, run the following to sweep over concurrencies (modify `./sweep.sh` to edit the scenario):

```bash
MODEL=RedHatAI/Llama-3.3-70B-Instruct-FP8-dynamic
NAMESPACE=llm-d
GATEWAY_URL=http://10.16.0.216
OUTFILE=results.json

just sweep $OUTFILE $GATEWAY_URL
```

- You can copy over the results with:

```bash
NAMESPACE=test

./get-files $NAMESPACE results
```
