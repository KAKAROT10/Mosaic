close all force;
clear all force;
vid = videoinput('winvideo', 1, 'YUY2_640x360');
vid.ReturnedColorspace = 'rgb';
preview(vid);
pause(2);
threshold_tester = getsnapshot(vid); 
averager = imcrop(threshold_tester);
avgr = mean(mean(averager(:,:,1)));
avgg = mean(mean(averager(:,:,2)));
avgb = mean(mean(averager(:,:,3)));

temp_image = imread('Test_image.jpg');
temp_image = imresize(temp_image, [360 640]);
target = temp_image;

tv = vision.VideoPlayer;
tv2 = vision.VideoPlayer;
videoPlayer2 = vision.VideoPlayer;
videoPlayer3 = vision.VideoPlayer;
step(tv, temp_image);

image_number = '1';
mode = 0;
gesture_initialiazation = 0;

while(1)
    step(tv, temp_image);
    if mode == 0
        initial_image = getsnapshot(vid);
        initial_image = flipdim(initial_image, 2);
        initial_image_bw = converter(initial_image, avgr, avgg, avgb);
        step(videoPlayer2, initial_image_bw);
        c1= regionprops(initial_image_bw, 'Centroid');
        g1=[c1.Centroid];
        if length(g1) == 4
            mode = 1;
        end
    end
    if mode == 1
        initial_image = getsnapshot(vid);
        initial_image = flipdim(initial_image, 2);
        initial_image_bw = converter(initial_image, avgr, avgg, avgb);
        step(videoPlayer2, initial_image_bw);
        c1= regionprops(initial_image_bw, 'Centroid');
        g1=[c1.Centroid]; 
        if length(g1) == 2
            mode = 2;
        end
    end
    if mode == 2
        pattern = zeros(360, 640);
        l = 1;
        while l < 81;
            pattern_image = getsnapshot(vid);
            pattern_image_bw = converter(pattern_image, avgr, avgg, avgb);
            pattern_image_bw = flipdim(pattern_image_bw, 2);
            if l == 4
                frame4 = pattern_image_bw;
            elseif l == 75;
                frame75 = pattern_image_bw;
            end
            step(videoPlayer2, pattern_image_bw);
            pattern = pattern + pattern_image_bw;
            step(videoPlayer3, pattern);
            l = l + 1;
        end
        what_pattern = probability(pattern);
         if what_pattern == 1
            'Vertical Line'
            cframe4= regionprops(frame4, 'Centroid');
            gframe4=[cframe4.Centroid];
            cframe75 = regionprops(frame75, 'Centroid');
            gframe75 =[cframe75.Centroid];
            d = gframe75(2) - gframe4(2);
            if d > 0
                temp_image(:,:,:) = temp_image(:,:,:) - 25;
            else
                temp_image(:,:,:) = temp_image(:,:,:) + 25;
            end
            step(tv, temp_image);
            
        elseif what_pattern == 2
            'Horizontal Line'
            
        elseif what_pattern == 3
            'Tick'
            step(tv, temp_image);
            imwrite(temp_image, strcat(strcat('new-', image_number), '.jpg'));
            image_number = image_number + 1;
        elseif what_pattern == 4
            'Zoom'
            zoom_mode = 0;
            initial_image = getsnapshot(vid);
            initial_image_bw = converter(initial_image, avgr, avgg, avgb);
            initial_image_bw = flipdim(initial_image_bw, 2);
            step(videoPlayer2, initial_image_bw);
            c1= regionprops(initial_image_bw, 'Centroid');
            g1=[c1.Centroid];

            if length(g1) > 2
                zoom_mode = 0;
            else
                zoom_mode = 1;
            end
            a1 = regionprops(initial_image_bw, 'Area');
            area=[a1.Area];
            initial_area = max(area);
            while zoom_mode == 1
                zoom_image = getsnapshot(vid);
                zoom_image = flipdim(zoom_image, 2);
                zoom_image_bw = converter(zoom_image, avgr, avgg, avgb);
                step(videoPlayer2, zoom_image_bw);
                c1= regionprops(zoom_image_bw, 'Centroid');
                g1=[c1.Centroid];
                if length(g1) ~= 2
                    zoom_mode = 0;
                    break;
                end
                ac = regionprops(zoom_image_bw, 'Area');
                area2=[ac.Area];
                final_area = max(area2);
                posx = g1(1);
                posy = g1(2);
                zoom_image = Arial_Zoom(target, initial_area, final_area, posx, posy);
                step(tv, zoom_image);
                 temp_image = zoom_image;
            end 
           
        elseif what_pattern == 5
            'AAAAAAAA'
            temp_image = target;
            step(tv, temp_image);
            
         elseif what_pattern== 6
             'YYYYYYYYYY'
             bw_image = rgb2gray(temp_image);
             bw_image = imresize(bw_image, [360 640]);
             step(tv2, bw_image);
             
             
         elseif what_pattern == 7
             'PPPPPPPPPPPPPP'
             temp_image = flipdim(temp_image, 2);
             temp_image = imresize(temp_image, [360, 640]);
             step(tv, temp_image);
             
         elseif what_pattern == 8
            'LLLLLLLLL'
            pause(3);
            rotation_mode = 0;
            initial_image = getsnapshot(vid);
            initial_image = flipdim(initial_image, 2);
            initial_image_bw = converter(initial_image, avgr, avgg, avgb);
            step(videoPlayer2, initial_image_bw);
            c1= regionprops(initial_image_bw, 'Centroid');
            g1=[c1.Centroid];
             
              if length(g1) == 4
                rotation_mode = 1;
                initials(1, 1) = g1(1);
                initials(1, 2) = g1(2);
                initials(2, 1) = g1(3);
                initials(2, 2) = g1(4);
                slope_initial = (initials(2,2) - initials(1, 2))/(initials(2, 1) - initials(1, 1));
              else 
                rotation_mode = 0;
              end
          
            
            while rotation_mode == 1
                zoom_image = getsnapshot(vid);
                zoom_image = flipdim(zoom_image, 2);
                zoom_image_bw = converter(zoom_image, avgr, avgg, avgb);
                step(videoPlayer2, zoom_image_bw);
                c1= regionprops(zoom_image_bw, 'Centroid');
                g1=[c1.Centroid];
                if length(g1) ~= 4
                    rotation_mode = 0;
                    break;
                end
                finals(1, 1) = g1(1);
                finals(1, 2) = g1(2);
                finals(2, 1) = g1(3);
                finals(2, 2) = g1(4);
                slope_final = (finals(2,2) - finals(1, 2))/(finals(2, 1) - finals(1, 1));
                angle = 5*(((slope_initial-slope_final)/(1+slope_initial*slope_final)));
                if angle < -3 || angle > 3
                     temp_image = imrotate(target, 2 * angle);
                     temp_image = imresize(temp_image, [360, 640]);
                end
                step(tv, temp_image);
            end 
         elseif what_pattern == 9
             fprintf('Invalid Gesture\n');
             fprintf('Loading original Image\n');
             temp_image = target;
         end
    
        temp_image = temp_image;
        mode = 0;
        pause(3);
    end
end
    