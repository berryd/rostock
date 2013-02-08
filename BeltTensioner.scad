// Belt dimensions
// All dimensions in mm

tAddToThick = 0.5;	 // Adds to overall thickness
tBase = 0.8;			 // Thickness of belt base
wTooth = 2.6;			 // Width of tooth (not actual, req)
belt_pitch = 2.4;		 // Width of space
wBelt = 6.2;			 // Width of belt
lBelt = 23;			 	 // Length of a bit of belt!

rScrew = 1.85;			 // Radius of screw hole
rNut	= 3.5;			 // Radius of nut keeper
tNut = 2;				 // Thickness of nut
wTen = 10;				 // Width of tensioner
hTen = 17;				 // Height of tensioner
dTen = 8;				 // Depth of tensioner
tArm = 3;				 // Arm brace thickness
lArm = 20;				 // Length of Arm brace

smooth=12;
bSmooth=6;

module half(nut) {
    difference() {
        union() {
            cube([hTen,dTen,wTen]) ;
            translate([0,-lArm,0]) cube([hTen,lArm+1,tArm]) ;		// bracing arm
            translate([hTen-0.1,0,0]) cube([3,dTen,wTen+tArm]) ;		// 'cap'
        }
        // Make screw hole
        translate([3+rScrew,13,(wTen-((wTen-tArm)/2))]) rotate([90,0,0]) cylinder(20,rScrew,rScrew,$fn=smooth);
        // Nut keeper
        if(nut == true)
        translate([3+rScrew,13-tNut,(wTen-((wTen-tArm)/2))]) rotate([90,0,0]) cylinder(5,rNut,rNut,$fn=6);
        // Belt slot
        translate([2*dTen,-dTen/2,hTen/2-wBelt/4]) rotate([-90,0,110]) belt();
    }
}

module belt() {
    module belt_segment() {
        difference() {
            translate([belt_pitch/4,0,tBase]) cube([belt_pitch,wBelt,tBase*2], center=true);
            translate([belt_pitch/2,0,tBase*2]) rotate([90,0,0]) cylinder(wBelt+2,belt_pitch/4, belt_pitch/4, $fn=bSmooth, center=true);
        }
        translate([0,0,tBase*2]) rotate([90,0,0]) cylinder(wBelt,belt_pitch/4, belt_pitch/4, $fn=bSmooth, center=true);
    }
    for (inc = [0:(belt_pitch):lBelt]) translate([inc, 0, 0]) belt_segment();
}

//belt();

half(true);
translate([lArm+2,0,0]) half();