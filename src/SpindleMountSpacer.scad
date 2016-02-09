/**
 * SpindleMountSpacer
 * 
 * Created by Diego Viejo
 * 
 * 02/Dec/2015
 * 
 */

height = 87;
width = 75;
length = 33;
rodBoltDistance = 55;
slotBoltDistance = 40;

separation = -0.3; //set this to positive value if you are going to print the piece vertically

//seta's parameter
legLength = length;

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
        
        translate([i*rodBoltDistance/2, 0, height-7-1+separation]) cylinder(d=6.6, h=height, $fn=25);
        translate([i*rodBoltDistance/2, 0, -1]) cylinder(d=11, h=height-7, $fn=6);
    }
    
    for(fila=[10, 30])
        for(col=[-20, 0, 20])
            translate([col, length/2+1, fila]) rotate([90, 0, 0]) cylinder(d=5.35, h=length+2);
        
    for(fila = [1:3])
        for(col=[-1, 1])
            translate([col*10+col*(fila-1)*(fila-1), length/2+1, 20*fila+(fila-1)*4]) rotate([90, 0, 0]) cylinder(d=13+(fila-1)*(fila-1), h=length+2);
}

module seta()
rotate([-90, 0, 0]) 
difference()
{
    cylinder(r=6.35, h=legLength);

    
    translate([5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    translate([-5-5.75, -15/2, -1]) cube([5, 15, legLength+2]);
    
    translate([5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);  //-0.2 is added to 
    translate([-5-5.25/2, -2-0.2, -1]) cube([5, 10, legLength+2]);//give room

}
