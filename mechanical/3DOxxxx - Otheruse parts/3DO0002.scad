
include <configuration.scad>
include <shapes.scad>
//include <3DO0007_Bearing_Cap.scad>

bearing_space = bearing_od + 0.3;

module bearingMount(wall_thickness) {
    bearing_space = bearing_od + 0.3;
    difference() {
        hull() {
            cylinder(d=bearing_space+wall_thickness*2, h=bearing_h+wall_thickness);
            translate([0,(bearing_space+m2_dia+1)/2,0])cylinder(d=5, h=bearing_h+wall_thickness);
        }
        // bearing
        translate([0,0,wall_thickness])cylinder(d=bearing_space, h=bearing_h);
        // opening
        cylinder(d=8, h=bearing_h+wall_thickness);
        translate([0,(bearing_space+m2_dia+1)/2,0])cylinder(d=m2_dia, h=bearing_h+wall_thickness);
    }
}

module rodBearingCap(wall_thickness = 1) {
    difference() {
        hull() {
            cylinder(d=bearing_space+wall_thickness*2, h=wall_thickness);
            translate([0,(bearing_space+m2_dia+1)/2,0])cylinder(d=5, h=wall_thickness);
            translate([0,-(bearing_space+m2_dia+1)/2,0])cylinder(d=5, h=wall_thickness);
        }
        // opening
        cylinder(d=8, h=bearing_h+wall_thickness);
        // M2 screws
        translate([0,(bearing_space+m2_dia+1)/2,0])cylinder(d=m2_dia, h=wall_thickness);
        translate([0,-(bearing_space+m2_dia+1)/2,0])cylinder(d=m2_dia, h=wall_thickness);
    }
}

module rod(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4) {
    wall_thickness = 1;
    cat1D = centerWidth/2 - 1;
    cat2D = centerHeight - 2;
    
     module bothSides() {
        translate([0,length,0])children();
        rotate([0,0,180])children();
    }

   difference() {
        union() {
            rotate([0,0,90]) {
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
            bothSides()bearingMount(wall_thickness);
        }
        bothSides() {
            // make space for bearing mount
            translate([0,0,wall_thickness])cylinder(d=bearing_space, h=20);
            cylinder(d=8, h=bearing_h+wall_thickness);
            // make space for bearing mount cap
            translate([0,0,bearing_h+wall_thickness])hull() {
                cylinder(d=bearing_space+wall_thickness*2+0.5, h=5);
                translate([0,-(bearing_space+m2_dia+1)/2,0])cylinder(d=5.5, h=5);
            }
            // M2 screw hole
            translate([0,-(bearing_space+m2_dia+1)/2,0])cylinder(d=m2_dia, h=bearing_h+wall_thickness);
       }
 
    }
 }
 
//$fs=0.3;
//rod();
