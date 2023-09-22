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