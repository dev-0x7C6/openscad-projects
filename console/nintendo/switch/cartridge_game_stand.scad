grid = [5, 8];

block_size = [24.00, 20.00, 9.00];
additional_height_for_next_row = 7.00;

cardridge_height_after_insert = 25.00;
enclosure_tolerance = 0.40;
enclosure_base_thickness = 0.20;
enclosure_wall_thickness = 0.80;

module cartridge_slot(h = 10.00, center = true) {
    cube([21.80, 3.60, h], center);
}

module cartridge_adapter(additional_h = 0.00,  center = true) {
    adapter_size = [block_size[0], block_size[1], block_size[2] + additional_h];
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

module game_stand() {
    for (y = [0:(grid[0] - 1)])
        for (x = [0:(grid[1] - 1)])
            translate([block_size[0] * x, block_size[1] * y, 0])
                cartridge_adapter(additional_height_for_next_row * y);
}

module enclosure_box() {
    h = (grid[0] * additional_height_for_next_row) + (block_size[2] - additional_height_for_next_row) + cardridge_height_after_insert;
    l = block_size[0] * grid[1] + enclosure_tolerance * 2;
    w = block_size[1] * grid[0] + enclosure_tolerance * 2;

    difference() {
        linear_extrude(h + enclosure_base_thickness)
            square([l + enclosure_wall_thickness * 2, w + enclosure_wall_thickness * 2], center = true);

        translate([0, 0, enclosure_base_thickness])
            linear_extrude(h)
                square([l, w], center = true);

    }
}

game_stand();

translate([0, 200, 0])
    enclosure_box();
