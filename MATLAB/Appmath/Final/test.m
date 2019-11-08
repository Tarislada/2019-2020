fid = fread(fopen('2416'));
changeroo = reshape(fid,512,512);
changeroo2 = imresize(changeroo,0.25);
changeroo3 = reshape(changeroo2,16384,1);
fclose all;
ff = fopen ('2416','w');
fwrite(ff,changeroo3,'double');
fclose all;
fread(fopen(filz(1191).name))