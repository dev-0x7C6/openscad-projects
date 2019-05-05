module box(workspace, base_height, wall_thickness) {
    wall = wall_thickness * 2.00;

    difference() {
        linear_extrude(workspace[2] + base_height)
            square([workspace[0] + wall, workspace[1] + wall], center = true);
        
        translate([0, 0, base_height])
            linear_extrude(workspace[2])
                square([workspace[0], workspace[1]], center = true);
    }
    
}

box([200.00, 60.00, 70.00], 2.00, 1.20); // sponge kitchen holder

translate([0.00, 80.00, 0.00])
    box([230.00, 50.00, 120.00], 2.00, 1.20); // foil kitchen holder