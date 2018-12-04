rail_lenght = 180;
rail_height = 15;
rail_width = 1.6;
rail_space = 23;
rail_base_height=1.6;

union() {
    y_size = rail_space + rail_width * 2;
    cube([rail_lenght, y_size, rail_base_height]);
    cube([rail_lenght, rail_width, rail_height + rail_base_height]);
    translate([0, y_size - rail_width, 0])
        cube([rail_lenght, rail_width, rail_height + rail_base_height]);
}
