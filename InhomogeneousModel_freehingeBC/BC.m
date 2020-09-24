function err = BC(x,p,sigma_e,C0,R0,a0,Z,Rb)
f = x(1);
dpsi0 = x(2);
sigma0 = x(3);
psi0 = 0;
c0 = C0*0.5*(1-tanh(10*(0-a0)));
gamma0 = sigma0*R0-R0/2*(dpsi0^2-c0^2);
area0 = 0;
y0=[psi0,dpsi0,gamma0,R0,area0,sigma0];
tspan=[0,50];

termFunc1 = @(t,y) terminate1(t,y,C0,a0,Rb);
options1=odeset('Events',termFunc1,'AbsTol',1e-16,'RelTol',1e-12);
termFunc2 = @(t,y) terminate2(t,y,C0,a0,Rb);
options2=odeset('Events',termFunc2,'AbsTol',1e-16,'RelTol',1e-12);


[t,y] = ode45(@(t,y) shape(t,y,p,f,C0,a0), tspan, y0,options1);
psi=y(:,1);
dpsi=y(:,2);
R = y(:,4);
area = y(:,5);
sigma = y(:,6);
c = C0*0.5*(1-tanh(10*(area-a0)));
Z_end = trapz(t,sin(psi));
R_end = R(end);
sigma_end = sigma(end);
MeanH_end = sin(psi(end))./R_end + dpsi(end);
err1 = (Z_end-Z)^2 + (MeanH_end-c(end))^2 ...
     + (R_end-Rb)^2 + (sigma_end/sigma_e-1)^2;

[t,y] = ode45(@(t,y) shape(t,y,p,f,C0,a0), tspan, y0,options2);
psi=y(:,1);
dpsi=y(:,2);
R = y(:,4);
area = y(:,5);
sigma = y(:,6);
c = C0*0.5*(1-tanh(10*(area-a0)));
Z_end = trapz(t,sin(psi));
R_end = R(end);
sigma_end = sigma(end);
MeanH_end = sin(psi(end))./R_end + dpsi(end);
err2 = (Z_end-Z)^2 + (MeanH_end-c(end))^2 ...
     + (R_end-Rb)^2 + (sigma_end/sigma_e-1)^2;

err = min(err1,err2);
