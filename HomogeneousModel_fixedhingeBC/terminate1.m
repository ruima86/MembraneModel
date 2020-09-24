function [position,isterminal,direction] = terminate1(t,y,Rb,angle)
position(1) = y(1) - angle; % The value that we want to be zero
isterminal(1) = y(4) > Rb - 0.1;  % Halt integration 
direction(1) = -1;   % The zero can be approached from above

position(2) = y(1) + pi;
isterminal(2) = 1;
direction(2) = -1;

position(3) = y(1) - pi; % The value that we want to be zero
isterminal(3) = 1 ;  % Halt integration 
direction(3) = 1;
