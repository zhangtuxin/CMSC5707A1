a = [5 0 0 0 0 0;1 0 0 0 0 0; 4 0 0 0 0 0;1 0 0 0 0 0;3 0 0 0 0 0;0 8 3 7 6 1];
%a = [3 0 0 0 0 0;5 0 0 0 0 0; 6 0 0 0 0 0;2 0 0 0 0 0;9 0 0 0 0 0;0 8 3 7 6 1];
for i = 1:5
    for j = 2:6
        %a(i,j) = abs( (a(i,1) - a(6,j))^2 );
        a(i,j) = abs( (a(i,1) - a(6,j)) );
    end
end
disp("dis matrix is " )
disp(a)
disp("============== Distortion Matrix for ONE Compare with Unknown input ")
b = a(1:5,2:6);
disp(b)

for j = 1:5
    for i = 5:-1:1
        
        check1 = i+1;
        check2 = j-1;
        min = inf;

        if check1 >5 && check2 < 1
            continue
        end
       
 %1       
        if check1 <=5 && check2 >=1
            if b(check1,check2)<min
                min = b(check1,check2);
            end            
            if b(i,check2)<min
                min = b(i,check2);
            end
            if b(check1,j)<min
                min = b(check1,j);
            end
            b(i,j) = b(i,j) + min ;
            continue
        end
 %2     
        if check1 <=5 && check2 <1
            if b(check1,j)<min
                min = b(check1,j);
            end            
        end
 %3
        if check1 >5 && check2 >=1
            if b(i,check2)<min
                min = b(i,check2);
            end            
        end
        %final update
        b(i,j) = b(i,j) + min ;
        
    end
end
disp("============== accumlatiom matrix for ONE Compare with Unknown input")

disp(b)

    
    
   