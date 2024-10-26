# GPT commentor

GPT Commentor is a simple Python script that generates a git commit comment from a ```git diff``` command.  

## Requirements

- an active subscription to ChatGPT Plus with enough API quota
- an OpenAI API key provided by (OpenAI)[openai.com]

## Setup

Export your OpenAI API key as an environment variable:
```bash
export OPENAI_TOKEN=<your_openai_api_key>
```

## Usage

Call from your current git working directory and it will generate a comment you can then use to commit your code.  

```bash
python3 /path/to/gpt_commentor.py
```

More advanced users might choose to create an alias:

```bash
alias gptcommit='GPT_RESPONSE=$(python3 /path/to/gpt_commentor.py) && git commit -am "$GPT_RESPONSE"'
```

## Contact

For any questions or issues, please reach out to the project maintainer, open an issue or a PR.  
Stars and follows are always appreciated.