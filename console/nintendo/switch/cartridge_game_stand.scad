grid = [4, 7];


module cartridge_slot(h = 10.00, center = true) {
    cube([21.80, 3.60, h], center);
}

module cartridge_adapter(additional_h = 0.00,  center = true) {
    adapter_size = [24.00, 20.00, 9.00 + additional_h];
    slot_angle = 10.00;
    slot_height = 5.00;
    slot_offset = 4.40;
    
    difference() {
        linear_extrude(adapter_size[2])
            square([adapter_size[0], adapter_size[1]], center = true);
        
        translate([0, -slot_offset, adapter_size[2] - slot_height / 2])
            rotate([-slot_angle, 0, 0])
                cartridge_slot(slot_height * 2);
    }
}

for (y = [0:(grid[0] - 1)])
    for (x = [0:(grid[1] - 1)])
        translate([24.00 * x, 20.00 * y, 0])
            cartridge_adapter(7.00 * y);