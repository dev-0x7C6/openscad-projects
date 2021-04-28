wall = 1.2;
area = [75.40, 75.40];
hole = [67.00, 67.00];

base_h = 1.00;
w = 16.00;

union() {
    linear_extrude(base_h) {
        difference() {
            square(area, center = true);
            square(hole, center = true);
        }
    }
    
    linear_extrude(base_h + w) {
        difference() {
            square([area[0] + wall * 2, area[1] + wall * 2], center = true);
            square(area, center = true);
        }
    }
}

