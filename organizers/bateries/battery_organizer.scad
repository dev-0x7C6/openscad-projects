/// Bartłomiej Burdukiewicz

$fn = 64;

nozzle = 0.4;
wall_thickness = nozzle * 4;
base_h = 1.00;


/// 3xA battery length: 45.00mm
/// 2xA battery length: 51.00mm
battery_length = 51.00; 

/// 3xA battery dia: 5.30mm
/// 2xA battery dia: 7.30mm
dia = 7.30;

/// grid size
grid = [10, 1];

$fn = 64;

module lying_cylinder(w = 1.00, r = 5.00, center = true) {
    translate([0, 0, r])
        rotate([90, 0, 0])
            cylinder(w, r, r, center);
}

module alg_next_each_other_x(count = 2, w = 10.00, center = true) {
    translate([center ? -w * count / 2 + w/2 : 0, 0, 0])
        for (offset = [0:count - 1])
            translate([offset * w, 0, 0])
                children();
}

module alg_next_each_other_y(count = 2, w = 10.00, center = true) {
    translate([0, center ? -w * count / 2 + w/2 : 0, 0])
        for (offset = [0:count - 1])
            translate([0, offset * w, 0])
                children();
}

module section(count) {
    difference() {
        linear_extrude(dia + base_h)
            square([count * dia * 2 + wall_thickness * 2, battery_length + wall_thickness * 2], center = true);

        translate([0, 0, base_h])
            alg_next_each_other_x(count, dia * 2)
                lying_cylinder(battery_length, dia, true);

        translate([0, 0, dia + base_h - 2])
            linear_extrude(2)
                square([count * dia * 2, battery_length], center = true);
    }
}

alg_next_each_other_y(grid[1], w = battery_length + wall_thickness)
    section(grid[0]);