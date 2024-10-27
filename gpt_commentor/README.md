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

The default model is ```gpt-3.5-turbo``` (line 53). Do feel free to change it, but beware the charges...!

## Usage

Call from your current git working directory and it will generate a comment you can then use to commit your code.  

```bash
python3 /path/to/gpt_commentor.py
```

More advanced users might choose to create an alias:

```bash
alias gptcommit='python3 /path/to/gpt_commentor.py'
```

gpt_commentor will send the generated git diff as well as the prompt and context to the chosen model and return a comment suggestion. You can (a)ccept, (r)etry, or (q)uit.  
- accepting will send ```git commit -am``` with the generated comment
- retrying will generate a new comment using the same information
- quitting will abort the script

```bash 
g$ gptcommit
Suggested commit message:
chore(gpt_commentor/CHANGELOG.md): added user decision loop.

Do you want to (a)ccept, (r)etry, or (q)uit? a
[gpt_commentor c8dd832] feat(ollama_commentor): added user decision loop.
 2 files changed, 11 insertions(+)
 create mode 100644 gpt_commentor/CHANGELOG.md
Commit has been made successfully.
```

## Known bugs and limits

If the diff exceeds the token limit of the model used it will often be wrong.  
If you add new files and do not ```git add``` before using the script it will hallucinate a comment:
```bash
$ gptcommit
Suggested commit message:
fix(src/index.js): Fix issue with missing semicolon.
```

## Contact

For any questions or issues, please reach out to the project maintainer, open an issue or a PR.  
Stars and follows are always appreciated.
