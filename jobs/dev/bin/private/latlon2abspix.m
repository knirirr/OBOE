function [row,col] = latlon2abspix(r,lat,lon)

[row,col] = latlon2pix(r,lat,lon);
row = round(row);
col = round(col);
    
