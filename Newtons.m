%% Define f(x), f'(x)=g(x)

relerr=1; %to get started
tol=.01; %tolerance
xi=4; %initial guess
n=0; %number of iterations
nmax=20;

while relerr>tol
    xi1=xi-f(xi)/g(xi); %get new x
    relerr=abs((xi1-xi)/xi); %relative error
    xi=xi1;

    n=n+1;
    if n>nmax
        break;
    end
end