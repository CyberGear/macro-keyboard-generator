include <keeb-generator-core.scad>

$fn=0;
$fa=10;
$fs=0.1;
     
layout=[
        [ 0, 1, 0, 1, 0 ],
        [ 0, 0, 1, 0, 0 ],
        [ 0, 0, 1, 0, 0 ],
        [ 0, 0, 0, 0, 0 ]
    ];

/*
    123
    4 6
    789
*/
screws=[
        [ [ ], [2], [    ], [2], [ ] ],
        [ [ ], [ ], [    ], [ ], [ ] ],
        [ [ ], [ ], [7, 9], [ ], [ ] ],
        [ [ ], [ ], [    ], [ ], [ ] ]
    ];

/* proC, proMicro */
microController = "proC";
mcPlacement=[
        [ 0, 0, 0, 0, 0 ],
        [ 0, 0, 1, 0, 0 ],
        [ 0, 0, 0, 0, 0 ],
        [ 0, 0, 0, 0, 0 ]
    ];

/*model*/

caseTop(layout, screws, microController, mcPlacement);
casePlate(layout, screws, microController, mcPlacement);
caseBottom(layout, screws, microController, mcPlacement);