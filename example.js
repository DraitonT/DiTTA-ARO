//DesignModeler FeatueExample JScript
//***************************************************************************
//All sketches were created interactively, then sketches for each plane
//were written out with the "Write Sketch" command in the file menu.
//These individual sketch scripts were then combined into a single file
//with slight name changes. The various plane and feature commands were
//added to create the final result. Most of the actual creation logic is
//near the end of the example.
//***************************************************************************

function plane1SketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk1 = p.Plane.newSketch();
p.Sk1.Name = "Sketch1";

//Edges
with (p.Sk1)
{
  p.Pt31 = ConstructionPoint(0, 0);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Constraints
  CoincidentCon(p.Pt31, 0, 0, 
                p.Origin, 0, 0);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: plane1SketchesOnly

function plane2SketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk2 = p.Plane.newSketch();
p.Sk2.Name = "Sketch2";

//Edges
with (p.Sk2)
{
  p.Ln13 = Line(-10, -10, 10, -10);
  p.Ln14 = Line(10, -10, 10, 10);
  p.Ln15 = Line(10, 10, -10, 10);
  p.Ln16 = Line(-10, 10, -10, -10);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Constraints
  HorizontalCon(p.Ln13);
  HorizontalCon(p.Ln15);
  VerticalCon(p.Ln14);
  VerticalCon(p.Ln16);
  CoincidentCon(p.Ln13.End, 10, -10, 
                p.Ln14.Base, 10, -10);
  CoincidentCon(p.Ln14.End, 10, 10, 
                p.Ln15.Base, 10, 10);
  CoincidentCon(p.Ln15.End, -10, 10, 
                p.Ln16.Base, -10, 10);
  CoincidentCon(p.Ln16.End, -10, -10, 
                p.Ln13.Base, -10, -10);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: plane2SketchesOnly

function plane3SketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk3 = p.Plane.newSketch();
p.Sk3.Name = "Sketch3";

//Edges
with (p.Sk3)
{
  p.Ln17 = Line(-20, -10, 20, -10);
  p.Ln18 = Line(20, -10, 20, 10);
  p.Ln19 = Line(20, 10, -20, 10);
  p.Ln20 = Line(-20, 10, -20, -10);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Constraints
  HorizontalCon(p.Ln17);
  HorizontalCon(p.Ln19);
  VerticalCon(p.Ln18);
  VerticalCon(p.Ln20);
  CoincidentCon(p.Ln17.End, 20, -10, 
                p.Ln18.Base, 20, -10);
  CoincidentCon(p.Ln18.End, 20, 10, 
                p.Ln19.Base, 20, 10);
  CoincidentCon(p.Ln19.End, -20, 10, 
                p.Ln20.Base, -20, 10);
  CoincidentCon(p.Ln20.End, -20, -10, 
                p.Ln17.Base, -20, -10);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: plane3SketchesOnly

function plane4SketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk4 = p.Plane.newSketch();
p.Sk4.Name = "Sketch4";

//Edges
with (p.Sk4)
{
  p.Ln21 = Line(-20, -10, 20, -10);
  p.Cr22 = ArcCtrEdge(
              20, 0,
              20, -10,
              20, 10);
  p.Ln23 = Line(20, 10, -20, 10);
  p.Cr24 = ArcCtrEdge(
              -20, 0,
              -20, 10,
              -20, -10);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Constraints
  HorizontalCon(p.Ln21);
  HorizontalCon(p.Ln23);
  TangentCon(p.Cr22, 20, -10, 
                p.Ln21, 20, -10);
  TangentCon(p.Cr22, 20, 10, 
                p.Ln23, 20, 10);
  TangentCon(p.Cr24, -20, 10, 
                p.Ln23, -20, 10);
  TangentCon(p.Cr24, -20, -10, 
                p.Ln21, -20, -10);
  CoincidentCon(p.Ln21.End, 20, -10, 
                p.Cr22.Base, 20, -10);
  CoincidentCon(p.Cr22.End, 20, 10, 
                p.Ln23.Base, 20, 10);
  CoincidentCon(p.Ln23.End, -20, 10, 
                p.Cr24.Base, -20, 10);
  CoincidentCon(p.Cr24.End, -20, -10, 
                p.Ln21.Base, -20, -10);
  CoincidentCon(p.Cr24.Center, -20, 0, 
                p.XAxis, -20, 0);
  CoincidentCon(p.Cr22.Center, 20, 0, 
                p.XAxis, 20, 0);
  EqualRadiusCon(p.Cr22, p.Cr24);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: plane4SketchesOnly

function planeYZSketchesOnly (p)
{

//Plane
p.Plane  = agb.GetActivePlane();
p.Origin = p.Plane.GetOrigin();
p.XAxis  = p.Plane.GetXAxis();
p.YAxis  = p.Plane.GetYAxis();

//Sketch
p.Sk5 = p.Plane.newSketch();
p.Sk5.Name = "Sketch5";

//Edges
with (p.Sk5)
{
  p.Cr25 = Circle(0, 50, 7.5);
}


//Sketch
p.Sk6 = p.Plane.newSketch();
p.Sk6.Name = "Sketch6";

//Edges
with (p.Sk6)
{
  p.Cr26 = ArcCtrEdge(
              30, 60,
              30, 90,
              0, 60);
}


//Sketch
p.Sk7 = p.Plane.newSketch();
p.Sk7.Name = "Sketch7";

//Edges
with (p.Sk7)
{
  p.Cr27 = Circle(20, 40, 7.5);
}

//Dimensions and/or constraints
with (p.Plane)
{
  //Constraints
  TangentCon(p.Cr26, 0, 60, 
                p.YAxis, 0, 60);
  CoincidentCon(p.Cr25.Center, 0, 50, 
                p.YAxis, 0, 50);
  CoincidentCon(p.Cr26.End, 0, 60, 
                p.YAxis, 0, 60);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: planeYZSketchesOnly


//***************************************************************************
//End of function definitions for sketches
//Now, lets access/create planes and actually create the sketches
//and then the features that use them
//***************************************************************************


//Call Plane JScript functions
var XYPlane = agb.GetXYPlane();
agb.SetActivePlane (XYPlane);
var ps1 = plane1SketchesOnly (new Object());

var plane2 = agb.PlaneFromPlane(XYPlane);
plane2.AddTransform(agc.XformZOffset, 20);
agb.regen();
agb.SetActivePlane (plane2);
var ps2 = plane2SketchesOnly (new Object());

var plane3 = agb.PlaneFromPlane(plane2);
plane3.AddTransform(agc.XformZOffset, 20);
agb.regen();
agb.SetActivePlane (plane3);
var ps3 = plane3SketchesOnly (new Object());

var plane4 = agb.PlaneFromPlane(plane3);
plane4.AddTransform(agc.XformZOffset, 20);
agb.regen();
agb.SetActivePlane (plane4);
var ps4 = plane4SketchesOnly (new Object());

var YZPlane = agb.GetYZPlane();
agb.SetActivePlane (YZPlane );
var ps5 = planeYZSketchesOnly (new Object());

//Now, create Skin
var Skin1 = agb.Skin(agc.Add, agc.No, 0.0, 0.0);
Skin1.Name = "Point2OvalSkin"
Skin1.AddBaseObject(ps1.Sk1);
Skin1.AddBaseObject(ps2.Sk2);
Skin1.AddBaseObject(ps3.Sk3);
Skin1.AddBaseObject(ps4.Sk4);
agb.Regen(); //To insure model validity

//Next create a Sweep
var Sweep1 = agb.Sweep(agc.Add, ps4.Sk4, ps5.Sk6, agc.AlignTangent,
0.25, 0.0, agc.No, 0.0, 0.0);
agb.Regen(); //To insure model validity

//Next create a Revolve
var Rev1 = agb.Revolve(agc.Add, ps5.Sk7, ps5.YAxis, agc.DirNormal,
360.0, 0.0, agc.Yes, 1.0, 1.0);
agb.Regen(); //To insure model validity

//Finally cut a hole using Extrude
var Extrude1 = agb.Extrude(agc.Cut, ps5.Sk5, agc.DirSymmetric,
agc.ExtentThruAll, 0.0, agc.ExtentFixed, 0.0, agc.No, 0.0, 0.0);
agb.Regen(); //To insure model validity

//Result is an ugly widget, but a useful example!

//End DM JScript