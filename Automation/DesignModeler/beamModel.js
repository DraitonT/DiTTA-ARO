// -------------Java Script Script Information-------------
// Author Names: Michael Quach
// Team: DiTTA (ARO)
// Date: 09/15/23
// Tool Version: N/A
// Purpose of Script: Automatically creates and dimensions damaged beam within Ansys DesignModeler
// other .js files required: None
// other files required (not .js): None

function planeSketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk1 = p.Plane.NewSketch();
p.Sk1.Name = "Sketch1";

//Edges
with (p.Sk1)
{
  p.Ln7 = Line(0.00000000, 0.00000000, 24.00000000, 0.00000000);
  p.Ln8 = Line(24.00000000, 0.00000000, 24.00000000, 6.00000000);
  p.Ln9 = Line(24.00000000, 6.00000000, 0.00000000, 6.00000000);
  p.Ln10 = Line(0.00000000, 6.00000000, 0.00000000, 0.00000000);
}


//Sketch
p.Sk2 = p.Plane.NewSketch();
p.Sk2.Name = "Sketch2";

//Edges
with (p.Sk2)
{
  p.Ln11 = Line(2.00000000, 6.00000000, 2.16667000, 6.00000000);
  p.Ln12 = Line(2.16667000, 6.00000000, 2.16667000, 4.08279849);
  p.Ln13 = Line(2.16667000, 4.08279849, 2.00000000, 4.08279849);
  p.Ln14 = Line(2.00000000, 4.08279849, 2.00000000, 6.00000000);
  p.Ln19 = Line(2.16667000, 0.00000000, 2.00000000, -0.00000000);
  p.Ln20 = Line(2.00000000, -0.00000000, 2.00000000, 2.31521996);
  p.Ln21 = Line(2.00000000, 2.31521996, 2.16667000, 2.31521996);
  p.Ln22 = Line(2.16667000, 2.31521996, 2.16667000, 0.00000000);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Dimensions
  var dim;
  dim = HorizontalDim(p.Ln9.Base, 24.00000000, 6.00000000, 
    p.Ln9.End, 0.00000000, 6.00000000, 
    4.70758654, 83.26023516);
  if(dim) dim.Name = "H1";
  dim = HorizontalDim(p.Ln11.Base, 2.00000000, 6.00000000, 
    p.Ln11.End, 2.16667000, 6.00000000, 
    2.05576476, 6.89800095);
  if(dim) dim.Name = "H3";
  dim = HorizontalDim(p.Ln19.Base, 2.16667000, 0.00000000, 
    p.Ln19.End, 2.00000000, -0.00000000, 
    2.12803561, -0.28549805);
  if(dim) dim.Name = "H4";
  dim = HorizontalDim(p.Ln14.End, 2.00000000, 6.00000000, 
    p.Ln10.Base, 0.00000000, 6.00000000, 
    1.04569334, 6.89800095);
  if(dim) dim.Name = "H5";
  dim = HorizontalDim(p.Ln20.Base, 2.00000000, -0.00000000, 
    p.Ln10.End, 0.00000000, 0.00000000, 
    1.62259566, -0.83618687);
  if(dim) dim.Name = "H7";
  dim = VerticalDim(p.Ln8.Base, 24.00000000, 0.00000000, 
    p.Ln8.End, 24.00000000, 6.00000000, 
    145.71321292, 4.29900158);
  if(dim) dim.Name = "V2";

  //Constraints
  HorizontalCon(p.Ln7);
  HorizontalCon(p.Ln9);
  HorizontalCon(p.Ln11);
  HorizontalCon(p.Ln13);
  HorizontalCon(p.Ln19);
  HorizontalCon(p.Ln21);
  VerticalCon(p.Ln8);
  VerticalCon(p.Ln10);
  VerticalCon(p.Ln12);
  VerticalCon(p.Ln14);
  VerticalCon(p.Ln20);
  VerticalCon(p.Ln22);
  CoincidentCon(p.Ln7.End, 24.00000000, 0.00000000, 
                p.Ln8.Base, 24.00000000, 0.00000000);
  CoincidentCon(p.Ln8.End, 24.00000000, 6.00000000, 
                p.Ln9.Base, 24.00000000, 6.00000000);
  CoincidentCon(p.Ln9.End, 0.00000000, 6.00000000, 
                p.Ln10.Base, 0.00000000, 6.00000000);
  CoincidentCon(p.Ln10.End, 0.00000000, 0.00000000, 
                p.Ln7.Base, 0.00000000, 0.00000000);
  CoincidentCon(p.Ln7.Base, 0.00000000, 0.00000000, 
                p.Origin, 0.00000000, 0.00000000);
  CoincidentCon(p.Ln11.End, 2.16667000, 6.00000000, 
                p.Ln12.Base, 2.16667000, 6.00000000);
  CoincidentCon(p.Ln12.End, 2.16667000, 4.08279849, 
                p.Ln13.Base, 2.16667000, 4.08279849);
  CoincidentCon(p.Ln13.End, 2.00000000, 4.08279849, 
                p.Ln14.Base, 2.00000000, 4.08279849);
  CoincidentCon(p.Ln14.End, 2.00000000, 6.00000000, 
                p.Ln11.Base, 2.00000000, 6.00000000);
  CoincidentCon(p.Ln11.Base, 2.00000000, 6.00000000, 
                p.Ln9, 2.16507771, 6.00000000);
  CoincidentCon(p.Ln19.End, 2.00000000, -0.00000000, 
                p.Ln20.Base, 2.00000000, -0.00000000);
  CoincidentCon(p.Ln20.End, 2.00000000, 2.31521996, 
                p.Ln21.Base, 2.00000000, 2.31521996);
  CoincidentCon(p.Ln21.End, 2.16667000, 2.31521996, 
                p.Ln22.Base, 2.16667000, 2.31521996);
  CoincidentCon(p.Ln22.End, 2.16667000, 0.00000000, 
                p.Ln19.Base, 2.16667000, 0.00000000);
  CoincidentCon(p.Ln21.Base, 2.00000000, 2.31521996, 
                p.Ln14, 2.16507771, 2.31521996);
  CoincidentCon(p.Ln19, 0.00000000, 0.00000000, 
                p.XAxis, 0.00000000, 0.00000000);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: planeSketchesOnly

// ... (the existing script up to this point)

///Call Plane JScript function
var ps1 = planeSketchesOnly(new Object());

agb.Regen(); // To ensure model validity

var Extrude1 = agb.Extrude(agc.Add, ps1.Sk1, agc.DirNormal,
  agc.ExtentFixed, 0.0254, agc.ExtentFixed, 0.0254, agc.No, 0.0, 0.0);

  agb.Regen(); // To ensure model validity

var Extrude1 = agb.Extrude(agc.Cut, ps1.Sk2, agc.DirNormal,
  agc.ExtentFixed, 0.0254, agc.ExtentFixed, 0.0254, agc.No, 0.0, 0.0);
  ps1.Sk1.Name = "Face1";
  agb.Regen(); // To ensure model validity

  // ... (your existing script up to this point)

// Create a Named Selection for a face
// var namedSelection = agb.NamedSelections.Create("MyNamedSelection");

// // Get the face you want to include in the Named Selection (replace "Face1" with the actual face name)
// var faceToSelect = agb.GetFaceByName("Face1");

// // Add the face to the Named Selection
// namedSelection.Add(faceToSelect);

// // To finalize the Named Selection creation
// namedSelection.Commit();
// ps1.Name = "Face1";

// // Regenerate the model to update the Named Selection
// agb.Regen();

// ... (your existing script up to this point)

// // Create a Named Selection for a face
// var namedSelection = agb.NamedSelections.Create("MyNamedSelection");

// // Get the face you want to include in the Named Selection (replace "Face1" with the actual face name)
// var faceToSelect = agb.GetFaceByName("Face1");

// // Add the face to the Named Selection
// namedSelection.Add(faceToSelect);

// // To finalize the Named Selection creation
// namedSelection.Commit();

// // Regenerate the model to update the Named Selection
// agb.Regen();

// End DM JScript