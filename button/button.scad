$fn=12;

button_size = 27.85;
button_base_height = 2;
button_height = 7.5 - button_base_height;

module button(size, bh = 2, h = 6)
{
    cylinder(h=bh, r1=size/2.0, r2=size/2.0, center=false);
    translate([0, 0, 2])
        cylinder(h, r1=size/2.0, r2=0, center=false);
}

module handle(size, center=true) {
    difference() {
        cube([4, 4, 8], center);
        translate([center ? 0 : 1, 0, center ? -2 : 1])
        cube([2, 4, 2], center);
    }
}

difference() {
    button(button_size, button_base_height, button_height);
    handle(button_size * 0.9, center=true);
}

translate([button_size, 0, 0])
handle(center=false);

