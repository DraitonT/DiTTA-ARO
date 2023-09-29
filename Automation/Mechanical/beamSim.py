#Scenario 1: Store main Tree Object items
# https://ansyshelp.ansys.com/account/secured?returnurl=/Views/Secured/corp/v232/en/act_script/act_script_demo_trans_struct.html
MODEL = Model
GEOM = MODEL.Geometry
COORDINATE_SYSTEMS = Model.CoordinateSystems
MESH = Model.Mesh
NAMED_SELECTIONS = Model.NamedSelections

PARTS = GEOM.GetChildren(DataModelObjectCategory.Part,False)
for part in PARTS:
    bodies = part.GetChildren(DataModelObjectCategory.Body, False)
    for body in bodies:
        if body.Name == "Part 1":
            PART1 = body

STAT_STRUC = DataModel.Project.Model.Analyses[0]
ANALYSIS_SETTINGS = STAT_STRUC.AnalysisSettings
STAT_STRUC_SOLUTION = STAT_STRUC.Solution

#Scenario 2: Set Display Unit System
ExtAPI.Application.ActiveUnitSystem = MechanicalUnitSystem.StandardMKS

#Scenario 3: Set isometric view and zoom to fit
cam = Graphics.Camera
cam.SetSpecificViewOrientation(ViewOrientationType.Iso)
cam.SetFit()

#Scenario 4: Store Named Selections for applying load and boundary condition in structural analysis


NS_FACE1 = NAMED_SELECTIONS.Children[0]

#Scenario 5: Store Coordinate System for applying spatially varying load
COORDINATE_SYSTEM = COORDINATE_SYSTEMS.Children[0]

#Scenario 6: Define global mesh size and generate mesh
MESH.Activate()
MESH.ElementSize = Quantity('0.1 [m]')
MESH.GenerateMesh()

#Scenario 7: Define load and boundary conditions in Static Structural analysis
# Add Fixed Support
FIXED_SUPPORT = STAT_STRUC.AddFixedSupport()
FIXED_SUPPORT.Location = NS_FACE1

# Add force
FORCE = STAT_STRUC.AddForce()
FORCE.Location = NS_FACE1
FORCE.Magnitude.Output.Formula = "8.89644"
# FORCE.XYZFunctionCoordinateSystem =  COORDINATE_SYSTEM

#Scenario 8: Add results in Static Structural analysis
STAT_STRUC_SOLUTION.Activate()
TOTAL_DEFORMATION = STAT_STRUC_SOLUTION.AddTotalDeformation()
DIRECTIONAL_DEFORMATION = STAT_STRUC_SOLUTION.AddDirectionalDeformation()
DIRECTIONAL_DEFORMATION.NormalOrientation = NormalOrientationType.YAxis
DIRECTIONAL_DEFORMATION.CoordinateSystem = COORDINATE_SYSTEM

#Scenario 9: Solve and review Results
STAT_STRUC_SOLUTION.Activate()
STAT_STRUC.Solve(True)
# ... (your existing code up to this point)

# Export results to a text file
EXPORT_PATH = r'M:\dev\Ansys\Digital Twin\dataResults.txt'  # Replace this with your desired export path

# Export Total Deformation results
TOTAL_DEF_MIN = TOTAL_DEFORMATION.Minimum.Value
TOTAL_DEF_MAX = TOTAL_DEFORMATION.Maximum.Value

# Export Directional Deformation results
DIRECTIONAL_DEF_MIN = DIRECTIONAL_DEFORMATION.Minimum.Value
DIRECTIONAL_DEF_MAX =.Maximum.Value

FORCE_REACTION_PROBE_Y = FORCE_REACTION_PROBE.YAxis.Value
MOMENT_REACTION_PROBE_X = MOMENT_REACTION_PROBE.XAxis.Value
MOMENT_REACTION_PROBE_TOTAL = MOMENT_REACTION_PROBE.Total.Value

# Write results to a text file
with open(EXPORT_PATH, 'w') as file:

    file.write(f'Directional Deformation (Min): {DIRECTIONAL_DEF_MIN}\n')
    file.write(f'Directional Deformation (Max): {DIRECTIONAL_DEF_MAX}\n')


# End of script
# TOTAL_DEFORMATION_RESULT.ExportToTextFile(FOLDER_PATH+'\\Txt1.txt')

#DIRECTIONAL_DEFORMATION.ExportToTextFile('M:\dev\Ansys\Digital Twin\data\dataResults.txt')
STAT_STRUC = DataModel.Project.Model.Analyses[0]
ANALYSIS_SETTINGS = STAT_STRUC.AnalysisSettings
STAT_STRUC_SOLUTION = STAT_STRUC.Solution

#DataModel.Project.Model.Analyses[0].Solution.AddTotalDeformation.ExportToTextFile('M:\dev\Ansys\Digital Twin\data\dataResults.txt')