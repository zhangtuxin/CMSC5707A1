function  [dist_matrix,dist_matrix_tmp] = compare_matrix(MFCCs_s1A,MFCCs_s1B)


    dist_matrix = zeros(length(MFCCs_s1A),length(MFCCs_s1B));
    for row = 1:length(MFCCs_s1A)
        for col =1:length(MFCCs_s1B)
            tmp = 0;
            for k = 1:12
                tmp = tmp + ( MFCCs_s1A(k,col) - MFCCs_s1B(k,row))^2;
            end  
            dist_matrix(length(MFCCs_s1A)- row +1,col) = sqrt(tmp);
        end
    end

    %disp(dist_matrix)
    dist_matrix_tmp = dist_matrix;
    for j=1:length(MFCCs_s1A)
        for i = length(MFCCs_s1B):-1:1
            check1 = i+1;
            check2 = j-1;
            min = inf; 
            if check1 >length(MFCCs_s1A) && check2 < 1
                continue
            end

             %1       
            if check1 <= length(MFCCs_s1A) && check2 >=1
                if dist_matrix(check1,check2 )< min
                    min = dist_matrix(check1,check2);
                end            
                if dist_matrix(i,check2)<min
                    min = dist_matrix(i,check2);
                end
                if dist_matrix(check1,j)<min
                    min = dist_matrix(check1,j);
                end
                dist_matrix(i,j) = dist_matrix(i,j) + min ;
                continue
            end

             %2     
            if check1 <= length(MFCCs_s1A) && check2 <1
                if dist_matrix(check1,j)<min
                    min = dist_matrix(check1,j);
                end            
            end
            %3
            if check1 > length(MFCCs_s1A) && check2 >=1
                if dist_matrix(i,check2)<min
                    min = dist_matrix(i,check2);
                end            
            end
            %final update
            dist_matrix(i,j) = dist_matrix(i,j) + min ;

        end
    end
end







% dist_matrix = zeros(length(MFCCs_s1A),length(MFCCs_s1B));
% for row = 1:length(MFCCs_s1A)
%     for col =1:length(MFCCs_s1B)
%         tmp = 0;
%         for k = 1:12
%             tmp = tmp + ( MFCCs_s1A(k,col) - MFCCs_s1B(k,row))^2;
%         end  
%         dist_matrix(length(MFCCs_s1A)- row +1,col) = sqrt(tmp);
%     end
% end
% 
% %disp(dist_matrix)
% dist_matrix_tmp = dist_matrix;
% for j=1:length(MFCCs_s1A)
%     for i = length(MFCCs_s1B):-1:1
%         check1 = i+1;
%         check2 = j-1;
%         min = inf; 
%         if check1 >length(MFCCs_s1A) && check2 < 1
%             continue
%         end
%         
%          %1       
%         if check1 <= length(MFCCs_s1A) && check2 >=1
%             if dist_matrix(check1,check2 )< min
%                 min = dist_matrix(check1,check2);
%             end            
%             if dist_matrix(i,check2)<min
%                 min = dist_matrix(i,check2);
%             end
%             if dist_matrix(check1,j)<min
%                 min = dist_matrix(check1,j);
%             end
%             dist_matrix(i,j) = dist_matrix(i,j) + min ;
%             continue
%         end
%         
%          %2     
%         if check1 <= length(MFCCs_s1A) && check2 <1
%             if dist_matrix(check1,j)<min
%                 min = dist_matrix(check1,j);
%             end            
%         end
%         %3
%         if check1 > length(MFCCs_s1A) && check2 >=1
%             if dist_matrix(i,check2)<min
%                 min = dist_matrix(i,check2);
%             end            
%         end
%         %final update
%         dist_matrix(i,j) = dist_matrix(i,j) + min ;
%      
%     end
% end




%disp(dist_matrix)