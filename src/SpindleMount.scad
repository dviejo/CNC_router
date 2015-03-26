/**
 * SpindleMount.scad
 * 
 * A simple mount part for holding the spindle.
 * 
 * Created by Diego Viejo
 * 
 */

//ball bearing bolt measurements
outerRad = 48 / 2;
holeRad = 38 / 2;
mainBodyRad = 28 / 2;

spindleRad = 52/2;
height = 20;
wallThick = 10;

mountHoleSeparation = 2*spindleRad * 0.8; //TODO: fit this to the ZCarriage

boltRad = 5/2 + 0.25;

extraLength = outerRad*2  - 8 + 0.75 - 8 + 0.5;

module spindleMount()
{
  difference()
  {
    union() //body
    {
      translate([-spindleRad*1.25, -extraLength, 0]) cube([2.5*spindleRad, 20 + extraLength, height]);
      translate([-spindleRad*2, -extraLength, 0]) cube([4*spindleRad, 20 , height]);
      translate([0, spindleRad+wallThick, 0]) cylinder(r=spindleRad+wallThick, h=height);
      translate([-10, spindleRad*2 + wallThick, 0]) cube([20, 2*wallThick, height]);
      
      //laterals
      translate([-spindleRad*2, -extraLength, 0]) cube([24, 20 , height*3]);
      hull()
      {
	translate([-spindleRad*1.25, -extraLength, 0]) cube([5, 20, height*3]);
	translate([-spindleRad*1.25, -extraLength, 0]) cube([5, 20 + extraLength, height]);
      }

      translate([spindleRad*2-24, -extraLength, 0]) cube([24, 20 , height*3]);
      hull()
      {
	translate([spindleRad*1.25 - 5, -extraLength, 0]) cube([5, 20, height*3]);
	translate([spindleRad*1.25 - 5, -extraLength, 0]) cube([5, 20 + extraLength, height]);
      }

      //upper back
      translate([-spindleRad*2, -extraLength, height*3-20]) cube([4*spindleRad, 5 , 20]);
      
    }
    
    translate([0, spindleRad+wallThick, -1]) cylinder(r=spindleRad, h=height+2);
    
    hull()
    {
      translate([-2, spindleRad*2, -1]) cube([4, 5, height+2]);
      translate([-7/2, spindleRad*2+40, -1]) cube([7, 5, height+2]);
    }
    
    
    //attaching holes
    translate([0, -extraLength, 0])
    for(i = [-1, 1])
    {
      translate([i*mountHoleSeparation, -20, height/2]) rotate([-90, 0, 0]) cylinder(r= boltRad, h= 60);
      translate([i*mountHoleSeparation, -20, height/2+40]) rotate([-90, 0, 0]) cylinder(r= boltRad, h= 60);
      //translate([i*mountHoleSeparation, 12, height/2]) rotate([-90, 0, 0]) cylinder(r=9*0.57, h= 60);
    }
    
    //fasten hole and nut
    translate([-20, spindleRad*2 + wallThick*5/2-1, height/2]) rotate([0, 90, 0]) cylinder(r=boltRad, h=40);
    translate([10-4.5, spindleRad*2 + wallThick*5/2-1, height/2]) rotate([0, 90, 0]) cylinder(r=9*0.57, h=5, $fn=6);
    
    
    //Transmision eje Z
    translate([0, -(outerRad -4 +0.75) + 8, 0])
    {
      roulette(localHeight = height+2);
      hull()
      {
	translate([0, 0, -1]) cylinder(r=mainBodyRad, h=height+2);
	translate([0, 25, -1]) cylinder(r=mainBodyRad, h=height+2);
      }
      *translate([0, 0, 10])   intersection()
      {
	cylinder(r=outerRad+1.75, h=height);
	cube([100, outerRad*2 - 8+1.5, 100], center=true);
      }      
    }

    //bites cut off
    translate([-spindleRad*2, -5, height]) rotate([45, 0, 0]) cube([spindleRad*4, 10,10]);
  }
}

module roulette(localHeight=8)
{
  for(r=[-45, 0, 180, 225])
    rotate(r)
    {
      translate([holeRad, 0, 10.35]) 
	cylinder(r=3, h=localHeight, $fn=25);
      translate([holeRad, 0, -1]) 
	cylinder(r=9*0.57, h=10+1, $fn=25);
    }
}

spindleMount();