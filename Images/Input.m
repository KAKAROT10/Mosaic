ji = 1;
ja = '0';
for m = '1':'8'  
    for k = '0':'2'
        for l = '0':'9'
            imagename = strcat(strcat(strcat(strcat(m, ja),k),l), '.jpg');
            img = imread(imagename);  
            imgbw = im2bw(img);
            imgbw = imresize(imgbw, [25 25]);
            index = 1;
            for i = 1:25
                for j = 1:25
                   X(ji,index) = imgbw(j, i);
                    index = index + 1;
                end
            end
            ji = ji + 1;
        end
    end
end