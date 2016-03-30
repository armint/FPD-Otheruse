include <shapes.scad>
include <configuration.scad>

//$fs = 0.3;
//$fa = 1;
//3DO0013_608_Bearing_Block();
// endstop_baseh = 5mm  toph = 12mm depth = 7mm
// Axis height = 55mm
// pillar width = 15x24mm
// pillar base = 25x54mm
// pillar distance = 90mm

// endstop distance from center:
// halfwheel + interruptor  + extra_space_in_enstop + enstop_baseh 
// = 6 + 18 + 1 + 5 = 30

module 3DO0013_608_Bearing_Block() {
    BearingBlockWithEndstop();
    BearingCap();
}

module BearingBlockWithEndstop() {
//    %translate([0,0,55])rotate([90,0,0])cylinder(d=m8_dia, h=20, center=true);
    difference() {
        union() {
            rotate([-90,0,0])import("../3DLCxxxx - LooseCanon parts/STL/3DLC0001 608 bearing block (Delta motor assembly).stl",convexity=10);
            translate([-5,6,0])roundedCube([10,9,28]);
            translate([-4,-7,20])cube([8,13,8]);
//            translate([0,5,0])hull() {
//                translate([0,0,22.5])rotate([90,0,0])cylinder(d=10, h=12);
//                translate([0,0,25.5])rotate([90,0,0])cylinder(d=10, h=12);
//            }

        }
        // space for back-side electronics
        translate([-3.5,15-1,8])roundedCube([7,2,13]);
           // screw holes
            translate([0,16,0]) {
            hull() {
                translate([0,0,2.5])rotate([90,0,0])cylinder(d=m3_dia, h=16);
                translate([0,0,6.5])rotate([90,0,0])cylinder(d=m3_dia, h=16);
            }
            hull() {
                translate([0,0,22.5])rotate([90,0,0])cylinder(d=m3_dia, h=24);
                translate([0,0,25.5])rotate([90,0,0])cylinder(d=m3_dia, h=24);
            }
        }
        // Remove bearing cap
        translate([-27,-12.5,55])cube([54,25,20]);
    }
}

module BearingCap() {
    translate([0,40,0])difference() {
        translate([0,0,7.5])import("../3DLCxxxx - LooseCanon parts/STL/3DLC0001 608 bearing block (Delta motor assembly).stl",convexity=10);
        translate([-28, -55, -7.5])cube([56, 56, 28]);

    }
 
}