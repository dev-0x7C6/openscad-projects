$fn = 128;

lid_r = 96.00 / 2.00;

lid_wall_height = 6.00;
lid_wall_thickness = 1.20;
lid_solid_base_height = 0.60;

difference() {
    linear_extrude(lid_wall_height)
        circle(r = lid_r + lid_wall_thickness, center = true);
    
    translate([0, 0, lid_solid_base_height])
        linear_extrude(lid_wall_height - lid_solid_base_height)
        circle(r = lid_r, center = true);
}
