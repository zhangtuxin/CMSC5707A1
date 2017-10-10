%A tutorial to show how Discrete Foruier transform works,khwong 14.9.2016
%Kiss approach: simple and stupid, the purpose is to illustrtae the idea
%but not for efficiency, rewrite if you want to use it for serious work.
% http://www.cse.cuhk.edu.hk/~khwong/www2/cmsc5707/5707_02_preprocess.pptx
%Dsicrete fouirer transform theory tutporial
clearvars
close all
%[s,fs]=audioread('s1.wav'); %fs=sampling frequncy
%[s,fs]=audioread('A4_oboe.wav'); %fs=sampling frequncy%
%[s,fs]=audioread('A4_oboe_11025.wav'); %fs=sampling frequncy
[s,fs]=audioread('A5_flute.wav'); %fs=sampling frequncy
%[s,fs]=audioread('A4_violin.wav'); %fs=sampling frequncy

%you may want to resample the signal to other sampling rate, but it is slow
% [orginal_s,orginal_fs]=audioread('s1.wav'); %fs=sampling frequncy
% resample_factor=1
% fs=orginal_fs/resample_factor
% s=resample(orginal_s,fs,resample_factor);%resample(s,p,q)%resample p/q times

N=2048%256%example, can change to other numbers such as 512 1024,.. 44100
%N is the fourier window, since sample is fs, if N=fs,the fourier
%processing window is it will be one second. E.g. FS=44100, N=Fs=44100, it
%is 1 seocnd. Proof: time betwwen two samples is Ts=1/44100,then fs*Ts=1
%sec.

start=11777 %by inspection this frame has vowel (oscillating frequency)

x=s(start:start+(N-1));%obtain a frame of sound, length N (fourier proc.windows)

clear s % make sure you are using th rght dtata

%
for m=0:(N/2) % m is from m=0 to m=N/2 as defined in wiki
    % see https://en.wikipedia.org/wiki/Discrete_Fourier_transform
    clear real_tmp imag_tmp cos_basis sin_basis cos_part sin_part
    real_tmp=0;
    imag_tmp=0;
    m
    
    %beware matlab matrix index starts from 1 not 0. Fix: +1 to make it work
    %ie, x(0) in the formula is x(1) here in the program.
    for k=0:N-1
        theta=2*pi*k*(m)/N;
        
        cos_basis(k+1)=cos(theta);%cos_basis(k) starts from k=1 not k=0
        cos_part(k+1)=x(k+1)*cos_basis(k+1); % so as other arrays
        
        sin_basis(k+1)=sin(theta);
        sin_part(k+1)=x(k+1)*sin_basis(k+1);
        
        real_tmp=real_tmp+cos_part(k+1); %fr_x=fourier of x
        imag_tmp=imag_tmp+sin_part(k+1); %fr_x=fourier of x
    end
    % pause
    
    fr_x(m+1)=abs(sqrt(real_tmp^2+imag_tmp^2));
    
    %    pause
    figure(1)
    clf
    
    subplot(6,1,1) %-------------- subplot 1 ----------------------------
    plot([0:N-1],x)%show correct index on the xaxis,
    ylabel('Signal x')
    text1=sprintf('time in samples, N=%d samples, Fs=%5d, time between 2 samples=1/Fs=%0.6f sec.',N,fs,1/fs);
    xlabel(text1);
    % text1=sprintf('m=%d,equivalent freq=%5.2f',m, fs*m/N)    ;
    %title(text1)%    legend(text1)
    
    
    subplot(6,1,2)%-------------- subplot 2 ----------------------------
    line([0 0 ],[ 1 -1]), hold on
    plot([0:N-1],cos_basis);% to show correct index of the data
    ylabel('cos');
    
    subplot(6,1,3)%-------------- subplot 3 ----------------------------
    line([0 0 ],[ 0.5 -0.5]), hold on
    plot([0:N-1],cos_part);% to show correct index of the data
    ylabel('Real');
    
    subplot(6,1,4)%-------------- subplot 4 ----------------------------
    line([0 0 ],[ 1 -1]), hold on
    plot([0:N-1],sin_basis);
    ylabel('sin');
    
    subplot(6,1,5)%-------------- subplot 5 ----------------------------
    line([0 0 ],[ 0.5 -0.5]), hold on
    plot([0:N-1],sin_part);
    ylabel('Img')
    
    subplot(6,1,6)%-------------- subplot 6 ----------------------------
    % plot(fr_x(m+1), fs*m/N,'+')
    plot(fr_x);
    hold on
    % plot([0:(fs/2)/(N/2):fs/2],fr_x);
    text1=sprintf('Freq: x-axis is in m=%d, each m represents Fs/N=%f Hz',m, fs/N);
    xlabel(text1)%    legend(text1)
    ylabel('|Y|')
    % pause
    
end

figure(2)
clf
'test6'
size(fr_x)
%[1:(fs/2)/N:fs/2]
%size([1:1+((fs/2)/(N/2)):fs/2])
%pause
%plot(fr_x)
%plot([1:(fs/2)/(N/2):fs/2],fr_x);%each m unit is Fs/N Hz, from 0 to fs/2 Hz.
plot([0:(fs/2)/(N/2):fs/2],fr_x);%each m unit is Fs/N Hz, from 0 to fs/2 Hz.

title('power spectrum  of discrete fourier transofrm');
%text1=sprintf('m=%d,equivalent freq=%f',m, fs*m/N)    ;
text2=sprintf('In Hz, fs=%d',fs);
xlabel(text2);
[cc,ii]=max(fr_x)
%multiple Fs/N is to convert to frequency fro m m
'max frequceny is '
max_freq=(ii-1)*fs/N% minus 1 is becuase the index hase been increasd,

figure(3)% compare with fft() in matlab, seems to be ok,>> help ftt
clf
%%%%%%%%%%%%%%%%
Fs=fs;
y=x;
NFFT = N%2^nextpow2(L); % Next power of 2 from length of y
L=N;
Y = fft(y,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2+1);

% Plot single-sided amplitude spectrum.
plot(f,2*abs(Y(1:NFFT/2+1)))
title('Using FFT(), Single-Sided Amplitude Spectrum of y(t)');
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')


