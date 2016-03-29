
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
 
module rodB(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4, ball_dia = 10) {
    wall_thickness = 1;
    cat1D = centerWidth/2 - 1;
    cat2D = centerHeight - 2;
    id = ball_dia + 0.5;
    
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
            bothSides()Cup(id=id);
            // Top side 
            difference() {
                hull() {
                    translate([0,-10,0.5])cube([6,20,1], center=true);
                    translate([0,-10,3.5])cube([id + 2, 26, 1], center=true);
                }
                translate([-10,0,0])cube([20,20,10]);
            }
        }
  
    }
 }
 
 
module Cup(id = 10.5) {
    height = 10;
    od = id + 2;
    difference() {
        roundedCylinder(d=od, rr=0.5, h=height);
        translate([0,0,height+1])sphere(d=id);
        translate([0,0,height-1])cylinder(d1=id-1, d2=id+1, h=2);
        translate([2,-od/2,0])rotate([0,45,0])cube([od, od, od]);
        mirror([1,0,0])translate([2,-od/2,0])rotate([0,45,0])cube([od, od, od]);
    }
}
$fs=0.3;
$fa = 3;
//rodB();
//Cup();
module springThingy(h=6, w=10, d=6) {
    difference() {
        hull() {
            translate([0,d/2,h])rotate([0,90,0])roundedCylinder(d=d, rr=1, h=w);
            roundedCube([w, d, 4]);
        }
        translate([0,d/2,h])rotate([0,90,0])cylinder(d=2, h=w);
        
    }
}
springThingy();
//linear_extrude(5, scale=2)square([6,20], center=true);