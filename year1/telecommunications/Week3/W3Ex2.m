load('array.mat'); %loading array.mat from folder
%fs=1000; %sampling frequency [Hz]
%N = 1024; 
F=fftshift(abs(fft(y,N))); %frequency spectrum of your signal, normalises x-axis
newX=-fs/2 : fs/N : fs/2-fs/N; %new x values using sampling frequency
plot(newX, F);
%f = approx. 334Hz