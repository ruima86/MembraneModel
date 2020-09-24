function [position,isterminal,direction] = terminate2(t,y,Rb,C0)
position(1) = y(2) + sin(y(1))/y(4) - C0; % The value that we want to be zero
isterminal(1) = y(4) > Rb - 0.1 ;  % Halt integration 
direction(1) = 1;   % The zero can be approached from below

position(2) = y(1) + pi;
isterminal(2) = 1;
direction(2) = -1;

position(3) = y(1) - pi; % The value that we want to be zero
isterminal(3) = 1 ;  % Halt integration 
direction(3) = 1;
