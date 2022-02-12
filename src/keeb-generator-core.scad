include <keeb-generator-commons.scad>
include <keeb-generator-components.scad>

caseThikness = 5;
caseTopHeight = 5; 
caseBottomHeight = 10;
caseCornerRadius = 3;
tolerance = 0.2;

caseWidth1U = keycapWidth + caseThikness * 2;
caseCoverHight  = caseBottomHeight + plateHeight;
caseCoverWidth  = caseWidth1U - 1.6;
caseCoverRadius = caseCornerRadius - 0.8;

plateWidth1U = caseCoverWidth - tolerance;
plateRadius  = caseCoverRadius - tolerance;
plateHookHeight = plateHeight * 2;
plateClearance = plateWidth1U - 1.9 * 2;
plateClearanceRadius = 1;

bottomInnerRadius = plateClearanceRadius - tolerance;
bottomLipWidth = plateClearance - 0.2;
screwInDepth=caseTopHeight ;

module populateLayout(layout) {
    union() {
        for (y = [0: len(layout) - 1]){
            for (x = [0: len(layout[y]) - 1]) {
                if (layout[y][x] == 1) {
                    translate([x * keycapWidth, y * -keycapWidth, 0]) children(0);
                }
            }
        }
    }
}

module wall(layout) {
    difference() {
        populateLayout(layout) {
            children(0);
        }
        populateLayout(layout) {
            children(1);
        }
    }
}

module populateScrews(screws=[[1]]) {
    dist=keycapWidth / 2 + caseThikness - 3;
    moves=[
            [-1, 1],  [0, 1],  [1, 1],
            [-1, 0],  [0, 0],  [1, 0],
            [-1, -1], [0, -1], [1, -1]
        ];
    position=function (x, mod) (x * keycapWidth) + (mod * dist);
    union() {
        for (y = [0: len(screws) - 1]){
            for (x = [0: len(screws[y]) - 1]) {
                if (len(screws[y][x]) > 0) {
                    for (m = screws[y][x]){
                        mod=moves[m - 1];
                        translate([position(x, mod[0]), position(-y, mod[1]), 0]) children(0);
                    }
                }
            }
        }
    }
}

module caseTopPart(
    layout = [[1]], 
    screws = [[[1, 3, 7, 9]]]
) {
    caseWidth1U=keycapWidth + caseThikness * 2;
    screwInDepth=caseTopHeight - plateHeight;
    
    difference() {
        union() {
            populateLayout(layout) {
                plate1U();
            }
            wall(layout) {
                roundUpCube([caseWidth1U, caseWidth1U, caseTopHeight], 3);
                upishCube([keycapWidth + 0.1, keycapWidth + 0.1, caseTopHeight + 1]);
            }
        }
        union() {
            populateScrews(screws, caseThikness) {
                m2Screw(screwInDepth, caseBottomHeight);
            }
            translate([0, 0, -0.01]) lip(layout, 6, 1, 0.25);
        }
    }
}

module caseBottomPart(
    layout = [[1]], 
    screws = [[[1, 3, 7, 9]]]
) { 
    caseWidth1U=keycapWidth + caseThikness * 2;
    
    bottomThikness=1.4;
    difference() { 
        union() {
            wall(layout) {
                roundDownCube([caseWidth1U, caseWidth1U, caseBottomHeight], 3);
                downishCube([keycapWidth + 0.05, keycapWidth + 0.05, caseBottomHeight - bottomThikness]);
            }
            lip(layout, 6, 0.5, 0);
        }
        translate([0, 0, 0.1])
            populateScrews(screws, caseThikness) {
                translate([0, 0, 1]) m2Screw(screwInDepth - 1, caseBottomHeight + 1);
            }
    }
}

module caseTopShell(layout = [[1]]) {
    translate([0, 0, plateHeight]) wall(layout) {
        chamferRoundUpCube([caseWidth1U, caseWidth1U, caseTopHeight], 3);
        upishCube([keycapWidth + 0.1, keycapWidth + 0.1, caseTopHeight + 1]);
    }
    translate([0, 0, plateHeight]) wall(layout) {
        roundDownCube([caseWidth1U, caseWidth1U, caseCoverHight], caseCornerRadius);
        roundDownishCube([caseCoverWidth, caseCoverWidth, caseCoverHight + 1], caseCoverRadius);
    }
}

module casePlateShell(layout = [[1]]) {
    populateLayout(layout) plate1U();
    difference() {
        translate([0, 0, plateHeight]) wall(layout) {
            chamferRoundDownCube([plateWidth1U, plateWidth1U, plateHookHeight], caseCoverRadius, 0.3);
            downishCube([keycapWidth + 0.01, keycapWidth + 0.01, plateHookHeight + 1]);
        }
        populateLayout(layout) 
                roundDownCube([plateClearance, plateClearance, plateHookHeight], plateClearanceRadius);
    } 
}

module caseBottomShell(layout = [[1]]) {
    difference() {
        wall(layout) {
            rotate([180, 0, 0])
                chamferRoundUpCube([plateWidth1U, plateWidth1U, caseBottomHeight], caseCoverRadius);
            downishCube([keycapWidth + 0.1, keycapWidth + 0.1, caseBottomHeight + 1]);
        }
        wall(layout) {
            roundDownishCube([plateWidth1U + 0.1, plateWidth1U + 0.1, plateHookHeight - plateHeight + 0.1], caseCoverRadius);
            roundDownishCube([bottomLipWidth, bottomLipWidth, plateHookHeight + 1], bottomInnerRadius);
        }
    }
    translate([0, 0, -caseBottomHeight])
    populateLayout(layout)
        rotate([180, 0, 0])
            chamferRoundDownCube([plateWidth1U, plateWidth1U, 1.4], caseCoverRadius);
}

module screws(screws=[ [ [1, 3, 7, 9] ] ]) {
    populateScrews(screws) {
        translate([0, 0, plateHeight + 0.01]) m2Screw(screwInDepth - 1, caseBottomHeight + 1);
    }
}

module mc(mc = "proC") {
    if (mc == "proC") arduinoProC();
    else if (mc == "proMicro") cube([1, 1, 1]);
    else cube([0, 0, 0]);
}

module mcLock(mc = "proC") {
    if (mc == "proC") arduinoProCLock();
    else if (mc == "proMicro") cube([1, 1, 1]);
    else cube([0, 0, 0]);
}

module caseTop(layout = [[1]], screws=[ [ [1, 3, 7, 9] ] ], mc = "mcProC", mcPlace = [[]]) 
    difference() {
        caseTopShell(layout);
        union() {
            screws(screws);
            populateLayout(mcPlace) mc(mc);
        }
    }

module casePlate(layout = [[1]], screws=[ [ [1, 3, 7, 9] ] ], mc = "mcProC", mcPlace = [[]]) 
    difference() {
        casePlateShell(layout);
        screws(screws);
    }

module caseBottom(layout = [[1]], screws=[ [ [1, 3, 7, 9] ] ], mc = "mcProC", mcPlace = [[]]) 
    difference() {
        union() {
            caseBottomShell(layout);
            populateLayout(mcPlace) mcLock(mc);
        }
        union() {
            screws(screws);
            populateLayout(mcPlace) mc(mc);
        }
    }