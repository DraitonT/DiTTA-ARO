import os
import time

# ------------- Python Script Script Information-------------
# Author Names: Michael Quach
# Team: DiTTA (ARO)
# Date: 12/16/23
# Tool Version: N/A
# Purpose of Script: Automatically runs Ansys Mechanical while changing the element size of each run
# results are then stored in their individual folders.
# and exports to desired location
# other .py files required: None
# other files required (not .js): None

############################## EDITABLE #############################

## 0.0 Select the folder you want to save the files [folder_directory]
## and the name of the run [output_directory]
locationOfCut = "convergenceStudy"
folder_directory = r"M:\dev\Ansys\Digital Twin"
output_directory = "data"

start = 0   # Start of the interval
end = 10    # End of the interval
step = 0.5    # Step size

############################## EDITABLE #############################

############################ NON-EDITABLE ###########################
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

desired_element_sizes = [x * step for x in range(start, int(end / step) + 1)]  # Create a range of element sizes

start_time = time.time()

# Access the mesh component
meshComponent = DataModel.Project.Model.Mesh

# Loop over the desired element sizes
for size in desired_element_sizes:
    # Update the element size
    meshComponent.ElementSize = Quantity(str(size) + ' [in]')
    
    # Generate the mesh with the new element size
    meshComponent.GenerateMesh()

    # Add the analysis to be conducted onto the model
    STAT_STRUC = DataModel.Project.Model.Analyses[0]
    STAT_STRUC_SOLUTION = STAT_STRUC.Solution
    STAT_STRUC_SOLUTION.Activate()

    # Add results
    totalDeformation = STAT_STRUC_SOLUTION.AddTotalDeformation()
    equivalentElasticStrain = STAT_STRUC_SOLUTION.AddEquivalentElasticStrain()
    maximumPrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMaximumPrincipalElasticStrain()
    middlePrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMiddlePrincipalElasticStrain()
    minimumPrincipalElasticStrain = STAT_STRUC_SOLUTION.AddMinimumPrincipalElasticStrain()
    equivalentStress = STAT_STRUC_SOLUTION.AddEquivalentStress()
    maximumPrincipalStress = STAT_STRUC_SOLUTION.AddMaximumPrincipalStress()
    middlePrincipalStress = STAT_STRUC_SOLUTION.AddMiddlePrincipalStress()
    minimumPrincipalStress = STAT_STRUC_SOLUTION.AddMinimumPrincipalStress()

    # Run the simulation
    STAT_STRUC_SOLUTION.Activate()
    STAT_STRUC.Solve(True)

    # Create a unique directory for each element size
    folder_safe_size = str(size).replace('.', 'p')
    size_directory = os.path.join(folder_directory, output_directory, locationOfCut, "elementsize" + folder_safe_size)
    os.makedirs(size_directory)

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

    # Export the results to text files for each result type in the specific element size folder
    for analysis_name, result_object in analysis_results.items():
        filename = "{}_results.txt".format(analysis_name.replace(' ', '_'))
        absolute_path = os.path.join(size_directory, filename)
        result_object.ExportToTextFile(absolute_path)
        print("Results for {} with element size {} saved to {}".format(analysis_name, size, absolute_path))
        
        # Delete the result object to free up memory
        result_object.Delete()

elapsed_time = time.time() - start_time
print("Elapsed time: {:.2f} seconds".format(elapsed_time))
############################ NON-EDITABLE ###########################