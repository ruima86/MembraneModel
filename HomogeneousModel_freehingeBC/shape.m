function dy = shape(t,y,p,sigma,f,C0)
dy = zeros(4,1);    % a column vector
psi = y(1);
dpsi = y(2);
gamma = y(3);
R = y(4);
alpha = 1;
dalpha = 0;
c = C0;
dc = 0;
dy(1) = dpsi;
dy(2) = cos(psi)/R*(sin(psi)/R-dpsi-f/alpha) ...
      + p/2/alpha*R*cos(psi) ...
      + gamma/alpha/R*sin(psi) ...
      - dalpha/alpha*(dpsi+sin(psi)/R-c) ...
      + dc;
dy(3) = alpha/2*(dpsi-c)^2 - alpha*sin(psi)^2/2/R^2 ...
      + sigma ...
      + p*R*sin(psi);
dy(4) = cos(psi);