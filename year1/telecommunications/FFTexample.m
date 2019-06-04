frequency=20;																				%frequency	of	my	sine	wave	
fs= 5*frequency;			%set	sampling	frequency	at	more	than	twice	the	sine	
							%frequency	(because	of	approxima8on	errors).	Even	 											%sam=2.01*frequency	would	work	
time=1; 						%number	of	periods	I	want	to	calculate	
x=0:1/fs:time-1/fs;  %this	gives me the total number of samples I will	have	
y=sin(2*pi*frequency*x); %this is my function
N=1024;   %number of FFT samples
F = fftshift(abs(fft(y,N)));  %fftshift makes signal symmetric at origin
newx = -fs/2:fs/N:fs/2-fs/N;  %new x axis containing correct frequency scale
plot(newx,F);  %plot the frequency spectrum