/**
 * SpindleMount.scad
 * 
 * A simple mount part for holding the spindle.
 * 
 * Created by Diego Viejo
 * 
 */


spindleRad = 52/2;
height = 20;
wallThick = 10;

mountHoleSeparation = 2*spindleRad * 0.8; //TODO: fit this to the ZCarriage

boltRad = 5/2 + 0.25;

module spindleMount()
{
  difference()
  {
    union() //body
    {
      translate([-spindleRad*2, 0, 0]) cube([4*spindleRad, 20, height]);
      translate([0, spindleRad+wallThick, 0]) cylinder(r=spindleRad+wallThick, h=height);
      translate([-10, spindleRad*2 + wallThick, 0]) cube([20, 2*wallThick, height]);
    }
    
    translate([0, spindleRad+wallThick, -1]) cylinder(r=spindleRad, h=height+2);
    
    hull()
    {
      translate([-2, spindleRad*2, -1]) cube([4, 5, height+2]);
      translate([-7/2, spindleRad*2+40, -1]) cube([7, 5, height+2]);
    }
    
    
    //attaching holes
    for(i = [-1, 1])
    {
      translate([i*mountHoleSeparation, -20, height/2]) rotate([-90, 0, 0]) cylinder(r= boltRad, h= 60);
      translate([i*mountHoleSeparation, 12, height/2]) rotate([-90, 0, 0]) cylinder(r=9*0.57, h= 60);
    }
    
    //fasten hole and nut
    translate([-20, spindleRad*2 + wallThick*5/2-1, height/2]) rotate([0, 90, 0]) cylinder(r=boltRad, h=40);
    translate([10-4.5, spindleRad*2 + wallThick*5/2-1, height/2]) rotate([0, 90, 0]) cylinder(r=9*0.57, h=5, $fn=6);
  }
}

spindleMount();