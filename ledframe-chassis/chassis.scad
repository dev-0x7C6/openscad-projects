
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

default_vesa_distances = [50, 75, 100];

size=150;
height=5;
hole_size =5;
vesa_type=20;

module make_vesa_holes(size, h, hole_size) {
    union() {
        translate([-size/2, -size/2, 0])
            cylinder(h, r1=hole_size/2, r2=hole_size/2);
        translate([-size/2, size/2, 0])
            cylinder(h, r1=hole_size/2, r2=hole_size/2);
        translate([size/2, -size/2, 0])
            cylinder(h, r1=hole_size/2, r2=hole_size/2);
        translate([size/2, size/2, 0])
            cylinder(h, r1=hole_size/2, r2=hole_size/2);
    }
}


bluetooth_w = 38;
bluetooth_h = 16.5;

module vesa_base(size = 150, h = 5, distances = default_vesa_distances) {
    difference(){
        cube([size, size, h]);
        translate([size/2, size/2, 0])
            for (distance = distances)
                make_vesa_holes(distance, h, hole_size);
    }
}

module bluetooth_hc06_adapter(h = 5) {
    bluetooth_l = 38.20;
    bluetooth_w = 16.80;
    bluetooth_h = max(4.60, 5);

    translate(center ? [0, 0, 0] : [bluetooth_l/2, bluetooth_w/2, bluetooth_h/2])
        cube([bluetooth_l, bluetooth_w, bluetooth_h], center = true);
}

module avr_nano_pcb_adapter(h = 8.00, center = false) {
    board_l = 45.30;
    board_w = 18.30;
    board_h = max(h, 7.80);

    pin_rail_w = 2.00;
    pin_rail_h = 2.00;

    pcb_h = 1.60;

    usb_bump_h = pin_rail_h + pcb_h;
    usb_bump_l = 1.75;

    module usb_port() {
        h = 4.50;
        w = 8.00;

       translate([0, 0, board_h/2])
        difference() {
            cube([usb_bump_l, board_w, board_h], center = true);
            translate([0, 0, -(board_h/2 - h/2) + usb_bump_h])
            cube([usb_bump_l, w, h], center = true);
        }
    }

    translate(center ? [0, 0, 0] : [board_l/2, board_w/2, board_h/2])
        difference() {
            cube([board_l, board_w, board_h], center = true);
            // left pin rail
            translate([0, board_w/2 - pin_rail_w/2, -(board_h/2 - pin_rail_h/2)])
                cube([board_l, pin_rail_w, pin_rail_h], center = true);
            // right pin rail
            translate([0, -(board_w/2 - pin_rail_w/2), -(board_h/2 - pin_rail_h/2)])
                cube([board_l, pin_rail_w, pin_rail_h], center = true);
            // usb bump
            translate([-(board_l/2 - usb_bump_l/2), 0, -(board_h/2 - pin_rail_h/2)])
                cube([usb_bump_l, board_w, usb_bump_h], center = true);
            // usb port
            translate([-(board_l/2 - usb_bump_l/2), 0, -(board_h/2)])
                usb_port();
        }
}

module test_avr() {
    difference() {
        cube([45.30, 18.30 + 2, 9.6]);
        translate([0, 1, 0.6])
            avr_nano_pcb_adapter(9);
    }
}

module test_hc06() {
    difference() {
        cube([38.20 + 2, 16.80 + 2, 4]);
        translate([1, 1, 0.6])
            bluetooth_hc06_adapter(9);
    }
}

translate([0, -170, 0])
vesa_base();

test_hc06();

translate([0, 40, 0])
    test_avr();

/*
corner(40);
translate([50, -50, 0])
rotate([0, 0, -45])
    cube([100, 20, 2], center=true);

translate([50, -50, 0])
corner(40);

*/