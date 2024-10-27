import os
import subprocess
from openai import OpenAI, OpenAIError

# Fetch the API key from environment variable
def get_api_key():
    api_token = os.getenv("OPENAI_TOKEN")
    if not api_token:
        raise ValueError("OPENAI_TOKEN environment variable not set")
    return api_token

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

# Send request to OpenAI API and retrieve response
def get_chatgpt_response(api_token, model, context, prompt):
    client = OpenAI(
        api_key = api_token
    )
    try:
        response = client.chat.completions.create(
            model=model,
            messages=[
                {"role": "system", "content": context},
                {"role": "user", "content": prompt}
            ]
        )
        return response.choices[0].message.content
    except OpenAIError as e:
        print("Error during OpenAI API call:", e)
        exit(1)

# Main function to orchestrate the steps
def main():
    # Configuration
    model = "gpt-3.5-turbo"  # Specify the model (e.g., "gpt-4", "gpt-3.5-turbo")

    # Get necessary elements
    api_key = get_api_key()
    prompt = read_file_content("prompt")
    context = read_file_content("context")
    git_output = get_git_output()

    # Final prompt includes prompt + git output
    final_prompt = f"{prompt}\n\n{git_output}"

    # Loop for user decision
    while True:
        # Get response from ChatGPT
        response = get_chatgpt_response(api_key, model, context, final_prompt)
        print(f"Suggested commit message:\n{response}\n")

        # Prompt the user for an action
        user_input = input("Do you want to (a)ccept, (r)etry, or (q)uit? ").strip().lower()

        if user_input == 'a':
            # User accepted the suggestion
            os.system(f'git add . && git commit -am "{response}"')
            print("Commit has been made successfully.")
            break
        elif user_input == 'r':
            # User wants to retry, so continue to generate a new suggestion
            print("Generating a new suggestion...")
            continue
        elif user_input == 'q':
            # User wants to quit
            print("Process aborted by user.")
            break
        else:
            print("Invalid input. Please enter 'a' to accept, 'r' to retry, or 'q' to quit.")

if __name__ == "__main__":
    main()
