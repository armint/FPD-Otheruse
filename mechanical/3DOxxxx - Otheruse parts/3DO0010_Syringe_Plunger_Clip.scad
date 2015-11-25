
include <configuration.scad>
include <shapes.scad>

module Clip(width=50, height=50, thickness = 8, slot=2, slot_offset=[0,0,0], slot_dia=33, bore_dia = 17, rr=0) {
    difference() {
        if (rr==0) {
            translate([-width/2,-height/2,0])cube([width, height, thickness]);
        }
        else {
            translate([-width/2,-height/2,0])roundedCube([width, height, thickness], radius=rr);
        }
        //
        translate(slot_offset)translate([0,0,(thickness-slot)/2])hull() {
            cylinder(d=bore_dia, h=thickness);
            translate([0,height/2,0])cylinder(d=bore_dia, h=thickness);
        }
        // slot
        translate(slot_offset)translate([0,0,(thickness-slot)/2])hull() {
            cylinder(d=slot_dia, h=slot);
            translate([0,height/2,0])cylinder(d=slot_dia, h=slot);
        }
    }
}

module PlungerClip() {
    Clip(width=50, height=50, thickness = 8, slot=2, bore_dia = 17, slot_dia=33, rr=2);
}

//PlungerClip();

//Clip(width=60, height=50, thickness = 20, slot=2, slot_offset=[0,0,-5], slot_dia=48, bore_dia = 32, rr=2);
