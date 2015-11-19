include <3DO0001_Bearing_Joint.scad>
include <3DO0002_Catenary_Effector_Rod.scad>
include <3DO0003_Delta_Arm.scad>
include <3DO0004_ATC_Hub_End_Effector.scad>
include <3DO0005_Delta_Arm_Connector.scad>

module assembly() {
    deltaArm();
    translate([-4.5,90,10])rotate([0,0,90])rod(262);
    translate([0,0,-12])scale([1,1,-1]) {
        deltaArm();
        translate([-4.5,90,10])rotate([0,0,90])rod(262);
    }
    translate([0,0,-6]) {
        translate([0,61,0])rotate([-90,0,0])deltaArmConnector();
        translate([5,90,0])rotate([0,-90,0])bearingHolder();
        translate([-276,90-40-5,0])rotate([0,90,0])atcHub();
        translate([-276,90,0])rotate([0,90,0])bearingHolder();
    }
}

$fs=0.3;
$fa=3;
assembly();