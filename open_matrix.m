function X = open_matrix(Sample)
    imgbw = im2bw(Sample);
    imgbw = imresize(imgbw, [25 25]);
    X = zeros(1, 625);
    index = 1;
    for j = 1:25
        for i = 1:25
           X(1,index) = imgbw(i, j);
            index = index + 1;
        end
    end
end
    
 