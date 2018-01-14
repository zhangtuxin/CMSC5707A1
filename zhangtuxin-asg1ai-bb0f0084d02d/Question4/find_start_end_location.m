function [startIndexFrame,EndIndexFrame,frameStart,frameEnd] = find_start_end_location(len,Sampled_DataT)
    
    frameStart = [];
    frameEnd = [];
    count = 0;
    tmp = 0;
    while 1
    tmp2 = count*441 + 1;
    frameStart(count+1) = tmp2;
    if (tmp2 + 882) < len
        frameEnd(count+1) = tmp2 + 881;
    else
        frameEnd(count + 1) = len;
        break;
    end
    count = count + 1;

    end
    %Question 4 Part a
    totalFrame = length(frameStart);



    Energy = zeros(1,totalFrame);
    for i = 1:totalFrame
        for j = frameStart(i):frameEnd(i)
            Energy(i) = Energy(i) + Sampled_DataT(j)*Sampled_DataT(j);
        end
    end

    zeroCrossingRate = zeros(1,totalFrame);
    for i = 1:totalFrame
        for j = frameStart(i):frameEnd(i)
            if (j+1) < len && sign(Sampled_DataT(j)*Sampled_DataT(j+1)) == -1
                zeroCrossingRate(i) = zeroCrossingRate(i) + 1;
            end
        end
    end
    %sound(Sampled_DataT(frameStart(30):frameEnd(85)),Fs)
    startIndex = 0;
    EndIndex = 0;
    startIndexFrame = 0;
    EndIndexFrame = 0;
    for i = 1:totalFrame
        if (Energy(i) > 5) && (Energy(i+1) > 5) && (Energy(i+2) > 5) && (zeroCrossingRate(i) >= 10) && (zeroCrossingRate(i+1) >= 10) && (zeroCrossingRate(i+2) >= 10) && (i < (totalFrame-3));
            startIndex = i;
            startIndexFrame = frameStart(i);
            break
        end
    end


    for i = startIndex:totalFrame
        if ((i < (totalFrame-7) && Energy(i) < 5) && (Energy(i+1) < 5) && (Energy(i+2) < 5) && (Energy(i+3) < 5) && (Energy(i+4) < 5) && (Energy(i+5) < 5) && (Energy(i+6) < 5) &&(Energy(i+7) < 5) && (zeroCrossingRate(i) < 999) && (zeroCrossingRate(i+1) < 999) && (zeroCrossingRate(i+2) < 999) && (zeroCrossingRate(i+3) < 999) && (zeroCrossingRate(i+4) < 100) )
            EndIndex = i;
            EndIndexFrame = frameEnd(i);
            break
        end
    end

end
