/**
 * 
 * CNC Router Y Carriage
 * 
 * Designed by Diego Viejo
 * Created on 20/Jan/2015
 * Last modified 17/Feb/2015
 * 
 */

//ball bearing bolt measurements
outerRad = 48 / 2;
holeRad = 38 / 2;
mainBodyRad = 28 / 2;

mainBodyLength = 45;

plateHeight = 8;
mainBodyHeigh = 1.7 + mainBodyRad + plateHeight;

// T-Slot measurements 
slotDist = 30;
slotWidth = 20*3;

width = slotWidth+60;

module roulette(localHeight=8)
{
  for(r=[-45, 0, 45, 135, 180, 225])
    rotate(r)
      translate([holeRad, 0, -1]) 
	cylinder(r=3, h=localHeight, $fn=25);
}

module carriageBody()
{
  translate([-slotWidth/2, 0, 0]) cube([slotWidth, mainBodyLength, mainBodyHeigh+5]);
  //translate([-width/2, 0, 0]) cube([width, mainBodyLength, plateHeight]);
  hull()
  {
    for(i = [-1, 1])
    {
      translate([width/2, mainBodyLength/2 + i* 40, 0]) cylinder(r=1, h=plateHeight);
      translate([width/2-18, mainBodyLength/2 + i* 40, 0]) cylinder(r=1, h=plateHeight);
    }
    translate([20, 0, 0]) cube([1, mainBodyLength, plateHeight]);
  }
  chained_hull()
  {
    translate([-width/2, mainBodyLength/2 - 8, 0]) cube([1, 16, plateHeight]);
    translate([-width/2+8, mainBodyLength/2 - 8, 0]) cube([1, 16, plateHeight]);

    translate([-slotWidth/2, 0, 0]) cube([1, mainBodyLength, plateHeight]);
  }
}

module carriageHoles()
{
  translate([0, mainBodyLength+5, mainBodyHeigh])
    rotate([90, 0, 0]) hull()
    {
      cylinder(r=mainBodyRad+0.5, h=30);
      translate([0, mainBodyRad, 0])
	cylinder(r=mainBodyRad+0.5, h=30);
    }

  translate([0, mainBodyLength-10, mainBodyHeigh])
    rotate([90, 0, 0]) 
      intersection()
      {
	cylinder(r=outerRad+0.5, h=mainBodyLength-10+1);
	cube([100, outerRad*2 - 8+0.5, 100], center=true);
      }

  translate([0, mainBodyLength-mainBodyLength/3, mainBodyHeigh])
    rotate([-90, 0, 0])
      roulette(mainBodyLength/3+2);
  
  // T-Slot bolt holes and cap holes
  for(j=[-1, 1]) 
  {
    translate([50-2.5, mainBodyLength/2+slotDist*j, -1])
      cylinder(r=2.5+0.25, h=mainBodyHeigh+2);
  }
  translate([-50, mainBodyLength/2, -1])
      cylinder(r=2.5+0.25, h=mainBodyHeigh+2);
  
  translate([45, mainBodyLength/2, -1])
      cylinder(r=14, h=mainBodyHeigh+2);
  
  
  //fancy cut out
  hull()
  {
    for(i=[-1, 1]) 
    {
      translate([i*slotWidth/2, mainBodyLength*2/3, mainBodyHeigh+5]) sphere(r=0.1);
      translate([i*slotWidth/2, 0, mainBodyHeigh+5]) sphere(r=0.1);
      translate([i*slotWidth/2, 0, plateHeight]) sphere(r=0.1);
    }
  }
}

module rodNutCarriage()
{
  difference()
  {
    carriageBody();
    carriageHoles();
  }
}

module chained_hull()
{
  for(i=[0:$children-2])
   hull()
   {
     children(i);
     children(i+1);
   }
}

// Helper module: centered cube on (X,Y) but not on Z, like cylinder
module centered_cube(size)
{
  translate([-size[0]/2, -size[1]/2, 0])
    cube(size);
}

separatorHeight = 33;
module separator()
{
  difference()
  {
    cylinder(r=6, h=separatorHeight);
    
    translate([0, 0, -1]) cylinder(r=3, h=separatorHeight+2);
  }
}

//mirror([0, 1, 0]) //Uncomment this to get the left part
rodNutCarriage(); 

for(i=[-1, 0, 1])
  translate([30*i, 70, 0])
    separator();