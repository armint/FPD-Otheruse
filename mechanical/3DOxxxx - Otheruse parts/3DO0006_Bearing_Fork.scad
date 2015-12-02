
include <configuration.scad>
include <shapes.scad>

fork_spacing = bearing_h + 6;

module bearingFork(fork_distance, fork_height, hexNut = true) {
    base_height = 5;
    side_thickness = 3;
    base_len = fork_distance + 2*side_thickness;
    base_width = 10;
    side_height = fork_height;
    corner_radius = 4;
    difference() {
        hull() {
            // base
            translate([-base_width/2, -base_len/2, 0])roundedBox([base_width,base_len,base_height], radius=corner_radius);
            // top
            translate([0,base_len/2,side_height-4])rotate([90,90,0])roundedCylinder(d=8, h=base_len);
        }
        // remove center
        translate([-base_width/2,-base_len/2+side_thickness,base_height])cube([base_width, fork_distance, side_height]);
        // top screw hole
        translate([0,base_len/2,side_height-4])rotate([90,90,0])cylinder(d=m3_dia, h=base_len);
        // bottom screw hole
        cylinder(d=m3_dia, h = base_height);
        // bottom nut hole
        if (hexNut) {
            translate([0,0,base_height - m3_nut_height])cylinder(d=m3_nut_dia, h = base_height, $fn=6);
        }
        else {
            translate([0,0,base_height - m3_nut_height])cylinder(d=m3_nut_dia, h = base_height);
        }
    }
}

module forkSpacer(d, h) {
    difference() {
        cylinder(d=d,h=h);
        cylinder(d=m3_dia,h=h);
    }
}


module fork() {
    bearingFork(fork_distance = fork_spacing, fork_height=18);
}


module 3DO0006_Bearing_Fork() {
    bearingFork(fork_distance = fork_spacing, fork_height=18);
}

//$fs=0.2;
//$fa=3;
//
//forkSpacer(d=m3_dia+2, h=2.8);
