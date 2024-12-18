%% Define f(x), f'(x)=g(x)
function[zi] = Newtons(u, v)

relerr=1; %to get started
tol=.01; %tolerance
zi=4; %initial guess
n=0; %number of iterations
nmax=20;

while relerr>tol
    zi1=zi-u(zi)/v(zi) %get new z
    relerr=abs((zi1-zi)/zi); %relative error
    zi=zi1

    n=n+1;
    if n>nmax
        break;
    end
end