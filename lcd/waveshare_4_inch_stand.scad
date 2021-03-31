$fn = 64;

base = [105.00, 80.00];

base_border = 6.00;
border = base_border;

dia_mount = 5.60 / 2;

difference() {
    union() {
        linear_extrude(3)
            difference() {
                square([base[0] + base_border * 2, base[1]], center = true);
                square([base[0], base[1] - base_border * 2], center = true);
            }

        translate([0, base[1] / 2 * 0.5, 4])
            rotate([-75, 0, 0])
                linear_extrude(4)
                    difference() {
                        square([base[0] + border * 2, 12], center = true);
                        translate([base[0] / 2 - dia_mount, -2.5 , 0])
                            circle(dia_mount);
                        
                        translate([-base[0] / 2 + dia_mount, -2.5 , 0])
                            circle(dia_mount);
                    }
    }
    
    translate([0, 0, -5])
        linear_extrude(5)
            square([base[0] + base_border * 2, base[1]], center = true);
}
