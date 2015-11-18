
include <configuration.scad>
include <shapes.scad>

wall_thickness = 2.5;

module mountHoles(depth = 10) {
    difference() {
        children();
        // M8 hole
        cylinder(d = 8.5, h = depth);
        // M3 holes * nut slots
        translate([7,7,0])cylinder(d=m3_dia, h = depth);
        translate([7,7,7])cylinder(d=m3_nut_dia, h = depth);
        translate([7,-7,0])cylinder(d=m3_dia, h = depth);
        translate([7,-7,7])cylinder(d=m3_nut_dia, h = depth, $fn=6);
        translate([-7,7,0])cylinder(d=m3_dia, h = depth);
        translate([-7,7,7])cylinder(d=m3_nut_dia, h = depth, $fn=6);
        translate([-7,-7,0])cylinder(d=m3_dia, h = depth);
        translate([-7,-7,7])cylinder(d=m3_nut_dia, h = depth);

    }
}

module deltaArmBase(height_l = 6.5, height_h = 12.5, length = 90, base_dia = 32, end_dia=15) {
    support0_dx = (end_dia/2 + 7*base_dia/2)/8;
    support0_h = (7*height_h + height_l)/8;
    support0_dy = length/8;
    support1_dx = (end_dia/2 + base_dia/2)/2;
    support1_h = (height_h + height_l)/2;
    support1_dy = length/2;
    support2_dx = (2*end_dia/2 + base_dia/2)/3;
    support2_h = (height_h + 2*height_l)/3;
    support2_dy = 2*length/3;
    support3_dx = (6*end_dia/2 + base_dia/2)/7;
    support3_h = (height_h + 7*height_l)/8;
    support3_dy = 6*length/7;

    cylinder(d = base_dia, h = height_h);
    // bottom
    hull() {
        translate([end_dia/2 - wall_thickness/2, length, 0])cylinder(d=wall_thickness, h=wall_thickness);
        translate([base_dia/2 - wall_thickness/2, 0, 0])cylinder(d=wall_thickness, h=wall_thickness);
        translate([-end_dia/2 + wall_thickness/2, length, 0])cylinder(d=wall_thickness, h=wall_thickness);
        translate([-base_dia/2 + wall_thickness/2, 0, 0])cylinder(d=wall_thickness, h=wall_thickness);
    }
    // side
    hull() {
        translate([end_dia/2 - wall_thickness/2, length, 0])cylinder(d=wall_thickness, h=height_l);
        translate([base_dia/2 - wall_thickness/2, 0, 0])cylinder(d=wall_thickness, h=height_h);
    }
    // side
    hull() {
        translate([-end_dia/2 + wall_thickness/2, length, 0])cylinder(d=wall_thickness, h=height_l);
        translate([-base_dia/2 + wall_thickness/2, 0, 0])cylinder(d=wall_thickness, h=height_h);
    }
    // internal support
    hull() {
        translate([support1_dx - wall_thickness/2, support1_dy, 0])cylinder(d=wall_thickness, h=support1_h);
        translate([-support0_dx + wall_thickness/2, support0_dy, 0])cylinder(d=wall_thickness, h=support0_h);
    }
    // internal support
    hull() {
        translate([support1_dx - wall_thickness/2, support1_dy, 0])cylinder(d=wall_thickness, h=support1_h);
        translate([-support2_dx + wall_thickness/2, support2_dy, 0])cylinder(d=wall_thickness, h=support2_h);
    }
    // internal support
    hull() {
        translate([-support2_dx + wall_thickness/2, support2_dy, 0])cylinder(d=wall_thickness, h=support2_h);
        translate([support3_dx - wall_thickness/2, support3_dy, 0])cylinder(d=wall_thickness, h=support3_h);
    }

}


module deltaArmAlt(length = 90) {
    opening = bearing_od - 2;
    mount_dia = bearing_od + 2*wall_thickness;
    height_h = 12.5;
    height_l = bearing_h + wall_thickness;
    nut_depth = 5;
    screw_dist = 7;
    difference() {
        union() {
            mountHoles(height_h)deltaArmBase(height_h = 12.5, length = length, height_l = height_l);
            translate([0,length,0])cylinder(d=mount_dia, h=height_l);
         }
         // Opening for bearing
        translate([0,length,height_l - bearing_h])cylinder(d=bearing_od + 0.5, h=bearing_h + 1);
         // opening for axis
        translate([0,length,0])cylinder(d=opening, h=height_l);
        translate([0,90,0]) {
            translate([3,-11,0])cylinder(d=m3_dia, h=20, center=true);
            translate([-3,-11,0])cylinder(d=m3_dia, h=20, center=true);

         }
    }
 
}

module deltaArm(hex = true) {
    height_h = 12.5;
    axis_distance = 90 - 12;
    end_dia = 15;
    angle = atan2((32 - end_dia)/2, axis_distance);
    height_l = 7;
    difference() {
        union() {
            mountHoles(height_h)deltaArmBase(height_l = height_l, height_h = height_h, length = axis_distance, base_dia = 32, end_dia=end_dia);
//            translate([-end_dia/2,axis_distance-10,0])cube([end_dia, 10, height_l]);
                   // base
            translate([0,axis_distance,0])mirror([0,1,0])hull() {
                translate([-end_dia/2, 0, 0])cube([end_dia, 1,height_l]);
                translate([-end_dia/2, 0, 0])rotate([0,0,angle])translate([2,15,0])cylinder(r=2, h = height_l);
                translate([end_dia/2, 0, 0])rotate([0,0,-angle])translate([-2,15,0])cylinder(r=2, h = height_l);
            }
        }
        // Slice top off
        translate([-end_dia/2,axis_distance,0])cube([end_dia, wall_thickness, height_h]);
        // screw holes
        translate([-end_dia/2 + 3, axis_distance - 12, 0])cylinder(d=m3_dia, h=height_h);
        translate([end_dia/2 - 3, axis_distance - 12, 0])cylinder(d=m3_dia, h=height_h);
        // nut holes
        if (hex) {
            translate([-end_dia/2 + 3, axis_distance - 12, 4])cylinder(d=m3_nut_dia, h=height_h, $fn=6);
            translate([end_dia/2 - 3, axis_distance - 12, 4])cylinder(d=m3_nut_dia, h=height_h, $fn=6);
        }
        else {
            translate([-end_dia/2 + 3, axis_distance - 12, 4])cylinder(d=m3_nut_dia, h=height_h);
            translate([end_dia/2 - 3, axis_distance - 12, 4])cylinder(d=m3_nut_dia, h=height_h);
        }
    }
}

//$fa=3;
//$fs=0.2;
deltaArm(true);
translate([28,62,0])mirror([0,1,0])deltaArm(false);

