/**
 * ZSpacer
 * 
 * Created by Diego Viejo
 * 24/03/2015
 * 
 * GPL V3
 * 
 */

height = 30;


difference()
{
  translate([-60/2, -30/2,0]) cube([60, 30, height]);
  
  for(i = [-1, 1])
  {
    translate([20*i, 0, -1]) cylinder(r=2.5+0.25, h=height+2);
  }
}