$fa = 1;
$fs = 0.4;
$fn = 100;

jack_diameter = 8;
jack_margin = 10.00;

potentiometer_diameter = 12;
potentiometer_margin = 10;

switch_diameter = 6;
switch_margin = 8;
switch_right_margin = 15;

num_potentiometers = 3;
num_switches = 2;
num_jacks = 2;

breadboard_width = 175;
breadboard_overlap = 10;
breadboard_feet_height = 3.00; // Shall match the rubber feet

panel_depth = 5.00;
panel_height = 35;
hole_height = 20;
panel_diameter = 15.00;

panel_sides_margin = 10.00;

footswitch_diameter = 12;

module sub_wall()
{
    rotate([90, 0,0 ])
        union()
        {
            translate([-breadboard_width/2 + panel_diameter/2, panel_height-panel_diameter/2, 0])
                cylinder(d=panel_diameter, h=panel_depth, center=true);
            translate([-breadboard_width/2 + panel_diameter/2, panel_diameter/2, 0])
                cube([panel_diameter, panel_diameter, panel_depth], center=true);
        }
}

module wall()
{
    hull () {
        sub_wall();
        mirror([1, 0, 0]) sub_wall();
    }
}

module switch_slots()
{
    for (i = [0:num_switches-1])
    {
        rotate([90, 0, 0])
            translate([-footswitch_diameter/2-switch_diameter/2-switch_right_margin-i*(switch_diameter+switch_margin), hole_height, 0])
                cylinder(d=jack_diameter, h=panel_depth*2, center=true);
    }
}

module jack_slots()
{
    for (i = [0:num_jacks-1])
    {
        rotate([90, 0, 0])
            translate([-breadboard_width/2+panel_sides_margin+i*(jack_diameter+jack_margin), hole_height, 0])
                cylinder(d=jack_diameter, h=panel_depth*2, center=true);
    }
}

module potentiometer_slots()
{
    for (i = [0:num_potentiometers-1])
    {
        rotate([90, 0, 0])
            translate([breadboard_width/2-panel_sides_margin-i*(potentiometer_diameter+potentiometer_margin), hole_height, 0])
                cylinder(d=potentiometer_diameter, h=panel_depth*2, center=true);
    }
}

module footswitch_slot()
{
    rotate([90, 0, 0])
            translate([0, hole_height, 0])
                cylinder(d=footswitch_diameter, h=panel_depth*2, center=true);
}

/* Main constructions */
difference()
{
    wall();
    jack_slots();
    potentiometer_slots();
    footswitch_slot();
    switch_slots();
}
