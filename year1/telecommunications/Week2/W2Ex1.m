f = 1;
t = linspace(0,2,201); %two cycles, 100 points each
y1 = (4/pi)*sin(2*pi*f*t);
y3 = y1 + (4/(3*pi))*sin(2*pi*3*f*t);
y5 = y3 + (4/(5*pi))*sin(2*pi*5*f*t);
sqwave = sign(sin(2*pi*f*t)); %an actual square wave
plot(t,y1, t,y3, t,y5, t, sqwave);