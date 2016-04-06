include <configuration.scad>
include <shapes.scad>

triangle_base = 38;
mount_width = 30;
bearing_mount_r = bearing_od/2 + 1.5;
mount_len = triangle_base + bearing_mount_r;
screw_head_depth = 9 - m4_nut_height;

module atcHub() {
    cone_top_dia = 40;
    cone_bottom_dia = cone_top_dia-tan(9.5)*cone_top_dia;
    hub_h = 19;
    side_distance = 25.5;
    hexagon_dia = side_distance/sin(60);
    fan_opening_dia = 21;
    magnet_height = 6;
    magnet_dia=6.3;
    magnet_mount_dia=9.5;

    module threeSides() {
        children();
        rotate([0,0,120])children();
        rotate([0,0,240])children();
    }

    module bearingHolder(with_connector = true, nut_depth = 3.5, hex_nut = true) {
        module threeBolts() {
            translate([0, triangle_base + 4, 0])children();
            translate([5, triangle_base - 4, 0])children();
            translate([-5, triangle_base - 4, 0])children();
        }
        
        difference() {
            union() {
                // end block
                translate([-mount_width/2,mount_len - 13,0])roundedCube([mount_width, 13, 13]);
                // screw extension
//                threeBolts()cylinder(d=m3_nut_dia + 2, h=8);
//                #translate([-mount_width/2,mount_len-6.5,bearing_mount_r])cap();
                if (with_connector) {
                    // connector
                    translate([-7,side_distance-1,0])roundedCube([14, mount_len-side_distance+1, 2*bearing_mount_r]);
                    translate([-mount_width/2,mount_len - m4_dia,6.5])rotate([90,0,0])roundedBox([30, 6.5,m4_dia]);
 
                }
            }
            if (!with_connector) {
                // Make space for magnet mount 
                translate([0,27,0])cylinder(d=magnet_mount_dia, h=hub_h);
            }
            // Nut slots
            hull() {
                translate([mount_width/2-m4_nut_height-screw_head_depth,mount_len-6.5,bearing_mount_r])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height);
                translate([mount_width/2-m4_nut_height-screw_head_depth,mount_len-6.5,13])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height);
                translate([-mount_width/2+screw_head_depth,mount_len-6.5,bearing_mount_r])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height);
                translate([-mount_width/2+screw_head_depth,mount_len-6.5,13])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height);
            }
//            hull() {
//                translate([-mount_width/2+8-m4_nut_height,mount_len-6.5,0])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height, $fn=6);
//                translate([-mount_width/2+8-m4_nut_height,mount_len-6.5,13])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height, $fn=6);
//            }
            // bearing axis
            hull() {
                translate([0,triangle_base,bearing_mount_r])rotate([0,90,0])cylinder(d=m4_dia, h=mount_width, center=true);
                translate([0,triangle_base,13])rotate([0,90,0])cylinder(d=m4_dia, h=mount_width, center=true);
            }
            // Extra hole
            translate([0,triangle_base,bearing_mount_r])rotate([0,0,0])cylinder(d=m3_dia, h=mount_width, center=true);
            

       }
     }

    module sideExclusions() {
        edge_dia = 4;
        nut_depth = 3.5;
        slice_off = 2;
        rotate([90,0,60])translate([0,4,-side_distance]) {
            // fan opening
            cylinder(d=fan_opening_dia, h=30, center=true);
                // Rounded edge on fan-opening
                translate([0,0,slice_off])rotate_extrude() {
                    square([(fan_opening_dia-0.3)/2, edge_dia]);
                    translate([(fan_opening_dia-0.3)/2,0,0]) {
                        translate([0,-edge_dia])square([edge_dia,edge_dia]);
                        inverseQuarterCircle(edge_dia);
                }
            }
           // fan screw holes
            translate([12,12,0])cylinder(d=m3_dia, h=30, center=true);
            translate([-12,12,0])cylinder(d=m3_dia, h=30, center=true);
            // fan nut slots
            hull() {
                translate([12,12,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
                translate([12,hub_h,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
            }
            hull() {
                translate([-12,12,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
                translate([-12,hub_h,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
            }
       }
}
    
 
    // body
    difference() {
        union() {
            difference() {
                union() {
                    // body
                    cylinder(d=hexagon_dia*2, h=hub_h, $fn=6);
                    // Bearing holders
                    threeSides()bearingHolder();
                    // Magnet mounts 
                    threeSides()translate([0,27,0])roundedCylinder(d=magnet_mount_dia, h=hub_h);
               }
                // Make holes for fans, screws, nuts
                threeSides()sideExclusions();
            }
            // create bottom ridge
            cylinder(d1=hexagon_dia*2-4, d2=hexagon_dia*2-9,h=1.5, $fn=6);
        }
        // slice 2mm of side off
        threeSides()rotate([90,0,60])translate([0,4,-side_distance])translate([-side_distance/tan(60)-2,-side_distance/tan(60)-2,-1])cube([2*side_distance/tan(60)+4, 2*side_distance/tan(60)+4, 1+2]);           
        // remove cone
        cylinder(d1=cone_bottom_dia, d2=cone_top_dia, h=hub_h);
        // remove bottom inside edge
        cylinder(d1=cone_bottom_dia+1, d2=cone_bottom_dia-1,h=2);
        // remove top inside edge
        translate([0,0,hub_h-1.5])cylinder(d1=cone_top_dia-1, d2=cone_top_dia+1,h=1.5);
        // Magnet holes
        threeSides()translate([0,27,0]) {
            cylinder(d=m3_dia, h=hub_h);
            translate([0,0,hub_h-magnet_height])cylinder(d=magnet_dia, h=magnet_height);
        }
    }
 
}

module cap() {
    difference() {
        union() {
            // center down
            translate([screw_head_depth+m4_nut_height,0,0])rotate([0,90,0])cylinder(d=m4_nut_dia, h=mount_width-2*screw_head_depth-2*m4_nut_height);
            // center fill
            translate([screw_head_depth,- m4_nut_dia/2,2.5])cube([mount_width-2*screw_head_depth, m4_nut_dia, 4]);
            translate([screw_head_depth+m4_nut_height,- m4_nut_dia/2,0])cube([mount_width-2*screw_head_depth-2*m4_nut_height, m4_nut_dia, 4]);
            // axis fill
            translate([0,- m4_dia/2,m4_dia/2])cube([mount_width, m4_dia, 6.5-m4_dia/2]);
        }
        // head holes
        translate([screw_head_depth-1,0,0])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height+1);
        translate([mount_width-screw_head_depth-m4_nut_height,0,0])rotate([0,90,0])cylinder(d=m4_nut_dia, h=m4_nut_height+1);
        // mount screw
        translate([mount_width/2,0,-6])cylinder(d=m3_dia, h=20);
        translate([mount_width/2,0,6.5-1.5])cylinder(d=m3_nut_dia, h=10, $fn=6);
    }
    // print support
    color([1,0,0])translate([mount_width/2,0,6.5-1.5-print_layer_height])cylinder(d=m3_nut_dia, h=print_layer_height, $fn=6);
}
module 3DO0004S_ATC_Hub_End_Effector_M4() {
    atcHub();
}
//$fa=3;
//$fs=0.3;
//atcHub();
//translate([40,0,6.5])rotate([180,0,0])cap();
//atcHubCaps();