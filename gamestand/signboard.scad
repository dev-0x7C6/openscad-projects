//$fn = 128;
//$fa = 1;
//$fs = 0.5;

$fn = $preview ? 8 : 64;
$fa = 20;
$fs = 20;

resources = [
    "resources/nintendo/wii.svg", // 0
    "resources/nintendo/wiiu.svg", // 1
    "resources/nintendo/3ds.svg", // 2
    "resources/nintendo/gamecube.svg", // 3
    "resources/nintendo/switch.svg", // 4
    "resources/sega/dreamcast.svg", // 5
    "resources/sony/ps3.svg", // 6
    "resources/sony/ps4.svg", // 7
    "resources/microsoft/xbox.svg", // 8
    "resources/microsoft/xbox-one.svg", // 9 
    "resources/microsoft/xbox-360.svg", // 10
    "resources/audio-cd.svg", // 11
    "resources/bluray.svg", // 12
];

// 
resource_index = 6;

resource = resources[resource_index];

font_deep = 1.40;
font_h = 1.40 + font_deep;

base_h = 2.60;
assert(base_h + 0.40 >= font_deep, "lower font_deep or rise base_h");


front = [161.00, 27.00];

handle_h = 6.00;
handle_thickness = 1.60;

handle_space = 13.00;
//handle_space = 19.15;

// -1 - bottom, 0 - center, 1 - top
handle_align = -1;
assert(handle_align >= -1, "handle_align should be greater or equal to -1");
assert(handle_align <= 1, "handle_align should be lower or equal to 1");

module render_logo_y(logo, size, delta) {
    offset(delta = delta)
        resize([0, size, 0], auto = true)
            import (logo, center = true, dpi = 1200);
}

module render_logo(logo, h, y_size, delta = 0) {
    linear_extrude(h)
        mirror([0, 1, 0])
            render_logo_y(logo, y_size, delta);
}

module front_panel() {
    color("Turquoise")
        linear_extrude(base_h)
            square(front, center = true);
}

module handle() {
    color("Aquamarine")
        linear_extrude(handle_h)
            difference() {
                square([front[0], handle_space + handle_thickness * 2], center = true);
                square([front[0], handle_space], center = true);
            }
}

module panel() {
    difference() {
        union() {
            front_panel();
            translate([0, ((handle_space + handle_thickness * 2) / 2 - (front[1] / 2)) * handle_align, base_h])
                handle();
        }

        translate([0, 0, $preview ? -0.01 : 0.00])
            render_logo(resource, font_deep, front[1] * 0.6);
    }
}


module logo() {
    color("DeepSkyBlue")
        render_logo(resource, font_h, front[1] * 0.6, delta = -0.05);
}

panel();
translate([0, front[1], 0])
    logo();