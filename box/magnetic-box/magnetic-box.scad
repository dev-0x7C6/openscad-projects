$fn = 64;


area = [140.00, 140.00, 19.00];
slot = [2.5, 2.70]; 

top_height = 3.20; 
bottom_height = 2.00;

wall = 6.00;

difference() {
    h = area[2] + bottom_height;
    difference() {
        linear_extrude(h) 
            minkowski() {
                square([area[0] + wall * 2 - 1, area[1] + wall * 2 - 1], center = true);
                circle(r = 1, center = true);
            }
        
        for (x = [-1, 1])
            for (y = [-1, 1])
                translate([((area[0]+wall*2)/2 - slot[0] - wall/6) * x, ((area[1]+wall*2)/2 - slot[0] - wall/6) * y, h - slot[1]]) 
                    linear_extrude(slot[1]) 
                        circle(r = slot[0], center = true);
    }

    translate([0, 0, bottom_height])
    linear_extrude(area[2])
        minkowski() {
            square([area[0] - 2, area[1] - 2], center = true);
            circle(r = 1, center = true);
        }
}

translate([(area[0]+wall*2)*1.2, 0, 0])
union() {
    h = top_height;
    difference() {
        linear_extrude(h) 
            minkowski() {
                square([area[0] + wall * 2 - 1, area[1] + wall * 2 - 1], center = true);
                circle(r = 1, center = true);
            }
        
        for (x = [-1, 1])
            for (y = [-1, 1])
                translate([((area[0]+wall*2)/2 - slot[0] - wall/6) * x, ((area[1]+wall*2)/2 - slot[0] - wall/6) * y, h - slot[1]]) 
                    linear_extrude(slot[1]) 
                        circle(r = slot[0], center = true);
    }
}
