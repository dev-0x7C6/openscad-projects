card_holder_space = [5.00, 52.00];
inner_space = [1.6, 1.6];

height = 30.00;
base_h = 2.00;

module card_holder() {
    difference() {
        linear_extrude(height)
            square(card_holder_space + inner_space, center = true);
        translate([0, 0, base_h])
            linear_extrude(height)
                square(card_holder_space, center = true);
    }
}

card_holder();
translate([0, card_holder_space[1] + inner_space[1], 0])
    card_holder();