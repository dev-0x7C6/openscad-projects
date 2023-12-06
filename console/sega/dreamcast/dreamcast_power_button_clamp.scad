$fn=128;

linear_extrude(5)
    difference() {
        circle(3.0);
        square([3.50, 3.50], center = true);
    }
