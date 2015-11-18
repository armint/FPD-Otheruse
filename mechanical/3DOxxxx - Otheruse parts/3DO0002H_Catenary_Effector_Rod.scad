
include <3DO0002.scad>

module splitRodBase(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4, hex = true) {
    connector_len = 30;
    difference() {
//        color([1,0,0,1])
        union() {
            rod(length, centerWidth, centerHeight, plate_thickness);
            translate([-centerWidth/2, length/2 - connector_len/2], 0)roundedCube([centerWidth/2, connector_len, centerHeight]);
        }
        // Remove part of the rod
        translate([-10, length/2 + connector_len/2], 0)cube([20, length/2, 20]);
        // Remove half of the connector
        translate([0, length/2 - connector_len/2], 0)cube([20, connector_len, 20]);
        // Screw holes (we use a smaller diameter here for a perfect fit...)
        translate([-centerWidth/2, length/2 - connector_len/2 + 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=3.2, h=centerWidth/2);
        translate([-centerWidth/2, length/2 + connector_len/2 - 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=3.2, h=centerWidth/2);
        // Nut traps
        if (hex) {
            translate([-centerWidth/2-1, length/2 - connector_len/2 + 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=m3_nut_dia, h=m3_nut_height+1, $fn=6);
            translate([-centerWidth/2-1, length/2 + connector_len/2 - 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=m3_nut_dia, h=m3_nut_height+1,$fn=6);
        }
        else {
            translate([-centerWidth/2-1, length/2 - connector_len/2 + 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=m3_nut_dia, h=m3_nut_height+1);
            translate([-centerWidth/2-1, length/2 + connector_len/2 - 5, centerHeight/2])rotate([0, 90, 0])cylinder(d=m3_nut_dia, h=m3_nut_height+1);
        }
    }
}

module splitRod(length = 270, centerWidth=12, centerHeight=12, plate_thickness = 4) {
    splitRodBase(length, centerWidth, centerHeight, plate_thickness, true);
    translate([13, length/2+15, 0])rotate([0,0,180])splitRodBase(length, centerWidth, centerHeight, plate_thickness, false);
}

splitRod(262);