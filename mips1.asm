% Isaac Bullinger
% Homework 6
% isaac.bullinger@nwc.edu
from=menu('from','C','A','G','S');
L=input('Input length of wire in meters: \n');
I=input('Input current carrying capacity in amps: \n');
V=input('Input current in volts: \n');%%%%%%%%% input is in volts, not current
R=(V/I);
if L<0||L>100000
    display('Error code: Invalid length!');
    pause
    exit
end
if I<0||I>100
    display('Error code: Invalid amperage!');
    pause
    exit
end
if V<0||V>100000
    display('Error code: Invalid voltage!');
    pause
    exit
end
switch from
    case 1
C=1.72*10^(-8);
AC=R/(C*L);
DC=((((4*AC)/pi)^(1/2))*.001*2);
fprintf('The diameter of copper wire in centimeters is %5.2f \n',DC);
    case 2
A=2.75*10^(-8);
AA=R/(A*L);
DA=((((4*AA)/pi)^(1/2))*.001*2);
fprintf('The diameter of aluminum wire in centimeters is %5.2f \n',DA);
    case 3
G=2.44*10^(-8);
AG=R/(G*L);
DG=((((4*AG)/pi)^(1/2))*.001*2);
fprintf('The diameter of gold wire in centimeters is %5.2f \n',DG);
    case 4
S=1.59*10^(-8);
AS=R/(S*L);
DS=((((4*AS)/pi)^(1/2))*.001*2);
fprintf('The diameter of silver wire in centimeters is is %5.2f \n',DS);
end
