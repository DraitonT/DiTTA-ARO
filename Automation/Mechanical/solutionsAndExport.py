import os

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

STAT_STRUC_SOLUTION.Activate()
STAT_STRUC.Solve(True)

# absolute_path = os.path.join(os.getcwd(), relative_path)

# Define the directory to save the files
output_directory = "data"

# Attempt to create the output directory, handle the case if it already exists
try:
    os.makedirs(output_directory)
except OSError:
    # Directory already exists, do nothing
    pass

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

# Loop through the analysis results and export to text files
for analysis_name, result_object in analysis_results.items():
    # Solve the analysis
    STAT_STRUC.Solve(True)
    
    # Define the relative path based on the analysis name
    relative_path = os.path.join(output_directory, "{}_results.txt".format(analysis_name.replace(' ', '_')))
    
    # Construct the absolute path
    absolute_path = os.path.join(os.getcwd(), relative_path)
    
    # Export the results to the file
    result_object.ExportToTextFile(absolute_path)
    
    print("Results for {} saved to {}".format(analysis_name, absolute_path))
