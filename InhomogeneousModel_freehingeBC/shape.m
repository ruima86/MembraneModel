function dy = shape(t,y,p,f,C0,a0)
dy = zeros(6,1);    % a column vector
psi = y(1);
dpsi = y(2);
gamma = y(3);
R = y(4);
area = y(5);
sigma = y(6);
alpha = 1;
dalpha = 0;
c = C0*0.5*(1-tanh(10*(area-a0)));
dc = -C0*0.5*10*sech(10*(area-a0))^2.*R;
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
dy(5) = R;
dy(6) = dc.*(sin(psi)./R+dpsi-c);