include <keeb-generator-commons.scad>

plateHeight=1.4;

switchWidth=14;
keycapWidth=19.05;

screwRadius=0.95;
screwHoleRadius=1.25;
screwHeadRadius=2.25;
screwHeadThikness=0.75;

module plate1U() {
    difference() {
        upCube([keycapWidth + 0.1, keycapWidth + 0.1, plateHeight]);
        upishCube([switchWidth, switchWidth, plateHeight + 1]);
    }
}

module m2Screw(screwInDepth=5, pushInDepth=10) {
    cylinder(screwInDepth, screwRadius, screwRadius);
    translate([0, 0, -pushInDepth])
        cylinder(pushInDepth, screwHoleRadius, screwHoleRadius);
    translate([0, 0, -pushInDepth -1])
        cylinder(screwHeadThikness + 1, screwHeadRadius, screwHeadRadius);
    translate([0, 0, -pushInDepth + screwHeadThikness])
        cylinder(screwHeadThikness, screwHeadRadius, screwHoleRadius);
}

module arduinoProC() {
    pcb = [18, 35.6, 1.6];
    socket = [9, 8, 3.3];
    jack = [12.4, 30, 7.8];
    translate([0, -5.45, -8.6]) {
        translate([0, 14.3, 0])
        hull(){
            upCube([pcb.x, 7, pcb.z + 0.5]);
            upCube([7, 7, 6]);
        }
        
        upCube(pcb);
        rotate([-90, 0, 0])
            translate([0, -pcb.z -1.65, 11])
                hull() {
                    translate([-2.85, 0, 0]) cylinder(9, 1.7, 1.7);
                    translate([ 2.85, 0, 0]) cylinder(9, 1.7, 1.7);
                }
        rotate([-90, 0, 0])
            translate([0, -pcb.z -1.65, 20])
                hull() {
                    translate([-2.3, 0, 0]) cylinder(30, 3.9, 3.9);
                    translate([ 2.3, 0, 0]) cylinder(30, 3.9, 3.9);
                }
        translate([0, -18.8, -1.2]) cylinder(3, 1, 1);
    }
}

module arduinoProCLock() {
    translate([0, -5.45, -8.6]) 
        difference() {
            translate([0, -18, 0]) upCube([23, 8, 1.6]);
            upishCube([18, 35.6, 1.8]);
        }
}
