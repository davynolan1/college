hold on;
fs = 1000;
N = 16384;
frequency = 10;

[notes, fs] = audioread('exercise notes.wav');


soundA = notes(1:6800);    %first note, a sharp
soundB = notes(6800:10000); %second note, c sharp

a = fftshift(abs(fft(soundA, N)));
b = fftshift(abs(fft(soundB, N)));


newX=-fs/2 : fs/N : fs/2-fs/N; %new x values using sampling frequency
subplot(2,2,1)
plot(newX, a);
subplot(2,2,2);
plot (newX, b);