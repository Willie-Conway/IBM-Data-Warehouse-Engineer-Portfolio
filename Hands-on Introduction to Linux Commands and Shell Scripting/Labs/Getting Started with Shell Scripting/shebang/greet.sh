#!/bin/bash

# This script accepts the user's name and prints 
# a message greeting the user

# Print the prompt message on screen
echo -n "Enter your name : "

# Wait for user to enter a name, and save the entered name into the variable 'name'
read name

# Print the welcome message followed by the name
echo "Welcome $name"

# The following message should print on a single line. Hence the usage of '-n'
echo -n "Congratulations! You just created and ran your first shell script "
echo "using Bash on IBM Skills Network"



# Steps to Make It Executable

# Verify the path to Bash:

# which bash

# Output will be something like:

# /bin/bash

# Ensure the shebang line is at the top:
# Your script should begin with:

# #!/bin/bash
# Make the script executable:

# chmod u+x greet.sh
# Verify permissions:

# ls -l greet.sh
# You should see something like:

# -rwxr--r-- 1 theia users 250 Jul 10 23:30 greet.sh
# Run the script like a command:

# ./greet.sh