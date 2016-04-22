
print_layer_height = 0.25;
// Using a 623ZZ bearing
bearing_od = 10;
bearing_id = 3;
bearing_h = 4;

function nutDia(nominalDiameter) = nominalDiameter*1.8 + 1;
function boltDia(nominalDiameter) = nominalDiameter + 0.2;
function nutHeight(nominalDiameter) = nominalDiameter*0.8 + 0.4;
function nutSlot(nominalDiameter) = nominalDiameter*1.8 + 0.4;

m2_dia = boltDia(2);
m2_nut_dia = nutDia(2);
m2_nut_slot = nutSlot(2);
m2_nut_height = nutHeight(2);

m3_dia = boltDia(3);
m3_nut_dia = nutDia(3) + 0.2;
m3_nut_slot = nutSlot(3);
m3_nut_height = nutHeight(3);

m4_dia = boltDia(4);
m4_nut_dia = nutDia(4);
m4_nut_height = nutHeight(4);

m5_dia = boltDia(5);
m5_nut_dia = nutDia(5)-0.4;
m5_nut_height = nutHeight(5);

m8_dia = boltDia(8);
m8_nut_dia = nutDia(8);
m8_nut_height = nutHeight(8);
m8_nut_slot = nutSlot(8);

e = 2.718281828;
pi = 3.1415926536;

function cosh(x) = (1 + pow(e, -2 * x)) / (2 * pow(e, -x));

function degtorad(x) = x*pi/180;

