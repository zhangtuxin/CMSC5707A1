[Sampled_Data,Fs] = audioread('s1A.wav');
%Sampled_Data(:,1)
%sound(Sampled_Data,Fs);
dt = 1/Fs;
t = 0:dt:(length(Sampled_Data)*dt)-dt;
%plot(t,Sampled_Data); 
%xlabel('Seconds'); 
%ylabel('Amplitude');
Sampled_DataT = Sampled_Data';
len = length(Sampled_DataT);

%Question 4 Part a

[startIndexFrame,EndIndexFrame,frameStart,frameEnd] = find_start_end_location(len,Sampled_DataT);
if (startIndexFrame <= 1) || (EndIndexFrame <=1)
    disp('This sound file already no slience part !')
else
    fprintf('The T1 , T2 of my recorded sound are %f , %f \n',startIndexFrame/len,EndIndexFrame/len)
    sound(Sampled_Data(startIndexFrame:EndIndexFrame),Fs);
    %Use here to cut off the slience part of the wav file
    %audiowrite('s4B.wav',Sampled_Data(startIndexFrame:EndIndexFrame),Fs,'BitsPerSample',16)
end
%Question 4 Part b
seg1 = Sampled_DataT(frameStart(47):frameEnd(47));
lenSeg1 = length(seg1);
%Question 4 Part c

%idea and some part of the code obtained from the instructor's tutor file and PPT about ploting FT
%x_real = zeros(1,(lenSeg1)/2);
%x_img = zeros(1,lenSeg1/2);
%X_magnitude = zeros(1,lenSeg1/2)
for m = 0:(lenSeg1/2)
    clear real_tmp imag_tmp cos_basis sin_basis cos_part sin_part
    tmp_real = 0;
    tmp_img = 0;
    for k = 0:(lenSeg1-1)
        theta=2*pi*k*(m)/lenSeg1;
        cos_basis(k+1)=cos(theta);
        cos_part(k+1)=seg1(k+1)*cos_basis(k+1);
        
        sin_basis(k+1)=sin(theta);
        sin_part(k+1)=seg1(k+1)*sin_basis(k+1);
        
        tmp_real = tmp_real + cos_part(k+1);
        tmp_img=tmp_img+sin_part(k+1);
    end
    X_magnitude(m+1) = abs(sqrt(tmp_real^2+tmp_img^2));
    
%     plot(X_magnitude)
%     hold on
%     text1=sprintf('Frequency : x-axis is in m=%d, each m represents Fs/N=%f Hz',m, Fs/lenSeg1);
%     xlabel(text1)%    legend(text1)
%     ylabel('|Y| Magnitude (Energy)')
end

%Question 4 Part d
Pem_Seg1(1) = seg1(1);
for j = 2:lenSeg1
    Pem_Seg1(j) = seg1(j) - 0.945*seg1(j-1);
end
plot(seg1)
hold on
plot(Pem_Seg1)
text1=sprintf('Blue(Seg1) Orange(PemSeg1)');
xlabel(text1)

%Question 4 Part e
order = 10 + 1;
auto_corr = zeros(1,11);
%autocorrelation computing
for i = 1:order
   auto_corr(i) = 0.0;
   for j = i:lenSeg1
      auto_corr(i) =  auto_corr(i) + Pem_Seg1(j)* Pem_Seg1(j-i+1);
   end
end
%finding LPC paras
auto_corr_without_r0 = auto_corr(2:11)';
A = zeros(10,10);
j = 0;
for i = 1:10
    A(1,i) = auto_corr(i);
end
for i = 2:10
    j=i;
    for k=1:j
       A(i,k) = auto_corr(j-k+1); 
    end
    for z = 1:10-j
        A(i,j+z) = auto_corr(z+1);
    end
end
lpc_corr = (A\auto_corr_without_r0).*-1;
disp('The 10 LPC parameters are :')
disp(lpc_corr')

%Question 5 part a







