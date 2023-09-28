#Scenario 1: Store main Tree Object items
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
tot_child_NS_GRP = NAMED_SELECTIONS.Children.Count
for i in range(0, tot_child_NS_GRP, 1):
	ns = NAMED_SELECTIONS.Children[i].Name
	if(ns=='NS_FACE1'):
		NS_FACE1 = NAMED_SELECTIONS.Children[i]
	if(ns=='NS_FACE2'):
		NS_FACE2 = NAMED_SELECTIONS.Children[i]
	if(ns=='NS_FACE3'):
		NS_FACE3 = NAMED_SELECTIONS.Children[i]

#Scenario 5: Store Coordinate System for applying spatially varying load
COORDINATE_SYSTEM = COORDINATE_SYSTEMS.Children[1]

#Scenario 6: Define global mesh size and generate mesh
MESH.Activate()
MESH.ElementSize = Quantity('0.001 [m]')
MESH.GenerateMesh()

#Scenario 7: Define load and boundary conditions in Static Structural analysis
# Add Fixed Support
FIXED_SUPPORT = STAT_STRUC.AddFixedSupport()
FIXED_SUPPORT.Location = NS_FACE1

# Add spatially varying Pressure based on Z coordinate of local coordinate system
PRESSURE = STAT_STRUC.AddPressure()
PRESSURE.Location = NS_FACE3
PRESSURE.Magnitude.Output.Formula = "1e9*z"
PRESSURE.XYZFunctionCoordinateSystem =  COORDINATE_SYSTEM

#Scenario 8: Add results in Static Structural analysis
STAT_STRUC_SOLUTION.Activate()
TOTAL_DEFORMATION = STAT_STRUC_SOLUTION.AddTotalDeformation()
DIRECTIONAL_DEFORMATION = STAT_STRUC_SOLUTION.AddDirectionalDeformation()
DIRECTIONAL_DEFORMATION.NormalOrientation = NormalOrientationType.YAxis
DIRECTIONAL_DEFORMATION.CoordinateSystem = COORDINATE_SYSTEM

FORCE_REACTION_PROBE = STAT_STRUC_SOLUTION.AddForceReaction()
FORCE_REACTION_PROBE.BoundaryConditionSelection = FIXED_SUPPORT
FORCE_REACTION_PROBE.Orientation = COORDINATE_SYSTEM

MOMENT_REACTION_PROBE = STAT_STRUC_SOLUTION.AddMomentReaction()
MOMENT_REACTION_PROBE.BoundaryConditionSelection = FIXED_SUPPORT
MOMENT_REACTION_PROBE.Orientation = COORDINATE_SYSTEM

#Scenario 9: Solve and review Results
STAT_STRUC_SOLUTION.Activate()
STAT_STRUC.Solve(True)

#Total Deformation Result
TOTAL_DEF_MIN = TOTAL_DEFORMATION.Minimum.Value
TOTAL_DEF_MAX = TOTAL_DEFORMATION.Maximum.Value

#Directional Deformation Result
DIRECTIONAL_DEF_MIN = DIRECTIONAL_DEFORMATION.Minimum.Value
DIRECTIONAL_DEF_MAX = DIRECTIONAL_DEFORMATION.Maximum.Value

FORCE_REACTION_PROBE_Y=FORCE_REACTION_PROBE.YAxis.Value
MOMENT_REACTION_PROBE_X=MOMENT_REACTION_PROBE.XAxis.Value
MOMENT_REACTION_PROBE_TOTAL=MOMENT_REACTION_PROBE.Total.Value