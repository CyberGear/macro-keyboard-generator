include <keeb-generator-core.scad>

$fn=0;
$fa=10;
$fs=0.1;
     
layout=[
        [ 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0 ],
        [ 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0 ],
        [ 0, 0, 1, 1, 1, 1, 1, 1, 1, 0, 0 ],
        [ 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 0 ],
        [ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 ],
        [ 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1 ],
        [ 1, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1 ],
        [ 0, 0, 0, 1, 1, 0, 1, 1, 0, 0, 0 ],
    ];

/*
    123
    4 6
    789
*/
screws=[
        [ [ ] ]
    ];

/* proC, proMicro */
microController = "proC";
mcPlacement=[
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ],
    ];

/*model*/

caseTop(layout, screws, microController, mcPlacement);
//translate([0, 0, -30])
casePlate(layout, screws, microController, mcPlacement);
//translate([0, 0, -60])
caseBottom(layout, screws, microController, mcPlacement);