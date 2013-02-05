include <configuration.scad>
use <carriage.scad>

h=platform_thickness;

cutout = 12.5;
inset = 6;

module platform() {
  translate([0, 0, h/2]) 
  difference() {
    union() {
      for (a = [0:120:359]) {
        rotate([0, 0, a]) {
          translate([0, -platform_hinge_offset, 0]) parallel_joints();
          // Close little triangle holes.
          translate([0, 31, 0]) cylinder(r=5, h=h, center=true);
          // Holder for adjustable bottom endstops.
        }
      }
      cylinder(r=30, h=h, center=true);
    }
    cylinder(r=20, h=h+12, center=true);

    for (a = [0:5]) {
      rotate(a*60) {
        translate([0, -25, 0])
          cylinder(r=2.2, h=h+1, center=true, $fn=12);
      }
    }

    //clean up rogue points
    for (a = [0:120:359]) {
          rotate(a+60) 
              translate([0, -platform_hinge_offset*1.5, 0]) 
                  cylinder(r=12.5, h=h+12, center=true);
    }


  }
}
platform();
