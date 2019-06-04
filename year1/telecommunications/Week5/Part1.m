% Clear all the previously used variables and close all figures
clear all;
close all;

format long;

% Frame Length 'Should be multiple of four or else padding is needed'
bit_count = 4*1000;

% Range of SNR over which to simulate 
Eb_No = -6: 1: -2;
Eb_No2 = -6: 1 : 10;
Eb_No3 = -6: 1 : 58;
Eb_No4 = -6: 1 : 250;
% Convert Eb/No values to channel SNR

    SNR4 = Eb_No + 10*log10(4);
    SNR16 = Eb_No2 + 10*log10(16);
    SNR64 = Eb_No3 + 10*log10(64);
    SNR256= Eb_No4 + 10*log10(256);

    % Start the main calculation loop
    for aa = 1: 1: length(SNR4)

        % Initiate variables
        T_Errors = 0;
        T_bits = 0;

        % Keep going until you get 100 errors
        while T_Errors < 100

            % Generate some random bits
            uncoded_bits  = round(rand(1,bit_count));

            % Split the stream into 4 substreams
            B = reshape(uncoded_bits,4,length(uncoded_bits)/4);
            B1 = B(1,:);
            B2 = B(2,:);
            B3 = B(3,:);
            B4 = B(4,:);

            % 16-QAM modulator
            % normalizing factor
            a = sqrt(1/10);

            % bit mapping
            tx = a*(-2*(B3-0.5).*(3-2*B4)-j*2*(B1-0.5).*(3-2*B2));

            % Noise variance
            N0 = 1/10^(SNR4(aa)/10);

            % Send over Gaussian Link to the receiver
            rx = tx + sqrt(N0/2)*(randn(1,length(tx))+i*randn(1,length(tx)));

    %---------------------------------------------------------------

            % 16-QAM demodulator at the Receiver
            a = 1/sqrt(10);

            B5 = imag(rx)<0;
            B6 = (imag(rx)<2*a) & (imag(rx)>-2*a);
            B7 = real(rx)<0;
            B8 = (real(rx)<2*a) & (real(rx)>-2*a);

            % Merge into single stream again
            temp = [B5;B6;B7;B8];
            B_hat = reshape(temp,1,4*length(temp));

            % Calculate Bit Errors
            diff =  uncoded_bits - B_hat ;
            T_Errors = T_Errors + sum(abs(diff));
            T_bits = T_bits + length(uncoded_bits);

        end
        % Calculate Bit Error Rate
        BER(aa) = T_Errors / T_bits;
        disp(sprintf('bit error probability = %f',BER(aa)));

        % Plot the received Symbol Constellation
        figure;
        grid on;
        plot(rx,'x');
        xlabel('Inphase Component');
        ylabel('Quadrature Component');
        title('Constellation of Transmitted Symbols');


    end
     % Start the main calculation loop
    for aa = 1: 1: length(SNR16)

        % Initiate variables
        T_Errors = 0;
        T_bits = 0;

        % Keep going until you get 100 errors
        while T_Errors < 100

            % Generate some random bits
            uncoded_bits  = round(rand(1,bit_count));

            % Split the stream into 4 substreams
            B = reshape(uncoded_bits,4,length(uncoded_bits)/4);
            B1 = B(1,:);
            B2 = B(2,:);
            B3 = B(3,:);
            B4 = B(4,:);

            % 16-QAM modulator
            % normalizing factor
            a = sqrt(1/10);

            % bit mapping
            tx = a*(-2*(B3-0.5).*(3-2*B4)-j*2*(B1-0.5).*(3-2*B2));

            % Noise variance
            N0 = 1/10^(SNR16(aa)/10);

            % Send over Gaussian Link to the receiver
            rx = tx + sqrt(N0/2)*(randn(1,length(tx))+i*randn(1,length(tx)));

    %---------------------------------------------------------------

            % 16-QAM demodulator at the Receiver
            a = 1/sqrt(10);

            B5 = imag(rx)<0;
            B6 = (imag(rx)<2*a) & (imag(rx)>-2*a);
            B7 = real(rx)<0;
            B8 = (real(rx)<2*a) & (real(rx)>-2*a);

            % Merge into single stream again
            temp = [B5;B6;B7;B8];
            B_hat = reshape(temp,1,4*length(temp));

            % Calculate Bit Errors
            diff =  uncoded_bits - B_hat ;
            T_Errors = T_Errors + sum(abs(diff));
            T_bits = T_bits + length(uncoded_bits);

        end
        % Calculate Bit Error Rate
        BER(aa) = T_Errors / T_bits;
        disp(sprintf('bit error probability = %f',BER(aa)));

        % Plot the received Symbol Constellation
       


    end
     figure;
        grid on;
        plot(rx,'x');
        xlabel('Inphase Component');
        ylabel('Quadrature Component');
        title('Constellation of Transmitted Symbols');
     % Start the main calculation loop
    for aa = 1: 1: length(SNR64)

        % Initiate variables
        T_Errors = 0;
        T_bits = 0;

        % Keep going until you get 100 errors
        while T_Errors < 100

            % Generate some random bits
            uncoded_bits  = round(rand(1,bit_count));

            % Split the stream into 4 substreams
            B = reshape(uncoded_bits,4,length(uncoded_bits)/4);
            B1 = B(1,:);
            B2 = B(2,:);
            B3 = B(3,:);
            B4 = B(4,:);

            % 16-QAM modulator
            % normalizing factor
            a = sqrt(1/10);

            % bit mapping
            tx = a*(-2*(B3-0.5).*(3-2*B4)-j*2*(B1-0.5).*(3-2*B2));

            % Noise variance
            N0 = 1/10^(SNR64(aa)/10);

            % Send over Gaussian Link to the receiver
            rx = tx + sqrt(N0/2)*(randn(1,length(tx))+i*randn(1,length(tx)));

    %---------------------------------------------------------------

            % 16-QAM demodulator at the Receiver
            a = 1/sqrt(10);

            B5 = imag(rx)<0;
            B6 = (imag(rx)<2*a) & (imag(rx)>-2*a);
            B7 = real(rx)<0;
            B8 = (real(rx)<2*a) & (real(rx)>-2*a);

            % Merge into single stream again
            temp = [B5;B6;B7;B8];
            B_hat = reshape(temp,1,4*length(temp));

            % Calculate Bit Errors
            diff =  uncoded_bits - B_hat ;
            T_Errors = T_Errors + sum(abs(diff));
            T_bits = T_bits + length(uncoded_bits);

        end
        % Calculate Bit Error Rate
        BER(aa) = T_Errors / T_bits;
        disp(sprintf('bit error probability = %f',BER(aa)));

        % Plot the received Symbol Constellation
       


    end
     figure;
        grid on;
        plot(rx,'x');
        xlabel('Inphase Component');
        ylabel('Quadrature Component');
        title('Constellation of Transmitted Symbols');
     % Start the main calculation loop
    for aa = 1: 1: length(SNR256)

        % Initiate variables
        T_Errors = 0;
        T_bits = 0;

        % Keep going until you get 100 errors
        while T_Errors < 100

            % Generate some random bits
            uncoded_bits  = round(rand(1,bit_count));

            % Split the stream into 4 substreams
            B = reshape(uncoded_bits,4,length(uncoded_bits)/4);
            B1 = B(1,:);
            B2 = B(2,:);
            B3 = B(3,:);
            B4 = B(4,:);

            % 16-QAM modulator
            % normalizing factor
            a = sqrt(1/10);

            % bit mapping
            tx = a*(-2*(B3-0.5).*(3-2*B4)-j*2*(B1-0.5).*(3-2*B2));

            % Noise variance
            N0 = 1/10^(SNR256(aa)/10);

            % Send over Gaussian Link to the receiver
            rx = tx + sqrt(N0/2)*(randn(1,length(tx))+i*randn(1,length(tx)));

    %---------------------------------------------------------------

            % 16-QAM demodulator at the Receiver
            a = 1/sqrt(10);

            B5 = imag(rx)<0;
            B6 = (imag(rx)<2*a) & (imag(rx)>-2*a);
            B7 = real(rx)<0;
            B8 = (real(rx)<2*a) & (real(rx)>-2*a);

            % Merge into single stream again
            temp = [B5;B6;B7;B8];
            B_hat = reshape(temp,1,4*length(temp));

            % Calculate Bit Errors
            diff =  uncoded_bits - B_hat ;
            T_Errors = T_Errors + sum(abs(diff));
            T_bits = T_bits + length(uncoded_bits);

        end
        % Calculate Bit Error Rate
        BER(aa) = T_Errors / T_bits;
        disp(sprintf('bit error probability = %f',BER(aa)));

        % Plot the received Symbol Constellation
        


    end
    figure;
        grid on;
        plot(rx,'x');
        xlabel('Inphase Component');
        ylabel('Quadrature Component');
        title('Constellation of Transmitted Symbols');
    %------------------------------------------------------------

    % Finally plot the BER Vs. SNR(dB) Curve on logarithmic scale 
    % BER through Simulation
    figure(1);
    semilogy(SNR4,BER,'or');
    hold on;
    grid on
    title('BER Vs SNR Curve for QAM-16 Modulation Scheme in AWGN');
    xlabel('SNR(dB)'); ylabel('BER')

    % Theoretical BER
    figure(1);
    theoryBer = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(Eb_No/10))));
    semilogy(SNR4,theoryBer);
    legend('Simulated','Theoretical');
    
    % Finally plot the BER Vs. SNR(dB) Curve on logarithmic scale 
    % BER through Simulation
    figure(1);
    semilogy(SNR16,BER,'or');
    hold on;
    grid on
    title('BER Vs SNR Curve for QAM-16 Modulation Scheme in AWGN');
    xlabel('SNR (dB)'); ylabel('BER')

    % Theoretical BER
    figure(1);
    theoryBer = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(Eb_No/10))));
    semilogy(SNR16,theoryBer);
    legend('Simulated','Theoretical');

    % Finally plot the BER Vs. SNR(dB) Curve on logarithmic scale 
    % BER through Simulation
    figure(1);
    semilogy(SNR64,BER,'or');
    hold on;
    grid on
    title('BER Vs SNR Curve for QAM-16 Modulation Scheme in AWGN');
    xlabel('SNR (dB)'); ylabel('BER')

    % Theoretical BER
    figure(1);
    theoryBer = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(Eb_No/10))));
    semilogy(SNR64,theoryBer);
    legend('Simulated','Theoretical');

    % Finally plot the BER Vs. SNR(dB) Curve on logarithmic scale 
    % BER through Simulation
    figure(1);
    semilogy(SNR256,BER,'or');
    hold on;
    grid on
    title('BER Vs SNR Curve for QAM-16 Modulation Scheme in AWGN');
    xlabel('SNR (dB)'); ylabel('BER')

    % Theoretical BER
    figure(1);
    theoryBer = (1/4)*3/2*erfc(sqrt(4*0.1*(10.^(Eb_No/10))));
    semilogy(SNR256,theoryBer);
    legend('Simulated','Theoretical');

