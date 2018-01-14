%Question 5 part a) Get MFCCs parameters for 
MFCCs_s1A= wav2mfcc1('s1A.wav');
MFCCs_s2A= wav2mfcc1('s2A.wav');
MFCCs_s3A= wav2mfcc1('s3A.wav');
MFCCs_s4A= wav2mfcc1('s4A.wav');
MFCCs_s1B= wav2mfcc1('s1B.wav');
MFCCs_s2B= wav2mfcc1('s2B.wav');
MFCCs_s3B= wav2mfcc1('s3B.wav');
MFCCs_s4B= wav2mfcc1('s4B.wav');
%First row is the enery row, useless, take it away.
MFCCs_s1A = MFCCs_s1A(2:end,:);
MFCCs_s2A = MFCCs_s2A(2:end,:);
MFCCs_s3A = MFCCs_s3A(2:end,:);
MFCCs_s4A = MFCCs_s4A(2:end,:);
MFCCs_s1B = MFCCs_s1B(2:end,:);
MFCCs_s2B = MFCCs_s2B(2:end,:);
MFCCs_s3B = MFCCs_s3B(2:end,:);
MFCCs_s4B = MFCCs_s4B(2:end,:);
format long

setA = cell(4,1);
setB = cell(4,1);
for i=1:4
    if i ==1
        setA{i} = MFCCs_s1A;
        setB{i} = MFCCs_s1B;
    end
    if i ==2
        setA{i} = MFCCs_s2A;
        setB{i} = MFCCs_s2B;
    end
    if i ==3
        setA{i} = MFCCs_s3A;
        setB{i} = MFCCs_s3B;
    end
    if i ==4
        setA{i} = MFCCs_s4A;
        setB{i} = MFCCs_s4B;
    end
    
end
clear MFCCs_s1A MFCCs_s2A MFCCs_s3A MFCCs_s4A MFCCs_s1B MFCCs_s2B MFCCs_s3B MFCCs_s4B i

%Part C

n_n_compare_matrix = zeros(4,4);
for i = 1:4
    for j=1:4
       [dist_matrix,~] = compare_matrix(setA{i},setB{j});
       tmp = min(dist_matrix(1,:));
       n_n_compare_matrix(4 - j + 1,i) = tmp;
    end
end

disp(n_n_compare_matrix)
disp('Part C :This is the NxN comparsion matrix')
disp('x-axis from left to right refer to s1A,s2A,s3A,s4A')
disp('y-axis from bottom to top refer to s1B,s2B,s3B,s4B')

clear i j tmp

%Part D

%take s4A s4B which are the sound of ZERO of my recordings
[acc_dist_matrix,~] = compare_matrix(setA{1},setB{1});
%disp(acc_dist_matrix)



