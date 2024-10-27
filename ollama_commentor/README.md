# OLLAMA COMMENTOR

This offering is similar to GPT Commentor, with the difference that it uses a locally installed ollama instance.  
The benefits of this approach include being able to pass sensitive information without having to worry about leakage, and greater control over the model providing the comments.  

## Pre-requisites

To use this script you will need the following:
- ollama installed on your local machine (full guide [here](https://ollama.com/download))
- at least one model installed with ollama (see the README [here](https://github.com/ollama/ollama))
- the ollama Python library (```pip install ollama```)
- optionally but preferrably: a good cpu/gpu with good cooling

## Setup

Specify the model you want to use in the ```model``` file and you're good to go. This can be any model you have previously installed with ollama.  

## Usage

Call from your current git working directory. I suggest creating an alias to save time.

```bash
python3 /path/to/ollama_commentor.py
```

ollama_commentor will send the generated git diff as well as the prompt and context to the chosen model and return a comment suggestion. You can (a)ccept, (r)etry, or (q)uit.  
- accepting will send ```git commit -am``` with the generated comment
- retrying will generate a new comment using the same information
- quitting will abort the script

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
