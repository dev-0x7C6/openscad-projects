$fn = 64;

r = 4.90;
trim = 3.40;
hole = 2.00;
h = 1.60;

spacer_r = 8.00;
spacer_h_expand = 0.20;

module extension() {
    linear_extrude(h)
        difference() {
            circle(r / 2);
            difference() {
                square([r, r], center = true);
                square([r, trim], center = true);
            }
            circle(hole / 2);
        }
}


module spacer() {
    linear_extrude(h + spacer_h_expand)
        difference() {
            circle(spacer_r / 2);
            circle(r / 2 + 0.10);
        }
}

extension();

translate([spacer_r * 1.25, 0, 0])
    spacer();