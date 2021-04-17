$fn = 64;

circle = 4.10;
height = 3.60;
hole_h = 3.00;
hole_w = 3.30;

difference() {
    linear_extrude(height)
        circle(r = circle);
    translate([0, 0, height - hole_h])
    linear_extrude(hole_h)
        square([hole_w, hole_w], center = true);
}