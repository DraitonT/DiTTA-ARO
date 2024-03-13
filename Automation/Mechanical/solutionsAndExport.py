import os
import time
# ------------- Python Script Script Information-------------
# Author Names: Michael Quach
# Team: DiTTA (ARO)
# Date: 10/12/23
# Tool Version: N/A
# Purpose of Script: Runs the simulation in Ansys Mechanical and exports to desired location
# other .js files required: None
# other files required (not .js): None

############################## EDITABLE #############################

## 0.0 Select the folder you want to save the files [folder_directory] and the name of the run [output_directory]

locationOfCut = "0800"
folder_directory = r"M:\dev\Ansys\Digital Twin\data"
output_directory = "runsMarch"
size = 0.185
############################## EDITABLE #############################

############################ NON-EDITABLE ###########################
start_time = time.time()
## 1.0 Adds the analysis to be conducted onto the model

STAT_STRUC = DataModel.Project.Model.Analyses[0]
STAT_STRUC_SOLUTION = STAT_STRUC.Solution

STAT_STRUC_SOLUTION.Activate()

totalDeformation = STAT_STRUC_SOLUTION.AddTotalDeformation()
equivalentElasticStrain = STAT_STRUC_SOLUTION.AddEquivalentElasticStrain()
maximumPrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMaximumPrincipalElasticStrain()
middlePrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMiddlePrincipalElasticStrain()
minimumPrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMinimumPrincipalElasticStrain()
equivalentStress = STAT_STRUC_SOLUTION.AddEquivalentStress()
maximumPrincipalStress = STAT_STRUC_SOLUTION.AddMaximumPrincipalStress()
middlePrincipalStress = STAT_STRUC_SOLUTION.AddMiddlePrincipalStress()
minimumPrincipalStress = STAT_STRUC_SOLUTION.AddMinimumPrincipalStress()

## 1.0.1 Runs the simulation
STAT_STRUC_SOLUTION.Activate()
STAT_STRUC.Solve(True)
full_path = os.path.join(folder_directory, output_directory, locationOfCut)

def delete_directory(path):
    # Check if the directory exists
    if os.path.exists(path):
        # Remove all files and subdirectories
        for root, dirs, files in os.walk(path, topdown=False):
            for name in files:
                os.remove(os.path.join(root, name))
            for name in dirs:
                os.rmdir(os.path.join(root, name))
        # Remove the now-empty directory
        os.rmdir(path)
## 1.1 Saving the simulation data to desired directory
# Attempt to create the output directory, handle the case if it already exists
try:
    os.makedirs(full_path)
except OSError:
    # Directory already exists, delete path and its contents
    delete_directory(full_path)
    pass

# Access the mesh component
meshComponent = DataModel.Project.Model.Mesh
meshComponent.ElementSize = Quantity(str(size) + ' [in]')

# Generate the mesh with the new element size
meshComponent.GenerateMesh()
    
# Dictionary to map analysis names to result objects
analysis_results = {
    "Total Deformation": totalDeformation,
    "Equivalent Elastic Strain": equivalentElasticStrain,
    "Maximum Principal Elastic Strain": maximumPrincipalElasticStrain,
    "Middle Principal Elastic Strain": middlePrincipalElasticStrain,
    "Minimum Principal Elastic Strain": minimumPrincipalElasticStrain,
    "Equivalent Stress": equivalentStress,
    "Maximum Principal Stress": maximumPrincipalStress,
    "Middle Principal Stress": middlePrincipalStress,
    "Minimum Principal Stress": minimumPrincipalStress
}

# 1.1 Loop through the analysis results and export to text files
for analysis_name, result_object in analysis_results.items():
    # Solve the analysis
    STAT_STRUC.Solve(True)
    
    # Define the relative path based on the analysis name
    relative_path = os.path.join(output_directory, locationOfCut, "{}_results.txt".format(analysis_name.replace(' ', '_')))
    
    # Construct the absolute path
    absolute_path = os.path.join(folder_directory, relative_path)
    
    # Export the results to the file
    result_object.ExportToTextFile(absolute_path)
    
    print("Results for {} saved to {}".format(analysis_name, absolute_path))
    result_object.Delete()
elapsed_time = time.time() - start_time
print("Elapsed time: {:.2f} seconds".format(elapsed_time))
############################ NON-EDITABLE ###########################