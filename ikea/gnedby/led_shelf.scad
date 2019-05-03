$fn = 64;
size = [150.00, 162.00];


height = 13.60;

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



//rotate([0, 90, 0])
    //circle(r = 4.00);

module bolt_hex_socket(height, size, tolerance = 0.2) {
    linear_extrude(height)
        circle(r = (size / 2) + tolerance, $fn = 6);
}

module bolt_rod_socket(height, size, tolerance = 0.2) {
    linear_extrude(height)
        circle(r = (size / 2) + tolerance, $fn = 32);
}

module bolt_allen_socket(height, size, tolerance = 0.2) {
    linear_extrude(height)
        circle(r = (size / 2) + tolerance, $fn = 32);
}

module allen_bolt(height = 12.0, size = 3.0) {
    allen_socket_height = 3.00;
    hex_socket_height = 2.00;
    rod_height = height - allen_socket_height - hex_socket_height;
    
    
    bolt_allen_socket(allen_socket_height, size + 3.0);
    
    translate([0, 0, allen_socket_height])
    union() {
        bolt_rod_socket(rod_height, size);
        
        translate([0, 0, rod_height])
            bolt_hex_socket(hex_socket_height, size + 3.0);
    }
}

module repeat_y(times, width, center = true) {
    times = times - 1;
    for (i = [0:1:times])
        translate([0, i * (width / times) - (center ? width / 2 : 0), 0])
            children();
}

module repeat_x(times, width, center = true) {
    times = times - 1;
    for (i = [0:1:times])
        translate([i * (width / times) - (center ? width / 2 : 0), 0, 0])
            children();
}

module shelf() {
    difference() {
        linear_extrude(height)
            square(size, center = true);
        
        strip_w = 12.00;
        
        translate([0, 6, 0])
            grid(2, 2, size[0], 115.00 + 8.00)
                rotate([0, 90, 0])
                    translate([0, 0, -10])
                        linear_extrude(20)
                            circle(r = 4.00);
        
        grid(2, 2, 84, 110)
            mirror([0, 0, 1])
                translate([0, 0, -height])
                allen_bolt(height = height);
        
        translate([0, 0, 5])
        linear_extrude(3)
            union() {
                translate([-((size[0] - 26.00) / 2), size[0] / 2 - 10, 0])
                    square([size[0] - 26.00, strip_w]);
                
                translate([-((size[0] - 26.00) / 2), -(size[0] / 2) - 6, 0])
                    square([size[0] - 26.00, strip_w]);
                
                repeat_x(5, size[0] - 38.00)
                    translate([-(strip_w / 2), -70.00, 0])
                        square([strip_w, 140.00]);
            }
    }
}

shelf();