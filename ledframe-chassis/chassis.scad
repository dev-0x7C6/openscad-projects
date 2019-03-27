$fn=32;

module m3_allen_screw(center = true) {
    tolerance = 0.4;
    head_w = 5.3 + tolerance;
    head_h = 3.0 + tolerance;
    width = 3.0 + tolerance;
    height = 20.0 + tolerance;

    translate(center ? [head_w/2, head_w/2, 0] : [0, 0, 0]);
        union() {
            color("red")
                cylinder(head_h, r1=head_w/2, r2=head_w/2);
            translate([0, 0, head_h])
                color("orange")
                    cylinder(height, r1=width/2, r2=width/2);
        }
}

module m3_allen_screw_rod(height = 10, tolerance = 0.4) {
    linear_extrude(height = height)
        circle(r = 1.5 + (tolerance / 2), $fn = 32);
}

module hex_screw_adapter(height, size, tolerance = 0.2) {
    linear_extrude(height)
        circle(r = (size / 2) + tolerance, $fn = 6);
}

module bolt_adapter(height, size, tolerance = 0.2, $fn = 32) {
    linear_extrude(height)
        circle(r = (size / 2) + tolerance);
}

module m3_allen_screw_test() {
    difference() {
        translate([-5, -5, 0])
            cube(10, 10, 10);
        m3_allen_screw();
    }
}

module power_plug(extended) {
    linear_extrude(height = 20 + extended)
        circle(r = 5.5);
}

module ws2812_plug(extended = 0, extended_base = 0) {
    linear_extrude(height = 8 + extended_base)
        square([7.2, 10.40], center = true);

    translate([0, 0, 8 + extended_base])
        linear_extrude(height = 11 + extended)
            square([5.40, 8.00], center = true);
}

module grid(x, y, width, height, center = true)
{
    x_space = width / (x - 1);
    y_space = height / (y - 1);
    translate(center ? [-(x_space * (x - 1))/2, -(y_space * (y - 1))/2, 0] : [0, 0, 0])
        for (i = [0:x_space:(x - 1) * x_space]) {
            for (j = [0:y_space:(y - 1) * y_space]) {
                translate([i, j, 0]) {
                    children();
                }
            }
        }
}

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

default_vesa_distances = [75, 100];
hole_size = 4;


module make_vesa_holes(size, h, hole_size, center = true) {
    grid(2, 2, size, size)
        linear_extrude(height = h)
            circle(r = hole_size / 2);
}

module vesa_base(size = 150, h = 5, distances = default_vesa_distances) {
    half = size/2;

    difference() {
        translate([0, 0, h/2])
            cube([size, size, h], center = true);

        for (distance = distances)
            make_vesa_holes(distance, h, hole_size);
   }
}


// default hc06 bluetooth size 
bluetooth_lenght = 38.20;
bluetooth_width = 16.80;
bluetooth_height_minimal = 4.60;

// default arduino nano size
arduino_lenght = 45.30;
arduino_width = 18.30;
arduino_height_minimal = 7.80;

module bluetooth_hc06_adapter(h = 5, center = true) {
    l = bluetooth_lenght;
    w = bluetooth_width;
    h_ = max(bluetooth_height_minimal, h);

    translate(center ? [0, 0, 0] : [l/2, w/2, h_/2])
        cube([l, w, h_], center = true);
}

module avr_nano_pcb_adapter(h = 8.00, center = false) {
    board_l = arduino_lenght;
    board_w = arduino_width;
    board_h = max(h, arduino_height_minimal);

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

module render_tests() {
    translate([0, -170, 0])
    vesa_base();

    test_hc06();

    translate([0, 40, 0])
        test_avr();
}

height = 10.0;
size = 120;

module ledframe_arm_socket(rotation, height = 8) {
    linear_extrude(height)
        rotate([0, 0, rotation])
            square([45, 14], center = true);
}

module ledframe_arm_socket_grid(size, height = 8) {
    i = size / 2;

    translate([-i, -i, 0])
        ledframe_arm_socket(45, height);

    translate([i, i, 0])
        ledframe_arm_socket(45, height);

    translate([i, -i, 0])
        ledframe_arm_socket(-45, height);

    translate([-i, i, 0])
        ledframe_arm_socket(-45, height);
}

module ledframe_chassis(height = height) {
    difference() {
        vesa_base(h = height, size = size);

        translate([0, 0, height/2 + 4.0])
            cube([30, 54, height], center = true);

        translate([0, -5, 0]) {
            translate([-size/2 + bluetooth_lenght/2 + (arduino_lenght - bluetooth_lenght), 20, height /2 + 0.4])
                bluetooth_hc06_adapter(h = height, center=true);

            translate([-size/2 + arduino_lenght/2, 0, height /2 + 0.4])
                avr_nano_pcb_adapter(height, center = true);

            translate([-size/2, -18, 5.6])
                rotate([90, 0, 90])
                    power_plug(55);
        }

        translate([-size/2.5, -size/2 - 8, 6.5])
            rotate([0, 90, 45])
                ws2812_plug(30, 16);

        translate([0, 0, height - 5])
            ledframe_arm_socket_grid(100, height = 5);

        grid(2, 2, 87.5, 87.5)
            m3_allen_screw();

        grid(2, 2, 20, 65)
            m3_allen_screw();
    }
}

module ledframe_screw_adapter(height = 3.0, base_height = 1.0, screw_size = 6, bolt_size = 3, tolerance = 0.2) {
    bolt_adapter(base_height, bolt_size, tolerance);
    translate([0, 0, base_height])
        hex_screw_adapter(height - base_height, screw_size, tolerance);
}

module ledframe_m3_screw_adapter(height = 3.0, base_height = 1.0, tolerance = 0.2) {
    ledframe_screw_adapter(height = height, base_height = base_height, screw_size = 6.00, bolt_size = 3.00, tolerance = tolerance);
}

module ledframe_chassis_enclosure(height = 4) {
    difference() {
        vesa_base(h = height, size = size);

        grid(2, 2, 87.5, 87.5)
            ledframe_m3_screw_adapter(height, base_height = 1.6);

        grid(2, 2, 20, 65)
            ledframe_m3_screw_adapter(height, base_height = 1.6);
    }
}

module ledframe_arm(height = 5, height_mount = 5, arm_width = 13.80, arm_length = 260.00, angle = 25.0) {
    difference() {
        union() {
            translate([30/2 + (tan(angle) * arm_width) - 1.0, -arm_width / 2, 0])
                rotate([0, 0, angle])
                    difference() {
                        linear_extrude(height)
                            square([arm_length, arm_width]);
                        translate([arm_length - 8, arm_width/2, 0])
                            ledframe_m3_screw_adapter(height, base_height = 1.6);
                        translate([arm_length/2, arm_width/2 - 0.75, 0])
                            grid(6, 2, arm_length * 0.8, arm_width * 0.6)
                                linear_extrude(height)
                                    square([2.75, 1.5]);
                    }

            linear_extrude(height_mount)
                union() {
                    translate([15, -arm_width / 2, 0])
                        polygon([[0,0], [tan(angle) * arm_width, 0], [0, arm_width]]);
                    square([30, arm_width], center = true);
                }
        }

        linear_extrude(height_mount)
            translate([-2, 0, 0])
                union() {
                    circle(r = 1.7);

                    translate([8.5, 0, 0])
                            circle(r = hole_size / 2);

                    translate([-8.5, 0, 0])
                            circle(r = hole_size / 2);
                }
    }
}





translate([0, size + 20, 0])
    ledframe_arm();

ledframe_chassis();

translate([size + 20, 0, 0])
  ledframe_chassis_enclosure();