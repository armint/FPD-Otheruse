include <configuration.scad>
include <shapes.scad>
include <threads.scad>

module atcHub() {
    triangle_base = 38;
    cone_top_dia = 38;
    cone_bottom_dia = cone_top_dia-tan(9.5)*cone_top_dia;
    echo("Cone bottom diameter: ", cone_bottom_dia);
 
    triangle_h = 12.5;
    hub_h = 19;
    triangle_corner_dia = 6;
    side_distance = 25.5;
    hexagon_dia = side_distance/sin(60);
    fan_opening_dia = 21;
    fan_screw_dist = 12;
    mount_width = 30;
    bearing_mount_r = bearing_od/2 + 1.5;
    mount_len = triangle_base + bearing_mount_r;
    opening = bearing_od - 2;
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
                if (with_connector) {
                    // connector
                    translate([-7,side_distance-1,0])roundedCube([14, mount_len-side_distance+1, 2*bearing_mount_r]);
                }
            }
            if (!with_connector) {
                // Make space for magnet mount 
                translate([0,27,0])cylinder(d=magnet_mount_dia, h=hub_h);
            }
             // M4 rod axis
            translate([0,triangle_base,bearing_mount_r])rotate([0,90,0])cylinder(d=m4_dia, h=mount_width+2, center=true);
            // Extra hole
            translate([0,triangle_base,bearing_mount_r])rotate([0,0,0])cylinder(d=m3_dia, h=mount_width, center=true);
            

       }
     }

    module sideExclusions() {
        edge_dia = 4;
        nut_depth = 6;
        slice_off = 2;
        rotate([90,0,60])translate([0,4,-side_distance]) {
            // slots for tool bracket
            translate([0,6,-2])linear_extrude(height=4, scale=0.95)square([22,hub_h+2], center = true);
            for (i=[1,-1]) {
                // screw holes
                translate([i*12,0,-1])cylinder(d=m3_dia, h=20);
                // nut slots
                hull() {
                    translate([i*12,0,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
                    translate([i*12,-4,nut_depth])rotate([0,0,30])cylinder(d=m3_nut_dia, h=m3_nut_height, $fn=6);
                }
            }
       }
    }
    
 
    // body
    difference() {
        union() {
            // body
            cylinder(d=hexagon_dia*2, h=hub_h, $fn=6);
            // Bearing holders
            threeSides()bearingHolder();
            // Magnet mounts 
            threeSides()translate([0,27,0])roundedCylinder(d=magnet_mount_dia, h=hub_h);
            // create bottom ridge
            cylinder(d1=hexagon_dia*2-4, d2=hexagon_dia*2-9,h=1.5, $fn=6);
        }
//        // slice 2mm of side off
//        threeSides()rotate([90,0,60])translate([0,4,-side_distance])translate([-side_distance/tan(60)-2,-side_distance/tan(60)-2,-1])cube([2*side_distance/tan(60)+4, 2*side_distance/tan(60)+4, 1+2]);           
        // remove cone
        cylinder(d1=cone_bottom_dia, d2=cone_top_dia, h=hub_h);
        // create M36 thread
        metric_thread (diameter=36, pitch=3, length=hub_h, internal= true, angle=45);
        // remove bottom inside edge
        cylinder(d1=cone_bottom_dia+1, d2=cone_bottom_dia-1,h=2);
        // remove top inside edge
        translate([0,0,hub_h-1.5])cylinder(d1=cone_top_dia-1, d2=cone_top_dia+1,h=1.5);
        // Magnet holes
        threeSides()translate([0,27,0]) {
            cylinder(d=m3_dia, h=hub_h);
            translate([0,0,hub_h-magnet_height])cylinder(d=magnet_dia, h=magnet_height);
        }
         // Make holes for fans, screws, nuts
        threeSides()sideExclusions();
   }
 
}


module 3DO0014_ATC_Hub_End_Effector_M4_M36() {
    atcHub();
}
$fa=3;
$fs=0.3;
atcHub();
//atcHubCaps();