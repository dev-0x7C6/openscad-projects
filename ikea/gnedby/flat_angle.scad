$fn = 64;

length = 50.00;
width = 30.00;
height = 2.00;

hole = 1.60;
hole_spacer = hole * 4;

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

difference() {
    linear_extrude(height)
        square([width, length], center = true);
    
    linear_extrude(height)
        grid(2, 3, width - (hole * 2) - hole_spacer, length - (hole * 2) - hole_spacer)
            circle(r = hole);
}