# advanced_relational_model.py

from collections import defaultdict

# Simulated table: Each record is a row in the Employee-Project table
data = [
    {"EmployeeID": 1, "ProjectID": 101, "EmployeeName": "Alice", "ProjectName": "Project X", "Department": "HR"},
    {"EmployeeID": 1, "ProjectID": 102, "EmployeeName": "Alice", "ProjectName": "Project Y", "Department": "Finance"},
    {"EmployeeID": 2, "ProjectID": 101, "EmployeeName": "Bob", "ProjectName": "Project X", "Department": "HR"},
    {"EmployeeID": 3, "ProjectID": 101, "EmployeeName": "Charlie", "ProjectName": "Project X", "Department": "IT"},
    {"EmployeeID": 3, "ProjectID": 102, "EmployeeName": "Charlie", "ProjectName": "Project Y", "Department": "Finance"},
]

# Functional Dependency: EmployeeID -> EmployeeName
def check_fd_employee_id_to_name():
    fd_map = {}
    for row in data:
        eid = row["EmployeeID"]
        name = row["EmployeeName"]
        if eid in fd_map and fd_map[eid] != name:
            return False
        fd_map[eid] = name
    return True

# Functional Dependency: ProjectID -> ProjectName
def check_fd_project_id_to_name():
    fd_map = {}
    for row in data:
        pid = row["ProjectID"]
        pname = row["ProjectName"]
        if pid in fd_map and fd_map[pid] != pname:
            return False
        fd_map[pid] = pname
    return True

# Multi-Valued Dependency: EmployeeID ->> ProjectID
def check_mvd_employee_id_to_project_id():
    project_map = defaultdict(set)
    for row in data:
        project_map[row["EmployeeID"]].add(row["ProjectID"])
    return project_map

# Candidate Key Check: Unique combinations
def is_candidate_key(attributes):
    seen = set()
    for row in data:
        key = tuple(row[attr] for attr in attributes)
        if key in seen:
            return False
        seen.add(key)
    return True

def display_results():
    print("🔍 Advanced Relational Model Concepts\n")
    
    print("✅ Functional Dependencies:")
    print(f"  - EmployeeID → EmployeeName: {check_fd_employee_id_to_name()}")
    print(f"  - ProjectID → ProjectName: {check_fd_project_id_to_name()}")

    print("\n🔁 Multi-Valued Dependencies:")
    mvd = check_mvd_employee_id_to_project_id()
    for eid, projects in mvd.items():
        print(f"  - EmployeeID {eid} →> ProjectIDs {sorted(projects)}")

    print("\n🔐 Candidate Keys:")
    print(f"  - ['EmployeeID']: {is_candidate_key(['EmployeeID'])}")
    print(f"  - ['EmployeeID', 'ProjectID']: {is_candidate_key(['EmployeeID', 'ProjectID'])}")
    print(f"  - ['EmployeeName', 'ProjectID']: {is_candidate_key(['EmployeeName', 'ProjectID'])}")

    print("\n🎉 Summary Complete!")

if __name__ == "__main__":
    display_results()
