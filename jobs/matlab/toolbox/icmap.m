function cmap = icmap(map,id)

cmap = zeros(256,3);
cmap(id+1,:) = map./255;

