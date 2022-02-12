$fn=0;
$fa=10;
$fs=0.1;

module upCube(size=[1, 1, 1]) {
    translate([0, 0, size[2] / 2]) cube(size, true);
}

module upishCube(size=[1, 1, 1]) {
    translate([0, 0, (size[2] / 2) - 0.1]) cube(size, true);
}

module downCube(size=[1, 1, 1]) {
    translate([0, 0, size[2] / -2]) cube(size, true);
}

module downishCube(size=[1, 1, 1]) {
    translate([0, 0, (size[2] / -2) + 0.1]) cube(size, true);
}

module roundCube(size=[1, 1, 1], cornerRadius = 1) {
    diameter = 2 * cornerRadius;
    distx = size[0] - diameter;
    disty = size[1] - diameter;
    hull() {
        translate([distx / -2, disty / -2, 0]) cylinder(size[2], cornerRadius, cornerRadius, true);
        translate([distx /  2, disty /  2, 0]) cylinder(size[2], cornerRadius, cornerRadius, true);
        translate([distx /  2, disty / -2, 0]) cylinder(size[2], cornerRadius, cornerRadius, true);
        translate([distx / -2, disty /  2, 0]) cylinder(size[2], cornerRadius, cornerRadius, true);
    }
}

module roundUpCube(size=[1, 1, 1], cornerRadius = 1) {
    translate([0, 0, size[2] / 2]) roundCube(size, cornerRadius);
}

module roundUpishCube(size=[1, 1, 1], cornerRadius = 1) {
    translate([0, 0, (size[2] / 2) - 0.1]) roundCube(size, cornerRadius);
}

module roundDownCube(size=[1, 1, 1], cornerRadius = 1) {
    translate([0, 0, size[2] / -2]) roundCube(size, cornerRadius);
}

module roundDownishCube(size=[1, 1, 1], cornerRadius = 1) {
    translate([0, 0, (size[2] / -2) + 0.1]) roundCube(size, cornerRadius);
}

module chamferRoundCube(size=[10, 10, 10], cornerRadius = 0.5, chamfer = 0.5) {
    diameter = 2 * cornerRadius;
    distx = size[0] - diameter;
    disty = size[1] - diameter;
    resth = size[2] - chamfer;
    rawHeight = size[2] - chamfer;
    chamferr = cornerRadius - chamfer;
    union() {
        hull() {
            translate([distx / -2, disty / -2, rawHeight / 2]) cylinder(chamfer, cornerRadius, chamferr, true);
            translate([distx /  2, disty /  2, rawHeight / 2]) cylinder(chamfer, cornerRadius, chamferr, true);
            translate([distx /  2, disty / -2, rawHeight / 2]) cylinder(chamfer, cornerRadius, chamferr, true);
            translate([distx / -2, disty /  2, rawHeight / 2]) cylinder(chamfer, cornerRadius, chamferr, true);
        }
        hull() {
            translate([distx / -2, disty / -2, chamfer / -2]) cylinder(rawHeight, cornerRadius, cornerRadius, true);
            translate([distx /  2, disty /  2, chamfer / -2]) cylinder(rawHeight, cornerRadius, cornerRadius, true);
            translate([distx /  2, disty / -2, chamfer / -2]) cylinder(rawHeight, cornerRadius, cornerRadius, true);
            translate([distx / -2, disty /  2, chamfer / -2]) cylinder(rawHeight, cornerRadius, cornerRadius, true);
        }
    }
}

module chamferRoundUpCube(size=[1, 1, 1], cornerRadius = 1, chamfer = 0.5) {
    translate([0, 0, size[2] / 2]) chamferRoundCube(size, cornerRadius, chamfer);
}

module chamferRoundDownCube(size=[1, 1, 1], cornerRadius = 1, chamfer = 0.5) {
    translate([0, 0, size[2] / -2]) chamferRoundCube(size, cornerRadius, chamfer);
}