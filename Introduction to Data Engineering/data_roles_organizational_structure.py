# 🛢️ Data Roles Organizational Structure

# This program simulates a mini organizational chart of data-related 
# roles and categorizes them into technical, analytical, governance, 
# and leadership areas. This is great for beginners exploring data career 
# paths or educators explaining organizational structure.

# Define role categories
data_roles = {
    "Technical": [
        "Data Engineer",
        "Machine Learning Engineer",
        "Database Administrator"
    ],
    "Analytical": [
        "Data Analyst",
        "Data Scientist"
    ],
    "Governance and Privacy": [
        "Data Governance Associate",
        "Data Steward",
        "Compliance Specialist",
        "Data Ethics Steward",
        "Data Privacy Officer"
    ],
    "Leadership": [
        "Data Architect",
        "Chief Data Officer (CDO)",
        "Data Ethics Officer"
    ]
}

# Function to display org chart
def display_org_chart(roles_dict):
    print("📊 Data-Related Roles Organizational Chart\n")
    for category, roles in roles_dict.items():
        print(f"🔹 {category} Roles:")
        for role in roles:
            print(f"   - {role}")
        print()  # line break for readability

# Run the program
if __name__ == "__main__":
    display_org_chart(data_roles)





# ✅ Output:

# 📊 Data-Related Roles Organizational Chart

# 🔹 Technical Roles:
#    - Data Engineer
#    - Machine Learning Engineer
#    - Database Administrator

# 🔹 Analytical Roles:
#    - Data Analyst
#    - Data Scientist

# 🔹 Governance and Privacy Roles:
#    - Data Governance Associate
#    - Data Steward
#    - Compliance Specialist
#    - Data Ethics Steward
#    - Data Privacy Officer

# 🔹 Leadership Roles:
#    - Data Architect
#    - Chief Data Officer (CDO)
#    - Data Ethics Officer
