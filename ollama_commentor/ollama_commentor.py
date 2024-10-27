import os
import subprocess
import ollama

# Load content from a file in the script's directory
def read_file_content(filename):
    script_dir = os.path.dirname(os.path.abspath(__file__))
    file_path = os.path.join(script_dir, filename)
    try:
        with open(file_path, 'r') as file:
            return file.read().strip()
    except FileNotFoundError:
        raise FileNotFoundError(f"File '{filename}' not found in script directory '{script_dir}'.")
    except IOError as e:
        raise IOError(f"Error reading file '{filename}': {e}")

# Run the git command and capture the output, handling errors
def get_git_output():
    try:
        return subprocess.check_output(["git", "diff", "HEAD"], text=True)
    except subprocess.CalledProcessError as e:
        print("Error running git show command:", e)
        exit(1)

# Send request to Ollama and retrieve response
def get_ollama_response(model, context, prompt):
    try:
        response = ollama.chat(
            model=model,
            messages=[
                {"role": "system", "content": context},
                {"role": "user", "content": prompt}
            ]
        )
        
        # Extract the 'content' from the 'message' in the response
        if "message" in response and "content" in response["message"]:
            return response["message"]["content"]
        else:
            raise ValueError("Unexpected response structure")

    except Exception as e:
        print("Error during Ollama model call:", e)
        exit(1)

# Main function to orchestrate the steps
def main():
    # Get the model name from the 'model' file
    model = read_file_content("model")

    # Get necessary elements
    prompt = read_file_content("prompt")
    context = read_file_content("context")
    git_output = get_git_output()

    # Final prompt includes prompt + git output
    final_prompt = f"{prompt}\n\n{git_output}"

    # Get response from the Ollama model and print
    response = get_ollama_response(model, context, final_prompt)
    print(response)

if __name__ == "__main__":
    main()