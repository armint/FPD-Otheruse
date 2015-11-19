
include <configuration.scad>
include <shapes.scad>

screw_offset_x = 8;
screw_offset_y = 6;
screw_mount_r = 4;
center_offset = 4.5;
height = center_offset + bearing_od + 1.5;

mount_width = bearing_h *2+22;
bearing_center =  bearing_od/2 + center_offset;


module bearingSlot() {
    // Bearing space
    rotate([0,90,0])translate([0,0,-1])cylinder(d=bearing_od+0.1, h=bearing_h + 1);
    // clearance
    rotate([0,90,0])cylinder(d=bearing_od - 2, h=bearing_h+3);
}

module bearingHolder() {
    bearing_mount_r = bearing_od/2 + 1.5;
    
    module fourCorners(x_offset = screw_offset_x) {
        translate([x_offset, 0 + screw_offset_y, 0])children();
        translate([-x_offset, 0 + screw_offset_y, 0])children();
        translate([x_offset, 0 - screw_offset_y, 0])children();
        translate([-x_offset, 0 - screw_offset_y, 0])children();
    }
 
      difference() {
            union() {
                 hull() {
                    fourCorners(mount_width/2- screw_mount_r)cylinder(r=screw_mount_r, h=height);
                }
           }
            // space for x bearings
            translate([-mount_width/2,0,bearing_center])bearingSlot();
            translate([mount_width/2,0,bearing_center])rotate([0,180,0])bearingSlot();
            // space for y bearings
            translate([0,0 + screw_offset_y + screw_mount_r,bearing_center-4])rotate([0,180,90])bearingSlot();
            translate([0,0 -( screw_offset_y + screw_mount_r),bearing_center - 4])rotate([0,0,90])bearingSlot();
            
            // x bearing axis
            translate([0,0,bearing_center])rotate([0,90,0])cylinder(d=4.5, h=mount_width, center=true);
            // y bearing axis
             translate([0,0,bearing_center-4])rotate([0,90,90])cylinder(d=4.5, h=mount_width, center=true);
            // screws
            fourCorners()cylinder(d=m3_dia, h=height + 1);
            // nuts
            fourCorners()cylinder(d=m3_nut_dia, h=m3_nut_height);
            // screw heads
            translate([0,0,height-2])fourCorners()cylinder(d=m3_nut_dia, h=2, $fn=6);
        }
        
        // print support
        color([1,0,0,1])fourCorners()translate([0, 0, m3_nut_height])cylinder(d=m3_dia, h=print_layer_height);        
        color([1,0,0,1])fourCorners()translate([0, 0, height-2-print_layer_height])cylinder(d=m3_dia, h=
print_layer_height);
}

module bearingHolderBottom() {
    difference() {
        bearingHolder();
        //slice top off
        translate([-mount_width/2,0-screw_offset_y-screw_mount_r,bearing_center])cube([mount_width,2*(screw_offset_x + screw_mount_r), bearing_center]);
        //bearing slot
        hull() {
            translate([0,0 -( screw_offset_y + screw_mount_r),bearing_center - 4])rotate([0,90,90])translate([0,0,-1])cylinder(d=bearing_od + 0.1, h=bearing_h + 1);
            translate([0,0 -( screw_offset_y + screw_mount_r),bearing_center])rotate([0,90,90])translate([0,0,-1])cylinder(d=bearing_od + 0.1, h=bearing_h + 1);
       }
    // clearance slot
       hull() {
           translate([0,0 -( screw_offset_y + screw_mount_r),bearing_center - 4])rotate([0,90,90])cylinder(d=bearing_od - 2, h=bearing_h+3);
            translate([0,0 -( screw_offset_y + screw_mount_r),bearing_center])rotate([0,90,90])cylinder(d=bearing_od - 2, h=bearing_h+3);
       }

        //bearing slot
        hull() {
            translate([0,0 +( screw_offset_y + screw_mount_r),bearing_center - 4])rotate([0,-90,90])translate([0,0,-1])cylinder(d=bearing_od, h=bearing_h + 1);
            translate([0,0 +( screw_offset_y + screw_mount_r),bearing_center])rotate([0,-90,90])translate([0,0,-1])cylinder(d=bearing_od, h=bearing_h + 1);
       }
    // clearance slot
       hull() {
           translate([0,0 +( screw_offset_y + screw_mount_r),bearing_center - 4])rotate([0,-90,90])cylinder(d=bearing_od - 2, h=bearing_h+3);
            translate([0,0 +( screw_offset_y + screw_mount_r),bearing_center])rotate([0,-90,90])cylinder(d=bearing_od - 2, h=bearing_h+3);
       }
       // axis slot
       hull() {
            translate([0,0,bearing_center])rotate([0,90,90])cylinder(d=4.5, h=mount_width, center=true);
            translate([0,0,bearing_center-4])rotate([0,90,90])cylinder(d=4.5, h=mount_width, center=true);
       }

   }
}

module bearingHolderTop() {
    difference() {
        translate([0,0,height])mirror([0,0,1])bearingHolder();
        // slice top off
        translate([-mount_width/2,-screw_offset_y-screw_mount_r,height-bearing_center])cube([mount_width,2*(screw_offset_x + screw_mount_r), bearing_center]);
   }
}

module 3DO0001_Bearing_Joint() {
    bearingHolderTop();
    translate([0,25,0])bearingHolderBottom();
}

//bearingHolder();
