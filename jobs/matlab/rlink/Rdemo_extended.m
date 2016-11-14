%% Connecting MATLAB to R
% 
% The statistical programming language R has a COM interface. We can use
% this to execute R commands from within MATLAB. The connection requires a
% local installation of R and also of the R-(D)COM Interface (for Windows
% only). This can be downloaded from
% http://lib.stat.cmu.edu/R/CRAN/other-software.html or other CRAN mirror
% site.

[status,msg] = openR;
if status ~= 1
    disp(['Problem connecting to R: ' msg]);
end

%% Run one of the R demos to test the connection.

evalR('demo("persp")');

%% Now copy the volcano data into MATLAB

volcano = getRdata('volcano');

%% Use SURF to plot the volcano

surf(volcano);
axis off; view(-135,40);

%% You can also copy the colormap from R

cols = char(evalR('terrain.colors(20)'));
red = hex2dec(cols(:,[2 3]));
green = hex2dec(cols(:,[4 5]));
blue = hex2dec(cols(:,[6 7]));
colormap([red,green,blue]/256);

%% Another view
% 
% The R variable z has edges filled in for more realistic viewing. The surface is flipped around in the R version.

z = getRdata('z');
h = surf(fliplr(z));
axis off; view(-135,40);

%% Add some lighting and turn off the edges

lightangle(-135,40);
lighting gouraud
set(h,'linestyle','none');

%% Now do some arithmetic in R. First push some data into R.

a = 1:10;
putRdata('a',a)

%% Run a simple R command

b = evalR('a^2')

%% Run a series of commands and grab the result

evalR('b <- a^2');
evalR('c <- b + 1');
c = getRdata('c')

%% Close the connection

closeR

