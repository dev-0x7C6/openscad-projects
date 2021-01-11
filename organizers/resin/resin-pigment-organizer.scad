/// Bartłomiej Burdukiewicz

$fn = 64;

dia = 25.00 / 2;

// spaces
space = 3.00;
outer_space = 2.00;

//
height = 10.00;
base_height = 1.00;

/// grid size
grid = [5, 4];

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

difference() {
    linear_extrude(height)
        square([grid[0] * dia * 2 + grid[0] * space + outer_space * 2, grid[1] * dia * 2 + grid[1] * space + outer_space * 2], center = true);

    translate([0, 0, base_height])
        alg_next_each_other_y(grid[1], w = dia * 2 + space)
            alg_next_each_other_x(grid[0], w = dia * 2 + space)
                linear_extrude(height - base_height)
                    circle(dia);
}