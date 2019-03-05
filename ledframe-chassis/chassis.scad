
module corner(size) {
    hole_h = 1;
    hole_w = 4;
    hole_distance = 16;
    
    half_size = size/2;
    quat_size = size/4;
    
    module block(holes) {
        difference() {
            cube([half_size, half_size, 2], center=true);
            if (holes) {
                union() {
                    translate([-hole_distance/2, 0, 0])
                        cube([hole_h, hole_w, 2], center=true);
                    translate([hole_distance/2, 0, 0])
                        cube([hole_h, hole_w, 2], center=true);
                }
            }
        }
    }
    
    translate([-half_size, -half_size, 0])
    union() {
        translate([quat_size + half_size, quat_size + half_size, 0])
            rotate([0, 0, 90])
                block(true);
        translate([quat_size, quat_size, 0])
            block(true);
        translate([quat_size + half_size, quat_size, 0])
            block(false);
    }
}

$fn=16;


size=150;
height=5;
hole_size =5;
vesa_type=20;

module make_vesa_holes(size, hole_size) {
    union() {
        translate([-size/2, -size/2, 0])
            cylinder(height, r1=hole_size/2, r2=hole_size/2);
        translate([-size/2, size/2, 0])
            cylinder(height, r1=hole_size/2, r2=hole_size/2);
        translate([size/2, -size/2, 0])
            cylinder(height, r1=hole_size/2, r2=hole_size/2);
        translate([size/2, size/2, 0])
            cylinder(height, r1=hole_size/2, r2=hole_size/2);
    }
}


bluetooth_w = 38;
bluetooth_h = 16.5;

module vesa_base() {
    difference(){
        translate([-bluetooth_w/2, -bluetooth_h/2, 1])
            cube([bluetooth_w, bluetooth_h, height]);
        for (distance = [50, 75, 100])
            make_vesa_holes(distance, hole_size);
    }
}


module avr_nano_pcb_adapter() {
    translate([0.00, 2.00, 0.00])
        cube([43.60, 14.30, 3.60]);
    translate([0, 0, 3.60])
        cube([43.60, 18.30, 6.50]);
}

difference() {
    cube([46, 22, 6]);
        translate([0,2.00,0.6])
            avr_nano_pcb_adapter();
}


/*
corner(40);
translate([50, -50, 0])
rotate([0, 0, -45])
    cube([100, 20, 2], center=true);

translate([50, -50, 0])
corner(40);

*/