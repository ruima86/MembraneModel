function [position,isterminal,direction] = terminate2(t,y,C0,a0,Rb)
position = zeros(4,1);
isterminal = zeros(4,1);
direction = zeros(4,1);

psi = y(1);
dpsi = y(2);
R = y(4);
area = y(5);
c = C0*0.5*(1-tanh(10*(area-a0)));
position(1) = sin(psi)/R + dpsi - c;
isterminal(1) = R > Rb - 0.1;
direction(1) = -1;

position(2) = y(1) + pi;
isterminal(2) = 1;
direction(2) = -1;

position(3) = y(1) - pi; % The value that we want to be zero
isterminal(3) = 1 ;  % Halt integration 
direction(3) = 1;



