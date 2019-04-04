/**
	Customisable hex bit holder 
	Copyring Mykhaylo Lytvynyuk March 2015
	http://mobilemodding.info
	Released under 
	Attribution - Non-Commercial - No Derivatives License

	*** March 16, 2015 Initial Version
*/

/**
    Modded by Bartłomiej Burdukiewicz
    https://devwork.space
*/

// number of rows
_row = 10;//[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15] 					

// number of columns
_colum = 8;//[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
 					
// mm, base height
_height = 13;

// mm, printer tolerance, can be negative, required to compensate specific printer contraction/expansion during print.
_tolerance = 0.45;

//mm, between sides and bit
_extraPadding = 4.5;

// Rounded corners
_rounded = 1;//[1:Yes,0:No]

// Make slot to add flex to the walls
_slotted = 1;//[1:Yes,0:No]

// mm, defines bit size ( 6.35 is 1/4" )
_bitSize = 4.00;

// mm, base solid height
_baseHeight = 0.60;

/* [Hidden] */
// local vars
outerRadius = outRadius(_bitSize + _tolerance/2,6);
delta = outerRadius + _extraPadding;
width = ( _colum * (outerRadius + _extraPadding) );
depth = ( _row * (outerRadius + _extraPadding) );
minkowskiCylinderHeight = 1;

module assembly() {
    difference() {
        base();
        for(yd = [1:_row]) {
            for(xd = [1:_colum]) {
                    translate([(xd * delta)-(delta/2),(yd *delta)-(delta/2),_baseHeight]) hexBit();
            }
            if(_slotted){
                translate([-2,(yd *delta)-(delta/2) - 1,minkowskiCylinderHeight + _height - _height * 0.75]) cube([width + 4,2,_height*0.75],center=false);
            }
        }
    }
}

module hexBit() {
	cylinder(h=_height+minkowskiCylinderHeight,r=outRadius(_bitSize/2 + _tolerance/2,6),$fn=6, center = false);
}

module base() {
	minkowski() {
		cube([width,depth,_height]);
		if(_rounded) cylinder(r=1,h=minkowskiCylinderHeight,$fn=32,center = false);
	}
}

// calculates outradious by given inradius
function outRadius(inradius, sides) = inradius / ( cos (180 / sides));

assembly();