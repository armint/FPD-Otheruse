include <configuration.scad>
include <shapes.scad>


module deltaArmConnector() {
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
        }
        translate([0,-height/2-1,17])rotate([-90,0,0]) {
            // screw holes
            translate([-3, 12, 0])cylinder(d=m3_dia, h=height+2);
            translate([3, 12, 0])cylinder(d=m3_dia, h=height+2);
            translate([0, 1, 0])cylinder(d=m4_dia, h=height+2);
        }
        // slice tiny edge of bottom
        translate([0,0,-1])cube(size=[width+4, height, 2], center=true);
    }
 }

module 3DO0008_Delta_Arm_Connector() {
    deltaArmConnector();
}

//$fs=0.3;
//$fa=1;
//3DO0008_Delta_Arm_Connector();