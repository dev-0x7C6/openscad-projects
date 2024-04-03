$fn = 64;

lion_dia = 18.6;


module lion_contact() {
    linear_extrude(0.80)
        union() {
            hull() {
                translate([lion_dia, 0, 0])
                    circle(r = lion_dia / 2);
                circle(r = lion_dia / 2);
            }
            
            square([lion_dia * 2, 5.10], center = true);
        }
        
    linear_extrude(2.80)
        union() {
            hull() {
                translate([lion_dia + 5.0, 0, 0])
                    circle(r = 10.0 / 2);
                circle(r = 10.0 / 2);
            }
        }
}

difference() {
    linear_extrude(3)
        square([20, 20], center = true);
    translate([0, 0, 1])
        lion_contact();
}

/*
lion_battery_diameter = 18.50;
lion_battery_wall_size = 2.00;

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

lion_enclosure();

module lion_enclosure_lid() {
    linear_extrude(2)
        square(lion_base, center = true);

    translate([0, 0, 2])
        linear_extrude(1.40)
            square([lion_workspace[0] - 0.50, lion_workspace[1] - 0.50], center = true);
}*/