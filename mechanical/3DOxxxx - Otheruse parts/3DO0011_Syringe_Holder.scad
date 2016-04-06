
include <configuration.scad>
include <shapes.scad>
include <3DO0010_Syringe_Plunger_Clip.scad>

syringe_length = 118;
syringe_dia = 32;
// 625zz
bearing_id = 5;
bearing_od = 16;
bearing_h = 5;

module MotorBody(MotorH = 50, MotorW = 42){
	translate([0,0,MotorH/2])
		intersection(){
			cube([MotorW*1.285,MotorW*1.285,MotorH],center=true);
			rotate([0,0,45])
				cube([MotorW,MotorW,MotorH],center=true);
		}

}

module Motor(MotorH = 50, MotorW = 42) {
    rotate([0,0,45])MotorBody(MotorH = MotorH, MotorW = MotorW);
    translate([0,0,MotorH])cylinder(d=22, h=1);
    translate([0,0,MotorH])cylinder(d=5, h=22);
}

module SyringeNoseSlot() {
        //top
    translate([-25,0,-20])difference() {
        translate([0,-4,0])roundedCube([50, 10, 25], radius = 2);
        hull() {
            rotate([90,0,0])translate([25,20,-5])cylinder(d1=2, d2=syringe_dia, h=5);
            rotate([90,0,0])translate([25,50,-5])cylinder(d1=2, d2=syringe_dia, h=5);
            rotate([90,0,0])translate([25,20,0])cylinder(d=syringe_dia, h=10);
            rotate([90,0,0])translate([25,50,0])cylinder(d=syringe_dia, h=10);
        }
        hull() {
            rotate([90,0,0])translate([25,20,-10])cylinder(d=8, h=20);
            rotate([90,0,0])translate([25,50,-10])cylinder(d=8, h=20);
        }
    }
}

module SyringeTailClip() {
    
//    %translate([0,5,0])rotate([90,0,0])cylinder(d=17, h=10);
    translate([0,0,-10])rotate([90,0,180])difference() {
        union() {
            Clip(width=100, height=40, thickness = 15, slot=3, slot_offset=[0,10,-2], slot_dia=48, bore_dia = syringe_dia, rr=2);
//            translate([-50,-25-40,0])roundedCube([100, 54, 15], radius = 2);
        }
        // space for plunger
        hull() {
            translate([0,10,0])cylinder(d=17, h=20);
            translate([0,25,0])cylinder(d=17, h=20);
        }
        // bearing slots
        for (a = [1,-1]) {
            hull() {
                translate([a*35,20,7.5])cylinder(d=bearing_od + 0.6, h=bearing_h + 0.4, center = true);
                translate([a*35,10,7.5])cylinder(d=bearing_od + 0.6, h=bearing_h + 0.4, center = true);
            }
            translate([a*35,10,-1])cylinder(d=m5_nut_dia + 2, h=22);
        }
    }
}

module motorMountPlate() {
    difference() {
        union() {
            // plate
            translate([-27, 0, 2])cube([54, 3, 58]);
            translate([11.5,0,0])cube([8,4,60]);
            translate([-11.5-8,0,0])cube([8,4,60]);
            for (x=[1,-1]) {
                translate([x*21,0,0])hull() {
                    translate([-1.5,0,0])cube([3,3,60]);
                    translate([-1.5,-20,0])cube([3,20,1]);
                }
            }
        }
        translate([0,5,21+6]) {
            hull() {
                rotate([90,0,0])cylinder(d=m5_dia + 1, h=10);
                translate([0,0,8])rotate([90,0,0])cylinder(d=m5_dia + 1, h=10);
            }
            for (a=[45:90:360]) {
                hull() {
                    rotate([90,a,0])translate([0,22,0])cylinder(d=m3_dia, h=10);
                    translate([0,0,8])rotate([90,a,0])translate([0,22,0])cylinder(d=m3_dia, h=10);
                }
            }
        }
    }
}

module SyringeHolder() {
    // 20 vs 30 diep
    difference() {
        union() {
            translate([0,0,75]) {
                translate([0, syringe_length, 0])SyringeNoseSlot();
                SyringeTailClip();
            }
            // extends tailClip
            translate([-50,0,0])roundedCube([100,15,50], radius = 2);
            // extend noseSlot
            translate([-25, syringe_length-4, 0])roundedCube([50, 10, 59], radius = 2);
            // base
            translate([-25, 0, 0])roundedCube([50,syringe_length,6], radius = 2);
            // motor mount
            translate([0, 45, 0])motorMountPlate();
            // bearing mounts
            for (i = [-1,1]) {
                translate([i*35,45,0])bearingMount();
            }
            // bearing mounts base
            translate([-45, 45, 0])roundedCube([90,15,6], radius = 2);
            
        }
        translate([0,16,21 + 6])for (a=[45:90:360]) {
            hull() {
                rotate([90,a,0])translate([0,22,0])cylinder(d=6, h=20);
                translate([0,0,8])rotate([90,a,0])translate([0,22,0])cylinder(d=6, h=20);
            }
        }
    }

            
}


module DriveClip() {
    difference() {
        Clip(width=100, height=50, thickness = 10, slot=2, slot_offset=[0,0,-1], slot_dia=48, bore_dia = 32, rr=2);
        for (a = [1,-1]) {
            translate([a*35,0,-1])cylinder(d=m5_dia, h=22);
            hull() {
                translate([a*50,0,5])cylinder(d=m5_nut_dia, h=m5_nut_height, center = true, $fn=6);
                translate([a*25-0.2,0,5])cylinder(d=m5_nut_dia, h=m5_nut_height, center = true, $fn=6);
            }
        }
        
    }
}

module bearingMount() {
    translate([0,0,60])difference() {
        translate([-10,0,0])roundedCube([20, 15, 15], radius = 2);
        translate([0,7.5,15])rotate([90,0,0])cylinder(d=bearing_od+0.6, h=bearing_h + 0.4,center = true);
        translate([0,7.5,15])rotate([90,0,0])cylinder(d=m5_nut_dia + 1, h=20,center = true);
    }
    translate([-10,0,0])difference() {
        roundedCube([20, 15, 64], radius = 2);
        translate([2,2,0])cube([16, 11, 64], radius = 2);
    }
}

$fs=0.4;
$fa=2;

    

//SyringeNoseSlot();
//SyringeTailClip();
SyringeHolder();

//translate([0,-60,25])rotate([-90,180,0])
//DriveClip();
%for (a = [1,-1]) {
    translate([a*35,100,75])rotate([90,0,0])cylinder(d=m5_dia, h=200);
//    translate([a*35,60,25])rotate([90,0,0])cylinder(d=m5_dia, h=200);
}
module TwinPulley() {
    translate([0,0,8])rotate([180,0,0])import("Pulley_GT2_20T.stl");
    rotate([0,0,0])import("Pulley_GT2_20T.stl");
}

%translate([0,100,21 + 6])rotate([90,0,0])Motor();
%translate([0,37,21 + 6])rotate([90,0,0])TwinPulley();
//%hull() {
//    translate([0,28,-13])rotate([90,0,0])cylinder(d=15, h=8);
//    translate([40,28,25])rotate([90,0,0])cylinder(d=15, h=8);
//}
//%hull() {
//    translate([0,46,-13])rotate([90,0,0])cylinder(d=15, h=8);
//    translate([-40,46,25])rotate([90,0,0])cylinder(d=15, h=8);
//}
//translate([40,37,25])rotate([90,0,0])import("Pulley_GT2_20T.stl");
//translate([-40,55,25])rotate([90,0,0])import("Pulley_GT2_20T.stl");