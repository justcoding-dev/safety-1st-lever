

translate ([0, 0, -2.1]) scale ([25,19,4.2]) cube(1,true);
translate ([0, 0, 31.3 / 2]) scale ([4.3, 5.53, 31.3]) cube(1, true);
translate ([0, 0, 24.5 / 2 + 31.3 - 24.5]) scale ([4.3, 7.05, 24.5]) cube(1, true);
translate ([(6.75 - 4.3) / 2, 0, 19.3 / 2 + 31.3 - 19.3]) scale ([6.75, 7.05, 19.3]) cube(1, true);
translate ([0,0,5]) rotate ([0, 90, 0]) cylinder(7.05, 2, 2, true, $df=16);
