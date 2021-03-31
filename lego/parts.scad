base_h = 0.60;
h = 34.00;
r = 5.80 / 2;

$fn = 64;

m = 0.50;
b = 4.75 - m * 2;
w = 1.50 - m * 2;
s = 0.80;

linear_extrude(base_h)
    circle(r);
    
linear_extrude(h) {
    minkowski() {
        union() {
            square([b * s, w * s], center = true);
            square([w * s, b * s], center = true);
        }
        circle(m);
    }
}

translate([20, 0, 0]) {
    linear_extrude(h) {
            square([b, w], center = true);
            square([w, b], center = true);
    }
    
    linear_extrude(base_h)
        circle(r);
}