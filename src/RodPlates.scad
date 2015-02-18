/**
 * Rod Plates
 * Created by Diego Viejo
 * 22/Jan/2015
 * 
 * Plate for attaching rod structure to a 20x60 TSlot
 * 
 */

wide = 70;
length = 33;
height = 10;

rodBoltDistance = 55;
rodBoltRad = 3;
rodNutRad = 5.5;
rodNutHeight = 7.5;
slotBoltDistance = 40;
slotBoltRad = 2.5;

// Helper module: centered cube on (X,Y) but not on Z, like cylinder
module centered_cube(size)
{
  translate([-size[0]/2, -size[1]/2, 0])
    cube(size);
}

module plate()
{
  difference()
  {
    centered_cube([wide, length, height]);
    
    //t-slot attaching holes
    for(i=[-1, 1])
    {
      translate([i*slotBoltDistance/2, length/3, -1]) 
	cylinder(r=slotBoltRad+0.25, h=height+2);
    }
    translate([0, -length/2 + 4, height-2.7]) 
	cylinder(r=slotBoltRad+0.25, h=height+2);
    #translate([0, -length/2 + 4, -3]) 
	cylinder(r=slotBoltRad*2+1, h=height);
    
    //rod structure attaching holes
    for(i=[-1, 1])
    {
      translate([i*rodBoltDistance/2, -length/3+3, -1]) 
	cylinder(r=rodBoltRad+0.25, h=height+2);
      translate([i*rodBoltDistance/2, -length/3+3, height-rodNutHeight]) 
	cylinder(r=rodNutRad+0.35, h=rodNutHeight+1, $fn = 6);
    }
  }
}

plate();