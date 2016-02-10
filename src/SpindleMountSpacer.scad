/**
 * SpindleMountSpacer
 * 
 * Created by Diego Viejo
 * 
 * 02/Dec/2015
 * 
 */

height = 69;
width = 75;
length = 16;//33;
rodBoltDistance = 55;
slotBoltDistance = 40;

separation = -0.3; //set this to positive value if you are going to print the piece vertically

//seta's parameter
legLength = length;

*seta();

rotate([90,0,0]) //comment this to print it vertically
difference()
{
    union()
    {
        translate([-width/2, -length/2, 0]) cube([width, length, height]);
        rotate([180,0, 0]) 
            for(col=[-20, 0, 20])
                translate([col, -length/2, 0]) seta();
    }
    
    for(i=[-1,1])
    {
        *translate([i*slotBoltDistance/2, 5, -1]) cylinder(d=5.5, h=height+2, $fn=25);
        *translate([i*slotBoltDistance/2, 5, 7]) cylinder(d=8, h=height+2, $fn=25);
        
        translate([i*rodBoltDistance/2, 0, height-13-7+separation]) cylinder(d=6.6, h=height, $fn=25);
        translate([i*rodBoltDistance/2, 0, -1-6]) cylinder(d=10.5, h=height-13+6, $fn=26);
    }
    
    for(fila=[10, 30])
        for(col=[-20, 0, 20])
            translate([col, length/2+1, fila]) rotate([90, 0, 0]) cylinder(d=5.4, h=length+2);
        
    for(fila = [1:3])
        for(col=[-1, 1])
            translate([col*10+col*(fila-1)*(fila-1), length/2+1, 19*fila]) rotate([90, 0, 0]) cylinder(d=13+(fila-1)*(fila-1), h=length+2);
}

module seta()
rotate([-90, 0, 0]) 
difference()
{
    cylinder(r=6.3, h=legLength);

    
    translate([5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    translate([-5-5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    
    translate([4.9/2, -2-0.4, -1]) cube([5, 10, legLength+2]);  //-0.4 is substracted to 
    translate([-5-4.9/2, -2-0.4, -1]) cube([5, 10, legLength+2]);//give room

    rotate(45)
        translate([-15/2, -15-5.875, -1]) cube([15, 15, legLength+2]);
    rotate(-45)
        translate([-15/2, -15-5.875, -1]) cube([15, 15, legLength+2]);
}
