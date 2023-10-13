//DesignModeler JScript, version: Ansys DesignModeler 2023 R2 (May 30 2023, 14:02:08; 23,2023,149,1) SV4
//Created via: "Write Script: Sketch(es) of Active Plane"
// Written to: M:\dev\Ansys\Digital Twin\Automation\DesignModeler\beamModel2.js
//         On: 10/12/23, 09:17:29
//Using:
//  agb ... pointer to batch interface


//Note:
// You may be able to re-use below JScript function via cut-and-paste;
// however, you may have to re-name the function identifier.
//

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
p.Sk3 = p.Plane.NewSketch();
p.Sk3.Name = "Sketch3";

//Edges
with (p.Sk3)
{
  p.Ln23 = Line(5.00000000, 6.00000000, 5.16666700, 6.00000000);
  p.Ln24 = Line(5.16666700, 6.00000000, 5.16666700, 4.00000000);
  p.Ln25 = Line(5.16666700, 4.00000000, 5.00000000, 4.00000000);
  p.Ln26 = Line(5.00000000, 4.00000000, 5.00000000, 6.00000000);
  p.Ln27 = Line(5.00000000, -0.00000000, 5.16666700, 0.00000000);
  p.Ln28 = Line(5.16666700, 0.00000000, 5.16666700, 2.00000000);
  p.Ln29 = Line(5.16666700, 2.00000000, 5.00000000, 2.00000000);
  p.Ln30 = Line(5.00000000, 2.00000000, 5.00000000, -0.00000000);
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
  dim = HorizontalDim(p.Ln30.End, 5.00000000, -0.00000000, 
    p.Ln28.Base, 5.16666700, 0.00000000, 
    5.09936755, -0.47680452);
  if(dim) dim.Name = "H11";
  dim = HorizontalDim(p.Ln26.End, 5.00000000, 6.00000000, 
    p.Ln24.Base, 5.16666700, 6.00000000, 
    5.29764056, 6.48555129);
  if(dim) dim.Name = "H12";
  dim = VerticalDim(p.Ln8.Base, 24.00000000, 0.00000000, 
    p.Ln8.End, 24.00000000, 6.00000000, 
    145.71321292, 4.29900158);
  if(dim) dim.Name = "V2";
  dim = VerticalDim(p.Ln24.Base, 5.16666700, 6.00000000, 
    p.Ln25.Base, 5.16666700, 4.00000000, 
    6.22988741, 4.21529452);
  if(dim) dim.Name = "V13";
  dim = VerticalDim(p.Ln29.Base, 5.16666700, 2.00000000, 
    p.Ln28.Base, 5.16666700, 0.00000000, 
    6.39944268, 1.21952469);
  if(dim) dim.Name = "V14";
  dim = DistanceDim(p.Ln10, 0.00000000, 5.65961644, 
    p.Ln26, 1.37788574, 5.65961625, 
    2.76945191, 6.48555129);
  if(dim) dim.Name = "L8";
  dim = DistanceDim(p.Ln30, 1.57972387, 0.85631453, 
    p.Ln10, 0.00000000, 0.89258666, 
    1.45745244, -1.88689039);
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
  CoincidentCon(p.Ln23.End, 5.16666700, 6.00000000, 
                p.Ln24.Base, 5.16666700, 6.00000000);
  CoincidentCon(p.Ln24.End, 5.16666700, 4.00000000, 
                p.Ln25.Base, 5.16666700, 4.00000000);
  CoincidentCon(p.Ln25.End, 5.00000000, 4.00000000, 
                p.Ln26.Base, 5.00000000, 4.00000000);
  CoincidentCon(p.Ln26.End, 5.00000000, 6.00000000, 
                p.Ln23.Base, 5.00000000, 6.00000000);
  CoincidentCon(p.Ln23.Base, 5.00000000, 6.00000000, 
                p.Ln9, 1.37788574, 6.00000000);
  CoincidentCon(p.Ln27.End, 5.16666700, 0.00000000, 
                p.Ln28.Base, 5.16666700, 0.00000000);
  CoincidentCon(p.Ln28.End, 5.16666700, 2.00000000, 
                p.Ln29.Base, 5.16666700, 2.00000000);
  CoincidentCon(p.Ln29.End, 5.00000000, 2.00000000, 
                p.Ln30.Base, 5.00000000, 2.00000000);
  CoincidentCon(p.Ln30.End, 5.00000000, -0.00000000, 
                p.Ln27.Base, 5.00000000, -0.00000000);
  CoincidentCon(p.Ln27.Base, 5.00000000, -0.00000000, 
                p.XAxis, 1.57972387, 0.00000000);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: planeSketchesOnly

//Call Plane JScript function
var ps1 = planeSketchesOnly (new Object());

//Finish
agb.Regen(); //To insure model validity

var Extrude1 = agb.Extrude(agc.Add, ps1.Sk1, agc.DirNormal,
  agc.ExtentFixed, 0.1, agc.ExtentFixed, 0.1, agc.No, 0.0, 0.0);

  agb.Regen(); // To ensure model validity

var Extrude1 = agb.Extrude(agc.Cut, ps1.Sk3, agc.DirNormal,
  agc.ExtentFixed, 0.1, agc.ExtentFixed, 0.1, agc.No, 0.0, 0.0);
  ps1.Sk1.Name = "Face1";
  agb.Regen(); // To ensure model validity
//End DM JScript
