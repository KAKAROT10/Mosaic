function L1=converter(snap1, avgr, avgg, avgb)
    min_area=200; 
    snap2 = decorrstretch(snap1, 'Tol', 0.005);
    rr=snap1(:,:,1);
    gg=snap1(:,:,2);
    bb=snap1(:,:,3);
    redz2 = snap2(:, :, 1)>=225;
    redz=((rr>=avgr - 20) & (rr<=avgr + 20) & (gg>=avgg -20) & (gg<=avgg + 20) & (bb>=avgb - 20) & (bb<=avgb + 20));
    redz = redz & redz2; 
    se=strel('disk',10);
    redz=imclose(redz,se);
    redz=imfill(redz,'holes'); 
    L1 = bwlabel(redz);
    a1 = regionprops(L1, 'Area');
    area=[a1.Area];
    f1=find(area>min_area);
    im1=ismember(L1,f1);
    L1=im1.*L1;