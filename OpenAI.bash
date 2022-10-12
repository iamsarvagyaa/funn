#!/bin/bash

data()
{

input_data=$(shuf -n 1 /home/runner/work/funn/funn/rngs)
cat <<EOF
{
    "model": "text-davinci-002",
    "prompt": "write adult and sarcastic joke for given related topic: $input_data",
    "temperature": 1,
    "max_tokens": 30,
    "top_p": 1,
    "frequency_penalty": 0.1,
    "presence_penalty": 0
}
EOF
}

curl -sL https://api.openai.com/v1/completions \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer "$OPENAI_TOKEN"" \
  -d "$(data)" | jq -r '.choices[].text' | awk 'NF' 
