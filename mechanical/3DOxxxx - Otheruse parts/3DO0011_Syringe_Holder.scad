
include <configuration.scad>
include <shapes.scad>
include <3DO0010_Syringe_Plunger_Clip.scad>


module SyringeHolder() {
    syringe_length = 118;
    
    translate([0,0,25])rotate([90,0,180])difference() {
        Clip(width=60, height=50, thickness = 20, slot=3, slot_offset=[0,0,-5], slot_dia=48, bore_dia = 32, rr=2);
        hull() {
            cylinder(d=17, h=20);
            translate([0,25,0])cylinder(d=17, h=20);
        }

    }
    // base
    translate([-30,0,0])roundedCube([60, syringe_length, 8], radius = 2);
    //top
    translate([-30,syringe_length,0])difference() {
        translate([0,-10,0])roundedCube([60, 20, 50], radius = 2);
        hull() {
            rotate([90,0,0])translate([30,25,-5])cylinder(d1=2, d2=32, h=5);
            rotate([90,0,0])translate([30,50,-5])cylinder(d1=2, d2=32, h=5);
            rotate([90,0,0])translate([30,25,0])cylinder(d=32, h=10);
            rotate([90,0,0])translate([30,50,0])cylinder(d=32, h=10);
        }
        hull() {
            rotate([90,0,0])translate([30,30,-10])cylinder(d=8, h=20);
            rotate([90,0,0])translate([30,50,-10])cylinder(d=8, h=20);
        }
        hull() {
        }
    }
    
}

$fs=0.3;
$fa=6;
SyringeHolder();