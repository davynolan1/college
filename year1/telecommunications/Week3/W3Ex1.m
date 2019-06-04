fs=100; %sampling frequency in hertz
frequency=10; %frequency of sine wave in hertz
time=2; %how many seconds to consider
x= 0:1/fs:time-1/fs; %points in x axis
y=sin(2*pi*x*frequency); %your signal
subplotCount = 1;
for N = [64, 128, 256] %loop for each of these values as N
    subplot(2,2,subplotCount); %creates 3 plots
    F=fftshift(abs(fft(y,N))); %frequency spectrum of your signal, normalises x-axis
    newX=-fs/2:fs/N:fs/2-fs/N;
    plot(newX, F);
    title(sprintf("N = %d", N)) %creates titles for each graph
    subplotCount = subplotCount + 1;
end