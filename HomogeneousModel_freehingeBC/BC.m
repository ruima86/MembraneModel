function err = BC(x,p,sigma,C0,R0,Z,Rb)
f = x(1);
dpsi0 = x(2);
psi0 = 0;
gamma0 = sigma*R0-R0/2*(dpsi0^2-C0^2);
y0 = [psi0,dpsi0,gamma0,R0];
tspan=[0,50];
termFunc1 = @(t,y) terminate1(t,y,Rb,C0);
options1 = odeset('Events',termFunc1,'AbsTol',1e-16,'RelTol',1e-12);
termFunc2 = @(t,y) terminate2(t,y,Rb,C0);
options2 = odeset('Events',termFunc2,'AbsTol',1e-16,'RelTol',1e-12);



[t,y] = ode45(@(t,y) shape(t,y,p,sigma,f,C0), tspan, y0,options1);
psi = y(:,1);
dpsi = y(:,2);
R = y(:,4);
Z_end = trapz(t,sin(psi));
R_end = R(end);
MeanH_end = dpsi(end)+ sin(psi(end))/R(end);

err1 = (Z_end-Z)^2 + (MeanH_end-C0)^2 + (R_end-Rb)^2;

[t,y] = ode45(@(t,y) shape(t,y,p,sigma,f,C0), tspan, y0,options2);
psi=y(:,1);
dpsi = y(:,2);
R = y(:,4);
Z_end = trapz(t,sin(psi));
R_end = R(end);
MeanH_end = dpsi(end)+ sin(psi(end))/R(end);

err2 = (Z_end-Z)^2 + (MeanH_end-C0)^2 + (R_end-Rb)^2;

err = min(err1,err2);