include <3DO0001_Bearing_Joint.scad>
include <3DO0002_Catenary_Effector_Rod.scad>
include <3DO0003_Delta_Arm.scad>
include <3DO0004_ATC_Hub_End_Effector.scad>
include <3DO0005_Limit_Switch_Interruptor.scad>
include <3DO0006_Bearing_Fork.scad>
//include <3DO0007_Bearing_Cap.scad>

base_d = 55;
effector_d = 38;
//base_len = 2*base_d/tan(30);
//effector_len = 2*effector_d/tan(30);
arm_len = 90; // effective delta arm length
rod_len = 270;// rod length
rod_angle = acos((arm_len +base_d - effector_d)/rod_len);
echo("angle = ", rod_angle);
effector_height = sin(rod_angle)*rod_len; // plus eight because of axis distance in bearingJoint

module threeSides() {
    children();
    rotate([120,0,0])children();
    rotate([240,0,0])children();
}

module completeRod() {
    rod(rod_len);
    translate([0,0,5]) {
        translate([0,rod_len,0])rodBearingCap();
        rotate([0,0,180])rodBearingCap();
    }
}

module completeAtcHub() {
    atcHubBody();
    translate([0,0,13])rotate([0,180,60])atcHubCaps();
}

module oneArm() {
    translate([0,0,6])deltaArmAlt();
    translate([0,0,0])translate([0,74,0])rotate([-90,0,0])limitSwitchInterruptor();
    translate([0,0,-6])rotate([0,180,0])deltaArmAlt();
    // Top forks
    translate([0,90,15])rotate([0,0,90-rod_angle])fork();
    translate([0,90,-15])rotate([0,180,90-rod_angle])fork();
    // Bottom forks
    translate([-effector_height,effector_d-base_d,15])rotate([0,0,90-rod_angle])fork();
    translate([-effector_height,effector_d-base_d,-15])rotate([0,180,90-rod_angle])fork();
    translate([0,90,29])rotate([0,90,180-rod_angle])translate([0,0,-3])completeRod();
    translate([0,90,-29])rotate([0,90,180-rod_angle])translate([0,0,-3])completeRod();
}

module assembly() {
    rotate([0,-90,0]) {
        threeSides()translate([0,base_d,0])oneArm();
        translate([-effector_height - 5.5,0,0])rotate([0,90,0])completeAtcHub();
    }
}

//$fs=0.3;
//$fa=3;
//assembly();