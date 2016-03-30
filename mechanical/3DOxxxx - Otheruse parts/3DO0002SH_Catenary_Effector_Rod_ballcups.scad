

include <3DO0002H_Catenary_Effector_Rod.scad>

module 3DO0002SH_Catenary_Effector_Rod_ballcups() {
    length = 270;
    splitRodBase(length = length, centerWidth=12, centerHeight=12, hex = true)rodB(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4);
    translate([13, length/2+15, 0])rotate([0,0,180])splitRodBase(length = 270, centerWidth=12, centerHeight=12, hex = false)rodB(length = length, centerWidth=12, centerHeight=12, plate_thickness = 4);
}


3DO0002SH_Catenary_Effector_Rod_ballcups();