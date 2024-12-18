%% Project Main
clear;
clc;

% Problem 1: Long Way
mu = 1;
R0 = [0.5 0.6 0.7];
R1 = [0 1 0];
dt = 0.9667663; 
z0 = 0;
dir = 0; 
[V1,V2] = Lamberts(mu, R0, R1, dt, z0, dir);

disp('Problem 1: Long Way')
disp('V1:'), disp(V1)
disp('V2:'), disp(V2)

% Problem 1: Short Way
dir = 1;
[V1,V2] = Lamberts(mu, R0, R1, dt, z0, dir);

disp('Problem 1: Short Way')
disp('V1:'), disp(V1)
disp('V2:'), disp(V2)

% Problem 2: Short Way
mu = 1;
R0 = [1 0 0];
R1 = [1 1/8 1/8];
dt = 1/8; 
z0 = 0;
dir = 1; 
[V1,V2] = Lamberts(mu, R0, R1, dt, z0, dir);

disp('Problem 2: Short Way')
disp('V1:'), disp(V1)
disp('V2:'), disp(V2)

%% Lambert's Function
function [V1,V2] = Lamberts(mu, R0, R1, dt, z0, dir)

    r0 = norm(R0); % length of R0
    r1 = norm(R1); % length of R1
    dtheta = acos(dot(R0, R1) / r0 / r1); %transfer angle

    if dir == 1 %short way
        sgn = 1; %"direction of motion"
    else
        dtheta = 2*pi - dtheta; %long way
        sgn = -1;
    end
    
    A = sgn * sqrt(r0 * r1 * (1 + cos(dtheta)));
    z = z0; %trial value
    relerr = 1; %initialize error
    tol = 1e-7; % Accepted relative error
    n = 0;
    nmax = 200;
    while relerr > tol && n < nmax
        if z == 0 %to avoid division by zero
            S = 1/6; Sprime = -1/120;
            C = 1/2; Cprime = -1/24;
        else
            C = (1 - cos(sqrt(z))) / z;
            S = (sqrt(z) - sin(sqrt(z))) / z^(3 / 2);
            Cprime = (1 / (2 * z)) * (1 - z * S - 2 * C);
            Sprime = (1 / (2 * z)) * (C - 3 * S);
        
        end
            %calculate u(z),v(z), new value of z
            
            y = r0 + r1 - A * ((1-z*S) / (sqrt(C)));
            chi = sqrt(y / C);
            u = (1/sqrt(mu)) * ((chi^3)*S + A*sqrt(y)) - dt;
            v = (1/sqrt(mu)) * ((chi^3) * (Sprime-(3*S*Cprime)/(2*C)) + (A/8) * ((3*S*sqrt(y))/C + A/chi));
            % Just Added
            z_new = z - u / v;
            relerr = abs((z_new - z) / z);
            z = z_new;
            n = n + 1;

    end
        if n>nmax
        end
    
        %use value of z obtained to determine v1,v2
        
            f = 1 - (chi^2)*C / r0;
            g = dt - (chi^3)*S / sqrt(mu); % = fp
            f_prime = (sqrt(mu)*chi/(r1*r0))*(z*S - 1);
            g_prime = (1 + g*f_prime) / f;
            V1 = (R1 - f*R0) / g;
            V2 = f_prime*R0 + g_prime*V1;
        
end