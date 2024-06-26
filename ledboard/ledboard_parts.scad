$fn = 32;

// Power plug module

power_plug_slot_r = 5.5;
power_plug_rant_r = 6.30;

module power_plug() {
    union() {
        linear_extrude(2.00)
            circle(r = power_plug_rant_r);

        translate([0, 0, 2.00])
            linear_extrude(20.00)
                circle(r = power_plug_slot_r);
    }
}

//

// Power switch module

power_switch_rant = [15.00, 11.00, 5.00];
power_switch_slot = [14.50, 9.00, 17.00];

module power_switch() {
    linear_extrude(power_switch_rant[2])
        square([power_switch_rant[0], power_switch_rant[1]], center = true);
    translate([0.00, 0.00, power_switch_rant[2]])
        linear_extrude(power_switch_slot[2])
            square([power_switch_slot[0], power_switch_slot[1]], center = true);
}

//

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

module repeat_y(times, width, center = true) {
    times = times - 1;
    for (i = [0:1:times])
        translate([0, i * (width / times) - (center ? width / 2 : 0), 0])
            children();
}

lion_battery_diameter = 18.50;
lion_battery_wall_size = 4.00;

lion_workspace = [lion_battery_diameter, 72.00];
lion_base = [lion_battery_diameter + (lion_battery_wall_size * 2), 72.00 + (lion_battery_wall_size * 2)];

module lion_enclosure(height = 25.00, base_height = 3.00) {
    ziptie_w = 4.00;

    difference() { 
        linear_extrude(height)
            square(lion_base, center = true);

    translate([0, lion_workspace[1] / 2, base_height + lion_battery_diameter / 2])
        rotate([90, 0, 00])
            linear_extrude(lion_workspace[1])
                circle(r = lion_battery_diameter / 2);

        translate([0, 0, base_height + lion_battery_diameter / 2])
            linear_extrude(height - base_height - lion_battery_diameter / 2)
                square(lion_workspace, center = true);

        translate([0, 0, height - 5.50])
            linear_extrude(2.00)
                repeat_y(6, lion_workspace[1] - (lion_battery_wall_size * 2) - ziptie_w / 2 - 10)
                    square([lion_base[0], 4.00], center = true);
    }
}

module lion_enclosure_lid() {
    linear_extrude(2)
        square(lion_base, center = true);

    translate([0, 0, 2])
        linear_extrude(1.40)
            square([lion_workspace[0] - 0.50, lion_workspace[1] - 0.50], center = true);
}

base_size = [80.00, 56.00, 18.00];
electronics_workspace = [58.00, 28.00, 7.00];
dc2dc_converter_workspace = [25.00, 5.00, 13.00];

module stage0_plainbase(size) {
    linear_extrude(size[2])
    difference() {
        square([size[0], size[1]], center = true);
        translate([5.00, 0, 0])
            grid(2, 2, 53.00, 41.00)
                circle(r = 2.75);
    }
}

module stage1_add_bottom_led_guide(size, led_tunel_height = 3.00, led_tunel_width = 14.00) {   
    difference() {
        stage0_plainbase(size);
        linear_extrude(led_tunel_height)
            square([size[0], led_tunel_width], center = true);
    }
}

module stage2_add_workspace(size) {
    difference() {
        stage1_add_bottom_led_guide(size);
        translate([0, 0, size[2] - electronics_workspace[2]])
            linear_extrude(electronics_workspace[2])
                square([electronics_workspace[0], electronics_workspace[1]], center = true);

        translate([-8, 0, size[2] - electronics_workspace[2] - 4.80])
            linear_extrude(6)
                square([20.00, 14.00], center = true);

        translate([size[0] / 2, 0, size[2] - electronics_workspace[2] - 4])
            linear_extrude(4)
                square([size[0], 7.00], center = true);

        translate([size[0] / 2, 0, size[2] - electronics_workspace[2] - 4])
            linear_extrude(4)
                square([size[0], 7.00], center = true);

        translate([size[0] / 2, 0, size[2] - electronics_workspace[2] - 10]) //todo
            linear_extrude(6)
                square([7.00, 7.00], center = true);
    }
}

module stage3_add_dc2dc_converter(size) {
    l = dc2dc_converter_workspace[0];
    w = dc2dc_converter_workspace[1];
    h = dc2dc_converter_workspace[2];

    difference() {
        stage2_add_workspace(size);

        translate([-size[0] / 2, electronics_workspace[1] / 2 - power_plug_slot_r, size[2] / 2 + 1.00])
            rotate([90, 0, 90])
                power_plug();

        translate([-size[0] / 2, -electronics_workspace[1] / 2 + power_switch_slot[0] / 2, size[2] / 2 + 1.00])
            rotate([90, 0, 90])
                power_switch();

     }
}

module stage4_add_lion_enclosures(size) {
    union() {
        stage3_add_dc2dc_converter(size);

        translate([0, -base_size[1] / 2 - (18.50 + (4.00 * 2)) / 2, 0])
            rotate([0, 0, 90])
                lion_enclosure();

        translate([0, base_size[1] / 2 + (18.50 + (4.00 * 2)) / 2, 0])
            rotate([0, 0, 90])
                lion_enclosure();
    }
}


module stage5_add_dc_wires(size) {
    difference() {
        stage4_add_lion_enclosures(size);

        translate([10.5, 0, size[2] - 4])
            linear_extrude(7)
                square([4.00, size[1] + 10], center = true);

        translate([-10.5, 0, size[2] - 4])
            linear_extrude(7)
                square([4.00, size[1] + 10], center = true);
    }
}

module final_skateboard_power_base() {
    stage5_add_dc_wires(base_size);

    translate([75, 0, 0])
        lion_enclosure_lid();
}

final_skateboard_power_base();


// default arduino nano size
arduino_lenght = 45.80;
arduino_width = 18.30;
arduino_height_minimal = 7.80;

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

translate([0, 100, 0]) {
    difference() {
        stage1_add_bottom_led_guide(base_size);
        translate([base_size[0] / 2 - arduino_lenght / 2 + 0.01, 0, base_size[2] - 10 / 2])
            mirror([1, 0, 0])
                avr_nano_pcb_adapter(10, center = true);
        translate([(-base_size[0]/2), 0, base_size[2] - 4.00])
            linear_extrude(4.00)
                square([base_size[0], 7.00], center = true);
    }
}

translate([0, -100, 0]) {
    stage0_plainbase([base_size[0], base_size[1], 1.00]);
}
