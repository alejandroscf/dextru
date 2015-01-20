//$fn=360;
$fn=30;
module base(){
  difference(){
    // Bloques
    union(){
      // Base
      translate([0,0,5])cube([78,40,10]);
      // Anclaje motor
      translate([17.5,32,15]) cube([45,8,45]);
      // Guia
      translate([38,4,15]) cube([12,28,45]);
      translate([40,18,37.5]) rotate([90,0,0]) cylinder(d=30, h=28, center=true);
    }

    // Agujeros
    union(){
      // Tornillos anclaje a carro
      translate([15,0,7.5+5/2]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      translate([65,0,7.5+5/2]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      // Filamento
      translate([46.5,20,40]) cylinder(d=4, h=100, center=true);
      // Tornillos fary
      translate([21.5,20,7.5]) cylinder(d=4.5, h=50, center=true);
      translate([71.5,20,7.5]) cylinder(d=4.5, h=50, center=true);
      // Zocalos tuercas fary
      translate([21.5,20,16]) cylinder(d=7.5, h=10, center=true,$fn=6);
      translate([71.5,20,16]) cylinder(d=7.5, h=10, center=true,$fn=6);
      // Tornillos motor
      translate([24.5,40,22]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      translate([55.5,40,22]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      translate([24.5,40,53]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      translate([55.5,40,53]) rotate([90,0,0]) cylinder(d=4, h=100, center=true);
      // Eje motor
      translate([40,40,37.5]) rotate([90,0,0]) cylinder(d=23, h=100, center=true);
      // Entrada para el idler
      translate([40,0,26]) cube([50,32,23]);
      // Ranura para el idler
      translate([50,4,8]) cube([7,30,7]);
      // Exceso de anchura
      cube([5,45,20]);
      // Tornillo apriete
      translate([50,13,55]) rotate([0,90,0]) cylinder(d=4.5, h=1000, center=true);
    }
  }
}

module idler(){
  // Idler
  difference(){
    union(){
      // Pie ranura
      translate([51,5,8]) cube([5,26,52]);
      // Soporte rodamiento
      translate([56,5,17]) cube([10,26,43]);
     
    }
    union(){
      // Zocalo rodamiento
      translate([50,15.5,25]) cube([40,9,25]);
      // Eje rodamiento/
      translate([56,40,37.5]) rotate([90,0,0]) cylinder(d=7.6, h=100, center=true);
      translate([48.4,2,33.7]) cube([7.6,30,7.6]);
      // Tornillo apriete
      translate([50,13,55]) rotate([0,90,0]) cylinder(d=5, h=1000, center=true);
    }
  }
}

base();
idler();
