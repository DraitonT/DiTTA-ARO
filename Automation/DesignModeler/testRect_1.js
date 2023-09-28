//DesignModeler JScript, version: Ansys DesignModeler 2023 R2 (May 30 2023, 14:02:08; 23,2023,149,1) SV4
//Created via: "Write Script: Sketch(es) of Active Plane"
// Written to: M:\dev\Ansys\Digital Twin\testRect_1.js
//         On: 09/22/23, 09:14:31
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
p.Sk2 = p.Plane.NewSketch();
p.Sk2.Name = "Sketch2";

//Edges
with (p.Sk2)
{
  p.Ln11 = Line(2.00000000, 6.00000000, 2.16667000, 6.00000000);
  p.Ln12 = Line(2.16667000, 6.00000000, 2.16667000, 4.08279849);
  p.Ln13 = Line(2.16667000, 4.08279849, 2.00000000, 4.08279849);
  p.Ln14 = Line(2.00000000, 4.08279849, 2.00000000, 6.00000000);
  p.Ln15 = Line(2.16667000, 0.00000000, 2.00000000, -0.00000000);
  p.Ln16 = Line(2.00000000, -0.00000000, 2.00000000, 2.31521996);
  p.Ln17 = Line(2.00000000, 2.31521996, 2.16667000, 2.31521996);
  p.Ln18 = Line(2.16667000, 2.31521996, 2.16667000, 0.00000000);
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
  dim = HorizontalDim(p.Ln15.Base, 2.16667000, 0.00000000, 
    p.Ln15.End, 2.00000000, -0.00000000, 
    2.12803561, -0.28549805);
  if(dim) dim.Name = "H4";
  dim = HorizontalDim(p.Ln14.End, 2.00000000, 6.00000000, 
    p.Ln10.Base, 0.00000000, 6.00000000, 
    1.04569334, 6.89800095);
  if(dim) dim.Name = "H5";
  dim = HorizontalDim(p.Ln16.Base, 2.00000000, -0.00000000, 
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
  HorizontalCon(p.Ln15);
  HorizontalCon(p.Ln17);
  VerticalCon(p.Ln8);
  VerticalCon(p.Ln10);
  VerticalCon(p.Ln12);
  VerticalCon(p.Ln14);
  VerticalCon(p.Ln16);
  VerticalCon(p.Ln18);
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
  CoincidentCon(p.Ln15.End, 2.00000000, -0.00000000, 
                p.Ln16.Base, 2.00000000, -0.00000000);
  CoincidentCon(p.Ln16.End, 2.00000000, 2.31521996, 
                p.Ln17.Base, 2.00000000, 2.31521996);
  CoincidentCon(p.Ln17.End, 2.16667000, 2.31521996, 
                p.Ln18.Base, 2.16667000, 2.31521996);
  CoincidentCon(p.Ln18.End, 2.16667000, 0.00000000, 
                p.Ln15.Base, 2.16667000, 0.00000000);
  CoincidentCon(p.Ln17.Base, 2.00000000, 2.31521996, 
                p.Ln14, 2.16507771, 2.31521996);
  CoincidentCon(p.Ln15, 0.00000000, 0.00000000, 
                p.XAxis, 0.00000000, 0.00000000);
}

p.Plane.EvalDimCons(); //Final evaluate of all dimensions and constraints in plane

return p;
} //End Plane JScript function: planeSketchesOnly

//Call Plane JScript function
var ps1 = planeSketchesOnly (new Object());

//Finish
agb.Regen(); //To insure model validity
//End DM JScript
