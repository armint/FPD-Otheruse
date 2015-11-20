
include <configuration.scad>
include <shapes.scad>
include <3DO0007_Bearing_Cap.scad>

module rod(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4) {
    cat1D = centerWidth/2 - 1;
    cat2D = centerHeight - 2;
    translate([0,length,0])bearingMount(false);
    rotate([0,0,180])bearingMount(false);

    rotate([0,0,90])
    difference() {
        union() {
            //base
            translate([length/2,0,1])minkowski() {
                union() {
                    linear_extrude(height=plate_thickness - 1)catenary(length-1, cat1D);
                    rotate([0,0,180])linear_extrude(height=plate_thickness - 1)catenary(length-1, cat1D);
                }
                sphere(r=1,center=true);
            }
            //ridge
            translate([length/2,plate_thickness/2-1,1])minkowski() {
                rotate([90,0,0])linear_extrude(height=plate_thickness - 2)catenary(length-1, cat2D,55);
                 sphere(r=1,center=true);
            }
        }
        cylinder(d=bearing_od, h=20);
        translate([length,0,0])cylinder(d=bearing_od, h=20);
    }
}

