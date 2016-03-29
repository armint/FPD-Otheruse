include <configuration.scad>
include <shapes.scad>


module limitSwitchInterruptor() {
    width = 12;
    height = 12;
    wall_thickness = 2.5;
    interruptor_thickness = 1;
    // angle is based on delta arm dimesions
    angle = atan2((32 - width)/2, 90);
    difference() {
        union() {
            // base
            translate([0,-height/2,17])rotate([-90,0,0])hull() {
                translate([0, 1, 0])cylinder(d=width, h=height);
                translate([-width/2, 0, 0])rotate([0,0,angle])translate([2,15,0])cylinder(r=2, h = height);
                translate([width/2, 0, 0])rotate([0,0,-angle])translate([-2,15,0])cylinder(r=2, h = height);
            }
            // limit switch interruptor
//            hull() {
//                translate([22,0,30])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//                translate([18,0,30])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//
//                translate([18,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//                translate([12,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//            }
//            hull() {
//                translate([5,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//                translate([18,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//                translate([5,0,1])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//                translate([13,0,1])rotate([90,0,0])cylinder(d=2, h=1, center=true);
//            }
//
        }
        translate([0,-height/2,17])rotate([-90,0,0]) {
            // screw holes
            translate([-3, 12, 0])cylinder(d=m3_dia, h=height);
            translate([3, 12, 0])cylinder(d=m3_dia, h=height);
            translate([0, 1, 0])cylinder(d=m4_dia, h=height);
        }
        // slice tiny edge of bottom
        translate([0,0,-1])cube(size=[width+4, height, 2], center=true);
    }
 }

module 3DO0005_Limit_Switch_Interruptor() {
    limitSwitchInterruptor();
}

//$fs=0.2;
//$fa=1;
//limitSwitchInterruptor();