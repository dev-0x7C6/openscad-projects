$fn = 128;

h = 8.00;

prizm_s = 22.05;
prizm_h = 4.00;

module circle_with_hole(r, size = 1.00) {
    difference() {
        circle(r + size * 2);
        circle(r);
    }
}

module square_with_hole(s, size = 1.00) {
    difference() {
        square(s + size * 2, center = true);
        square(s, center = true);
    }
}

module convoy_prism_adapter() {
    linear_extrude(h)
        circle_with_hole(12.10);

    translate([0, 0, h]) {
        linear_extrude(1.00) {
            difference() {
                square(prizm_s, center = true);
                circle(12.10);
            }
        }
        
        linear_extrude(prizm_h + 1.00)
            square_with_hole(prizm_s, 1.2);
    }
}

translate([0, 40, 0])
convoy_prism_adapter();

module xyz() {
    linear_extrude(prizm_h) {
            square_with_hole(prizm_s, 1.2);
    }

    translate([0, 0, prizm_h])
        linear_extrude(0.4)
            square_with_hole(prizm_s - 1.2, 1.2 * 4);
}

union() {
    xyz();
        translate([0, 0, (prizm_h + 0.39) * 2])
            rotate([0, 0, 45])
                mirror([0, 0, 1])
                    xyz();
}


module circle_with_hole_2(r1, r2) {
    difference() {
        circle(r1);
        circle(r2);
    }
}

translate([0, 200, 0])
    union() {
        linear_extrude(4)
            circle_with_hole(12.10);
        linear_extrude(1)
            circle_with_hole_2(75, 12.10);
    }
