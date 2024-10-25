$fn = 64;

r_tolerance = 0.15;
r = 1.50;

r_spacing_rear = 1.50;
r_spacing_front = 1.75;

r_spaceing = r_spacing_front; // 1.75


module base(l = 50, w = 8, r = 3) {
    minkowski() {
        square([l - r * 2, w - r * 2]);
        circle(r);
    }
}

module mount_grid(grid = [4, 2], corner = 2, r_override = 0.0) {
    d = r * 2;
    spaceing = d * r_spaceing;
    
    
    difference() {
        s_x = grid[0] - 1;
        s_y = grid[1] - 1;
        
        base_x = s_x * spaceing + d + r_tolerance * 2;
        base_y = s_y * spaceing + d + r_tolerance * 2; 
 
        minkowski() {
            square([base_x, base_y], center = true);
            circle(corner);
        }

        translate([-s_x * spaceing / 2, -s_y * spaceing / 2, 0])
        for (step_y = [0:1:s_y]) {
            for (step_x = [0:1:s_x]) {
                
                x = step_x * spaceing;
                y = step_y * spaceing;
                r = r + r_tolerance;
           
                translate([x, y, 0])
                    circle(r_override == 0.00 ? r : r_override);
            }
        }
    }
}

linear_extrude(6)
    mount_grid([5, 2]);

