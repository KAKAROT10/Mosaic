close all force;
clear all force;
vidtest = videoinput('winvideo', 1, 'YUY2_640x360');
vidtest.ReturnedColorspace = 'rgb';
flushdata(vidtest);
threshold_tester = getsnapshot(vidtest);
averager = imcrop(threshold_tester);
avgr = mean(mean(averager(:,:,1)));
avgg = mean(mean(averager(:,:,2)));
avgb = mean(mean(averager(:,:,3)));

vid = videoinput('winvideo', 1, 'YUY2_640x360');
vid.ReturnedColorspace = 'rgb';

% clears any data logged by vid prior to this.
flushdata(vid);

% create video player object
videoPlayer  = vision.VideoPlayer;
videoPlayer2  = vision.VideoPlayer;
%% iterate over the frames
i = 1;
while (i < 30) 
    itemp = getsnapshot(vid);
    itemp = flipdim(itemp, 2);
    img(:, :, :, i) = itemp;
        step(videoPlayer, itemp);
    itemp = converter(itemp, avgr, avgg, avgb);
    imgbw(:, :, :, i) = itemp;

    step(videoPlayer2, itemp);
    i = i + 1;
end


