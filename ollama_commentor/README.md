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
or :
```bash
ollama_comment=$(python3 /path/to/ollama_commentor.py); git commit -am "$ollama_comment"
```

## Contact

For any questions or issues, please reach out to the project maintainer, open an issue or a PR.  
Stars and follows are always appreciated.
