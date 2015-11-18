include <configuration.scad>
include <shapes.scad>


module deltaArmConnector() {
    width = 15;
    height = 12;
    wall_thickness = 2.5;
    interruptor_thickness = 1;
    // angle is based on delta arm dimesions
    angle = atan2((32 - width)/2, 90-12);
    difference() {
        union() {
            // base
            translate([0,-height/2,17])rotate([-90,0,0])hull() {
                translate([-width/2, 0, 0])cube([width, 1,height]);
                translate([-width/2, 0, 0])rotate([0,0,angle])translate([2,15,0])cylinder(r=2, h = height);
                translate([width/2, 0, 0])rotate([0,0,-angle])translate([-2,15,0])cylinder(r=2, h = height);
            }
            // limit switch interruptor
            hull() {
                translate([0,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
                translate([18,0,16])rotate([90,0,0])cylinder(d=2, h=1, center=true);
                translate([0,0,1])rotate([90,0,0])cylinder(d=2, h=1, center=true);
                translate([12,0,1])rotate([90,0,0])cylinder(d=2, h=1, center=true);
            }
        }
        translate([0,-height/2,17])rotate([-90,0,0]) {
            // bearing joint mount
            translate([0,0,height/2])rotate([-90,0,0])cylinder(d=m3_dia, h=20);
            translate([0,14,height/2])rotate([-90,0,0])cylinder(d=m3_nut_dia, h=20, $fn=6);
            // screw holes
            translate([-width/2 + 3, 12, 0])cylinder(d=m3_dia, h=height);
            translate([width/2 - 3, 12, 0])cylinder(d=m3_dia, h=height);
        }
        // slice tiny edge of bottom
        translate([0,0,-1])cube(size=[width+4, height, 2], center=true);
    }
    // print support
    translate([0,-height/2,17])rotate([-90,0,0])translate([0,14-print_layer_height,height/2])rotate([-90,0,0])cylinder(d=m3_nut_dia, h=print_layer_height);
}

//$fs=0.2;

deltaArmConnector();