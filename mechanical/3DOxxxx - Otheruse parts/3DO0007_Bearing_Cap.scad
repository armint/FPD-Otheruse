
include <configuration.scad>
include <shapes.scad>

mount_wall_thickness = 2.5;
mount_dia = bearing_od + 2*mount_wall_thickness;

module bearingMount(rounded = false, flange = 2.5) {
    width = bearing_h + 4;
    opening = bearing_od - 2;
    slope_len = 1.5;
    
    difference() {
        union() {
            if (rounded) {
                roundedCylinder(d=mount_dia, h=width);
            }
            else {
                cylinder(d=mount_dia, h=width);
            }
            hull() {
                translate([mount_dia/2,0,width/2])rotate([90,0,0])cylinder(d=5, h=flange);
                translate([mount_dia/2 - mount_wall_thickness, - flange, 0])cube([mount_wall_thickness, flange, width]);
            }
            hull() {
                translate([-mount_dia/2,0,width/2])rotate([90,0,0])cylinder(d=5, h=flange);
                translate([-mount_dia/2, - flange, 0])cube([mount_wall_thickness, flange, width]);
            }
//           
        }
        cylinder(d=opening, h=width);
        translate([0,0,bearing_h+2])cylinder(d1=bearing_od, d2=opening,h=slope_len);
        translate([0,0,2-slope_len])cylinder(d1=opening, d2=bearing_od,h=slope_len);
        translate ([0,0,2])cylinder(d=bearing_od, h=bearing_h);
        translate([-mount_dia/2,0,0])cube([mount_dia, mount_dia, width]);
//
        // M2 bolts
        translate([mount_dia/2,0,width/2])rotate([90,0,0])cylinder(d=m2_dia, h=flange);
        translate([-mount_dia/2,0,width/2])rotate([90,0,0])cylinder(d=m2_dia, h=flange);
        // nut/head
        translate([mount_dia/2,-flange,width/2])rotate([90,0,0])cylinder(d=m2_nut_dia, h=flange);
        translate([-mount_dia/2,-flange,width/2])rotate([90,0,0])cylinder(d=m2_nut_dia, h=flange);
        
    }
}

module bearingCap() {
    difference() {
        bearingMount(true, 3.5);
         // Slice 1 mm off
        cube(size=[30, 1, 20], center = true);
    }
}


module 3DO0007_BearingCap() {
    bearingCap();
}
