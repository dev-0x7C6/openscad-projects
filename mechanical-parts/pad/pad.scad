$fn=64;

b = 18.00;
r = 2.75;
h = 2.00;

linear_extrude(h)
    difference() {
        square([b, b], center = true);
        circle(r = 2.75);
    }