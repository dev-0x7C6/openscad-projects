
$fn = 64;

line_1st = 30.00;

bar = [36.00, 154.00, 10.00];

hole_y_pos = 24.0;

hole_1st_line = 30.00;
hole_2nd_line = hole_1st_line + 53.00;
hole_3rd_line = hole_2nd_line + 33.00;

left_adapter_height = 3.00;


bar_space = 2.5;

difference() {
    linear_extrude(bar[2]) {
        difference() {
            square([bar[0], bar[1]]);
            translate([hole_y_pos, hole_1st_line])
                circle(2);
            translate([hole_y_pos, hole_2nd_line])
                circle(2);
        }
    }
    
    translate([0, 30.00 - 11.00, bar[2] - left_adapter_height])
        linear_extrude(left_adapter_height)
            square([bar[0], 22.00]);
    
    translate([0, hole_3rd_line, bar[2] - bar_space])
        linear_extrude(bar_space)
            square([bar[0], bar_space * 2]);
    
    translate([0, hole_3rd_line + bar_space, bar[2] - bar_space])
        rotate([90, 90, 90])
                cylinder(bar[0], r1 = bar_space, r2 = bar_space);
}