/**
 * SpindleMountSpacer
 * 
 * Created by Diego Viejo
 * 
 * 02/Dec/2015
 * 
 */

height = 87;
width = 70;
length = 33;
rodBoltDistance = 55;
slotBoltDistance = 40;

difference()
{
    translate([-width/2, -length/2, 0]) cube([width, length, height]);
    
    for(i=[-1,1])
    {
        translate([i*slotBoltDistance/2, 5, -1]) cylinder(d=5.5, h=height+2, $fn=25);
        
        translate([i*rodBoltDistance/2, -5, -1]) cylinder(d=6.6, h=height+2, $fn=25);
    }
}