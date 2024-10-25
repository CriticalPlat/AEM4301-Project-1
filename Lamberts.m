function [V1,V2]=lambert(mu,R0,R1,dt,z0,dir)

r0=norm(R0); % length of R0
r1=norm(R1); % length of R1
dtheta=acos(dot(R0,R1)/r0/r1); %transfer angle

if dir==1 %short way
    sgn=1; %”direction of motion”
else
    dtheta=2*pi-dtheta; %long way
    sgn=-1;
end
A=sgn*sqrt(r0*r1*(1+cos(dtheta)));
z=z0; %trial value
relerr=1; %initialize error
tol=1e-5; % Accepted relative error


while relerr>tol
if z==0 %to avoid division by zero
    S=1/6; Sprime= -1/120;
    C=1/2; Cprime= -1/24;
else
    C=(1-cos(sqrt(z)))/z;
    S=(sqrt(z)-sin(sqrt(z)))/z^(3/2);
    Cprime=...; 
    Sprime=...;
 

end
%calculate u(z),v(z), new value of z
%...
end
%use value of z obtained to determine v1,v2