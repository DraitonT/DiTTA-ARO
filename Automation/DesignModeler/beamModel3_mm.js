// -------------Java Script Script Information-------------
// Author Names: Michael Quach
// Team: DiTTA (ARO)
// Date: 10/12/23
// Tool Version: N/A
// Purpose of Script: Automatically creates and dimensions damaged beam within Ansys DesignModeler (in meters)
// other .js files required: None
// other files required (not .js): None
////////////////////////////// EDITABLE /////////////////////////////

////////////////////////////// EDITABLE /////////////////////////////

//////////////////////////// NON-EDITABLE ///////////////////////////

// 0.0 Function to create the sketches on desired planes
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
  p.Ln7 = Line(0.00000000, 0.00000000, 0.60960000, 0.00000000);
  p.Ln8 = Line(0.60960000, 0.00000000, 0.60960000, 0.15240000);
  p.Ln9 = Line(0.60960000, 0.15240000, 0.00000000, 0.15240000);
  p.Ln10 = Line(0.00000000, 0.15240000, 0.00000000, 0.00000000);
}


//Sketch
p.Sk3 = p.Plane.NewSketch();
p.Sk3.Name = "Sketch3";

//Edges
with (p.Sk3)
{
  p.Ln23 = Line(0.12700000, 0.15240000, 0.13123334, 0.15240000);
  p.Ln24 = Line(0.13123334, 0.15240000, 0.13123334, 0.10160000);
  p.Ln25 = Line(0.13123334, 0.10160000, 0.12700000, 0.10160000);
  p.Ln26 = Line(0.12700000, 0.10160000, 0.12700000, 0.15240000);
  p.Ln27 = Line(0.12700000, -0.00000000, 0.13123334, 0.00000000);
  p.Ln28 = Line(0.13123334, 0.00000000, 0.13123334, 0.05080000);
  p.Ln29 = Line(0.13123334, 0.05080000, 0.12700000, 0.05080000);
  p.Ln30 = Line(0.12700000, 0.05080000, 0.12700000, -0.00000000);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Dimensions
  var dim;
  dim = HorizontalDim(p.Ln9.Base, 0.60960000, 0.15240000, 
    p.Ln9.End, 0.00000000, 0.15240000, 
    0.11957270, 2.11480997);
  if(dim) dim.Name = "H1";
  dim = HorizontalDim(p.Ln30.End, 0.12700000, -0.00000000, 
    p.Ln28.Base, 0.13123334, 0.00000000, 
    0.12952394, -0.01211083);
  if(dim) dim.Name = "H11";
  dim = HorizontalDim(p.Ln26.End, 0.12700000, 0.15240000, 
    p.Ln24.Base, 0.13123334, 0.15240000, 
    0.13456007, 0.16473300);
  if(dim) dim.Name = "H12";
  dim = VerticalDim(p.Ln8.Base, 0.60960000, 0.00000000, 
    p.Ln8.End, 0.60960000, 0.15240000, 
    3.70111561, 0.10919464);
  if(dim) dim.Name = "V2";
  dim = VerticalDim(p.Ln24.Base, 0.13123334, 0.15240000, 
    p.Ln25.Base, 0.13123334, 0.10160000, 
    0.15823914, 0.10706848);
  if(dim) dim.Name = "V13";
  dim = VerticalDim(p.Ln29.Base, 0.13123334, 0.05080000, 
    p.Ln28.Base, 0.13123334, 0.00000000, 
    0.16254584, 0.03097593);
  if(dim) dim.Name = "V14";
  dim = DistanceDim(p.Ln10, 0.00000000, 0.14375426, 
    p.Ln26, 0.03499830, 0.14375425, 
    0.07034408, 0.16473300);
  if(dim) dim.Name = "L8";
  dim = DistanceDim(p.Ln30, 0.04012499, 0.02175039, 
    p.Ln10, 0.00000000, 0.02267170, 
    0.03701929, -0.04792702);
  if(dim) dim.Name = "L10";

  //Constraints
  HorizontalCon(p.Ln7);
  HorizontalCon(p.Ln9);
  HorizontalCon(p.Ln23);
  HorizontalCon(p.Ln25);
  HorizontalCon(p.Ln27);
  HorizontalCon(p.Ln29);
  VerticalCon(p.Ln8);
  VerticalCon(p.Ln10);
  VerticalCon(p.Ln24);
  VerticalCon(p.Ln26);
  VerticalCon(p.Ln28);
  VerticalCon(p.Ln30);
  CoincidentCon(p.Ln7.End, 0.60960000, 0.00000000, 
                p.Ln8.Base, 0.60960000, 0.00000000);
  CoincidentCon(p.Ln8.End, 0.60960000, 0.15240000, 
                p.Ln9.Base, 0.60960000, 0.15240000);
  CoincidentCon(p.Ln9.End, 0.00000000, 0.15240000, 
                p.Ln10.Base, 0.00000000, 0.15240000);
  CoincidentCon(p.Ln10.End, 0.00000000, 0.00000000, 
                p.Ln7.Base, 0.00000000, 0.00000000);
  CoincidentCon(p.Ln7.Base, 0.00000000, 0.00000000, 
                p.Origin, 0.00000000, 0.00000000);
  CoincidentCon(p.Ln23.End, 0.13123334, 0.15240000, 
                p.Ln24.Base, 0.13123334, 0.15240000);
  CoincidentCon(p.Ln24.End, 0.13123334, 0.10160000, 
                p.Ln25.Base, 0.13123334, 0.10160000);
  CoincidentCon(p.Ln25.End, 0.12700000, 0.10160000, 
                p.Ln26.Base, 0.12700000, 0.10160000);
  CoincidentCon(p.Ln26.End, 0.12700000, 0.15240000, 
                p.Ln23.Base, 0.12700000, 0.15240000);
  CoincidentCon(p.Ln23.Base, 0.12700000, 0.15240000, 
                p.Ln9, 0.03499830, 0.15240000);
  CoincidentCon(p.Ln27.End, 0.13123334, 0.00000000, 
                p.Ln28.Base, 0.13123334, 0.00000000);
  CoincidentCon(p.Ln28.End, 0.13123334, 0.05080000, 
                p.Ln29.Base, 0.13123334, 0.05080000);
  CoincidentCon(p.Ln29.End, 0.12700000, 0.05080000, 
                p.Ln30.Base, 0.12700000, 0.05080000);
  CoincidentCon(p.Ln30.End, 0.12700000, -0.00000000, 
                p.Ln27.Base, 0.12700000, -0.00000000);
  CoincidentCon(p.Ln27.Base, 0.12700000, -0.00000000, 
                p.XAxis, 0.04012499, 0.00000000);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: planeSketchesOnly

//Call Plane JScript function
var ps1 = planeSketchesOnly (new Object());

//Finish
agb.Regen(); //To insure model validity

// 1.0 Extrudes the sketches out to create 3D model and damaged cuts
var Extrude1 = agb.Extrude(agc.Add, ps1.Sk1, agc.DirNormal,
  agc.ExtentFixed, 0.00254, agc.ExtentFixed, 0.00254, agc.No, 0.0, 0.0);

  agb.Regen(); // To ensure model validity

var Extrude1 = agb.Extrude(agc.Cut, ps1.Sk3, agc.DirNormal,
  agc.ExtentFixed, 0.00254, agc.ExtentFixed, 0.00254, agc.No, 0.0, 0.0);
  ps1.Sk1.Name = "Face1";
  agb.Regen(); // To ensure model validity
//End DM JScript

//////////////////////////// NON-EDITABLE ///////////////////////////
