$fn = 128;

lid_h = 3;
lid_r = 95.00 / 2.00;

lid_wall_height = 3.00;
lid_wall_thickness = 1.20;
lid_solid_base_height = 0.80;

difference() {
    linear_extrude(lid_wall_height)
        circle(r = lid_r + (lid_wall_thickness / 2), center = true);
    
    translate([0, 0, lid_solid_base_height])
        linear_extrude(lid_wall_height - lid_solid_base_height)
        circle(r = lid_r, center = true);
}
