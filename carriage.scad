include <configuration.scad>

width = 76;
height = carriage_height;

offset = 25;
cutout = 20;
middle = 2*offset - width/2;

nut_depth = 4;
use_nut = false;

beef_and_spring = true;
spring_inset_width = 1;

module parallel_joints(reinforced) {
  difference() {
    union() {
      intersection() {
        cube([width, 20, 8], center=true);
        rotate([0, 90, 0]) cylinder(r=5, h=width, center=true);
      }
      intersection() {
        translate([0, 18, 4]) rotate([45, 0, 0])
          cube([width, reinforced, reinforced], center=true);
        translate([0, 0, 20]) cube([width, 35, 40], center=true);
      }
      translate([0, 8, 0]) cube([width, 16, 8], center=true);
    }
    rotate([0, 90, 0]) cylinder(r=1.55, h=80, center=true, $fn=12);

    for (x = [-offset-15, offset+15]) {
      translate([x, 5.5, 0])
        cylinder(r=cutout/2, h=100, center=true, $fn=24);
      translate([x, -4.5, 0])
        cube([cutout, 20, 100], center=true);
    }
    //Nut inset
    if(use_nut)
    translate([0, 0, 0]) rotate([0, 90, 0]) rotate([0, 0, 30])
      cylinder(r=3.3, h=cutout+nut_depth*2, center=true, $fn=6);
    if(beef_and_spring) {
        cube([spring_inset_width,10,10], center=true);
        hull() {
            translate([10,-5,0]) cylinder(r=7, h=100, center=true, $fn=36);
            translate([15,-5,0]) cylinder(r=7, h=100, center=true, $fn=36);
        }
        hull() {
            translate([-10,-5,0]) cylinder(r=7, h=100, center=true, $fn=36);
            translate([-15,-5,0]) cylinder(r=7, h=100, center=true, $fn=36);
        }
    }
    else {
        translate([0, 2, 0]) cylinder(r=middle, h=100, center=true);
        translate([0, -8, 0]) cube([2*middle, 20, 100], center=true);
    }
  }
}

module lm8uu_mount(d, h) {
  union() {
    difference() {
      intersection() {
        cylinder(r=11, h=h, center=true);
        translate([0, -8, 0]) cube([19, 13, h+1], center=true);
      }
      cylinder(r=d/2, h=h+1, center=true);
    }
  }
}

module belt_mount() {
  difference() {
    union() {
      difference() {
        translate([8, 2, 0]) cube([4, 13, height], center=true);
        for (z = [-3.5, 3.5])
          translate([8, 5, z])
            cube([5, 13, 3], center=true);
      }
      for (y = [1.5, 5, 8.5]) {
        translate([8, y, 0]) cube([4, 1.2, height], center=true);
      }
    }
  }
}

module carriage() {
  translate([0, 0, height/2]) 
  union() {
    for (x = [-30, 30]) {
      translate([x, 0, 0]) lm8uu_mount(d=15, h=24);
    }
    belt_mount();
    difference() {
      union() {
        translate([0, -5.6, 0])
          cube([50, 5, height], center=true);
        translate([0, -carriage_hinge_offset, -height/2+4])
          parallel_joints(16);
      }
      // Screw hole for adjustable top endstop.
      translate([15, -16, -height/2+4])
        cylinder(r=1.5, h=20, center=true, $fn=12);
      for (x = [-30, 30]) {
        translate([x, 0, 0])
          cylinder(r=8, h=height+1, center=true);
        // Zip tie tunnels.
        for (z = [-height/2+4, height/2-4])
          translate([x, 0, z])
            cylinder(r=13, h=3, center=true);
      }
    }
  }
}

carriage();

// Uncomment the following lines to check endstop alignment.
// use <idler_end.scad>;
// translate([0, 0, -20]) rotate([180, 0, 0]) idler_end();
