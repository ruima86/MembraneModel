function [position,isterminal,direction] = terminate1(t,y,C0,a0,Rb)
position = zeros(4,1);
isterminal = zeros(4,1);
direction = zeros(4,1);

position(1) = y(1);
isterminal(1) = y(4) > Rb - 0.1;
direction(1) = 1;

position(2) = y(1) + pi;
isterminal(2) = 1;
direction(2) = -1;

position(3) = y(1) - pi; % The value that we want to be zero
isterminal(3) = 1 ;  % Halt integration 
direction(3) = 1;



