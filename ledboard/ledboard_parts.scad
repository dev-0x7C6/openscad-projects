module grid(x, y, width, height, center = true)
{
    x_space = width / (x - 1);
    y_space = height / (y - 1);
    translate(center ? [-(x_space * (x - 1))/2, -(y_space * (y - 1))/2, 0] : [0, 0, 0])
        for (i = [0:x_space:(x - 1) * x_space]) {
            for (j = [0:y_space:(y - 1) * y_space]) {
                translate([i, j, 0]) {
                    children();
                }
            }
        }
}

module repeat_y(times, width, center = true) {
    times = times - 1;
    for (i = [0:1:times])
        translate([0, i * (width / times) - (center ? width / 2 : 0), 0])
            children();
}

module lion_enclosure(height = 24.00, wall = 4.00, base_height = 2.20) {
    workspace = [18.50, 72.00];
    base = [18.50 + (wall * 2), 72.00 + (wall * 2)];
    
    ziptie_w = 4.00;
    
    difference() { 
        linear_extrude(height)
            square(base, center = true);
        
        translate([0, 0, base_height])
            linear_extrude(height - base_height)
                square(workspace, center = true);
        
        translate([0, 0, height - 6.00])
            linear_extrude(2.00)
                repeat_y(5, workspace[1] - (wall * 2) - ziptie_w / 2)
                    square([base[0], 4.00], center = true);
    }
}

lion_enclosure();