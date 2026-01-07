#!/bin/bash
# This script asks a yes/no question and responds accordingly

# Prompt the user
echo 'Are you enjoying this course so far?'
echo -n 'Enter "y" for yes, "n" for no: '
read response


# Evaluate the response
if [ "$response" = "y" ]; then
    echo "✅ I'm pleased to hear you are enjoying the course!"
    echo "💬 Your feedback about what you’ve liked would be most welcome!"
elif [ "$response" = "n" ]; then
    echo "😟 I'm sorry to hear that."
    echo "📢 Please let us know what we can improve!"
else
    echo "⚠️ Your response must be either 'y' or 'n'."
    echo "🔁 Please re-run the script and try again."
fi



# To create, save, and run it:

# Create the file:

# nano conditional_script.sh

# Paste the script above, then save and exit (Ctrl+O, Enter, Ctrl+X in nano).

# Make it executable:

# chmod u+x conditional_script.sh

# Run the script:

# ./conditional_script.sh