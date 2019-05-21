$fn = 128;

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

module lion_enclosure(height = 24.00, wall = 4.00, base_height = 2.20) {
    r = 18.50;
    workspace = [r, 72.00];
    base = [r + (wall * 2), 72.00 + (wall * 2)];
    
    ziptie_w = 4.00;

    difference() { 
        linear_extrude(height)
            square(base, center = true);
        
    translate([0, workspace[1] / 2, base_height + r / 2])
        rotate([90, 0, 00])
            linear_extrude(workspace[1])
                circle(r = r / 2);
        
        translate([0, 0, base_height + r / 2])
            linear_extrude(height - base_height - r / 2)
                square(workspace, center = true);
        
        translate([0, 0, height - 5.50])
            linear_extrude(2.00)
                repeat_y(6, workspace[1] - (wall * 2) - ziptie_w / 2 - 10)
                    square([base[0], 4.00], center = true);
    }
}

base_size = [80.00, 56.00, 16.00];
electronics_workspace = [58.00, 28.00, 8.00];
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

module stage1_add_bottom_led_guide(size) {
    difference() {
        stage0_plainbase(size);
        linear_extrude(2.60)
            square([size[0], 14.00], center = true);
    }
}

module stage2_add_workspace(size) {
    difference() {
        stage1_add_bottom_led_guide(size);
        translate([0, 0, size[2] - electronics_workspace[2]])
            linear_extrude(electronics_workspace[2])
                square([electronics_workspace[0], electronics_workspace[1]], center = true);
        
        translate([size[0] / 2, 0, size[2] - electronics_workspace[2] - 4])
            linear_extrude(4)
                square([size[0], 7.00], center = true);
        
        translate([size[0] / 2, 0, size[2] - electronics_workspace[2] - 6])
            linear_extrude(6)
                square([7.00, 7.00], center = true);
        
        translate([7.00/2, -electronics_workspace[1] / 4, size[2] - electronics_workspace[2] - 4])
            linear_extrude(4)
                square([7.00, electronics_workspace[1] / 2], center = true);
    }
}

module stage3_add_dc2dc_converter(size) {
    l = dc2dc_converter_workspace[0];
    w = dc2dc_converter_workspace[1];
    h = dc2dc_converter_workspace[2];
    
    difference() {
        stage2_add_workspace(size);
        translate([0, -electronics_workspace[1]/2 - (w/4), size[2] - h])
            linear_extrude(h)
                square([l, w], center = true);
        
        translate([-size[0] / 2, electronics_workspace[1] / 2 - power_plug_slot_r, size[2] / 2 + 1.00])
            rotate([90, 0, 90])
                power_plug(0);
        
        translate([-size[0] / 2, -electronics_workspace[1] / 2 + power_switch_slot[0] / 2, size[2] / 2 + 1.00])
            rotate([90, 0, 90])
                power_switch(0);
 
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

//lion_enclosure();

stage5_add_dc_wires(base_size);

