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

extraLength = 0;// outerRad*2  - 8 + 0.75 - 8 + 0.5;

threadAxlePos = 95;

module spindleMount()
{
  difference()
  {
    union() //body
    {
      translate([-spindleRad*1.25, -extraLength, 0]) cube([2.5*spindleRad, 20 + extraLength, height]);
      translate([-spindleRad*2, -extraLength, 0]) cube([4*spindleRad, 20 , height]);
      translate([0, spindleRad+wallThick, 0]) cylinder(r=spindleRad+wallThick, h=height);
      translate([-10, spindleRad*2 + wallThick, 0]) cube([20, wallThick+2, height]);
      
      
      translate([-spindleRad*2, -extraLength, 0]) cube([24, 20 , height*3]);
      translate([spindleRad*2-24, -extraLength, 0]) cube([24, 20 , height*3]);

      //laterals
*      translate([-spindleRad*2-5-1, 0, 0])
      hull()
      {
	 cube([5, 20, height*3]);
	 cube([5, threadAxlePos+7, 10]);
      }
*      translate([spindleRad*2 +1, 0, 0])
      hull()
      {
        cube([5, 20, height*3]);
	cube([5, threadAxlePos+7, 10]);
      }

      //upper back
      translate([-spindleRad*2, -extraLength, height*3-20]) cube([4*spindleRad, 5 , 20]);
      
      
      //Transmision
      *translate([-spindleRad*2, threadAxlePos-20, 0]) cube([spindleRad*4, 27, 10]);
    } //end union
    
    //spindle support hole
    translate([0, spindleRad+wallThick, -1]) cylinder(r=spindleRad, h=height+2);
    
    hull()
    {
      translate([-2, spindleRad*2-1, -1]) cube([4, 1, height+2]);
      translate([-7/2, spindleRad*2+22, -1]) cube([7, 1, height+2]);
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
    translate([-25, spindleRad*2 + wallThick*5/3-1, height/2]) rotate([0, 90, 0]) cylinder(r=boltRad, h=40);
    translate([10-4.5, spindleRad*2 + wallThick*5/3-1, height/2]) rotate([0, 90, 0]) cylinder(r=9*0.57, h=18, $fn=6);
    translate([-20-4.5, spindleRad*2 + wallThick*5/3-1, height/2]) rotate([0, 90, 0]) cylinder(r=9*0.57, h=18, $fn=26);
    
    
    //assembly holes
    for(i=[-1, 1])
    {
        translate([i*(spindleRad*2+7), 4, 5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([i*(spindleRad*2+7), 16, 5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([i*(spindleRad*2+7), 4, height*3-5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([i*(spindleRad*2+7), 16, height*3-5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        
        //nuts
        hull()
        {
            translate([i*(spindleRad*2-3), -4, 5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-3), 4+0.2, 5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
        hull()
        {
            translate([i*(spindleRad*2-3), 20, 5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-3), 16-0.2, 5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
        hull()
        {
            translate([i*(spindleRad*2-3), -4, height*3-5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-3), 4+0.2, height*3-5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
        hull()
        {
            translate([i*(spindleRad*2-3), 20, height*3-5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-3), 16-0.2, height*3-5]) rotate([0, -i*90, 0]) rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
    }
  }
}

module lateral()
difference()
{
      hull()
      {
	 cube([5, 20, height*3]);
	 cube([5, threadAxlePos+7, 10]);
      }
      
      translate([7, 4, 5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20, $fn=20);
      translate([7, 16, 5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20, $fn=20);
      translate([7, 4, height*3-5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20, $fn=20);
      translate([7, 16, height*3-5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20, $fn=20);
      translate([7, threadAxlePos +3, 5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20, $fn=20);
      translate([7, threadAxlePos -16, 5]) rotate([0, -90, 0]) cylinder(d=3.3, h=20,$fn=20);
      
}

module transmision()
difference()
{
    translate([-spindleRad*2, -20, 0]) cube([spindleRad*4, 27, 10]);
    
    translate([0, 0, -4])
    {
      roulette(localHeight = height+2);
      hull()
      {
	translate([0, 0, -1]) cylinder(r=mainBodyRad-0.1, h=height+2);
	translate([0, 25, -1]) cylinder(r=mainBodyRad, h=height+2);
      }
    }

    //assembly holes
    for(i=[-1, 1])
    {
        translate([i*(spindleRad*2+7), 3, 5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        translate([i*(spindleRad*2+7), -16, 5]) rotate([0, -i*90, 0]) cylinder(d=3.3, h=20, $fn=20);
        hull()
        {
            translate([i*(spindleRad*2-6), 13, 5]) rotate([0, -i*90, 0]) 
                rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-6), 3-0.2, 5]) rotate([0, -i*90, 0]) 
                rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
        hull()
        {
            translate([i*(spindleRad*2-6), -25, 5]) rotate([0, -i*90, 0]) 
                rotate(30) cylinder(d=6.3, h=3, $fn=6);
            translate([i*(spindleRad*2-6), -16+0.2, 5]) rotate([0, -i*90, 0]) 
                rotate(30) cylinder(d=6.3, h=3, $fn=6);
        }
    }
}

module roulette(localHeight=8)
{
  for(r=[-45, 0, 180, 225])
    rotate(r)
    {
      translate([holeRad, 0, 10.35-1]) 
	cylinder(r=3, h=localHeight, $fn=25);
      translate([holeRad, 0, -1]) 
	cylinder(r=9*0.57, h=10+1, $fn=25);
    }
}

spindleMount();
translate([0, threadAxlePos, 10]) mirror([0, 0, 1]) transmision();
translate([-spindleRad*2-5-1, 0, 0]) 
    rotate([0, -90, 0]) //for printing
        lateral();
translate([spindleRad*2 +1, 0, 5]) 
    rotate([0, 90, 0]) //for printing
        lateral();
