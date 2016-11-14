function P = patchstats(A,properties,connections)

if nargin<3
    switch numel(size(A))
        case 2
            connections = 4;
        case 3
            connections = 6;
    end
end

classes = setdiff(unique(A),[0 210 230 250]);

S = struct([]);
for i = 1:numel(classes)
    BW = A==classes(i);
    S(i).CLASSID = classes(i);
    S(i).CC = bwconncomp(BW,connections);
    S(i).STATS = regionprops(labelmatrix(S(i).CC),properties);
end

for property = properties
    propstr = char(property);
    P.(propstr) = zeros(size(A));
    for i = 1:numel(S)
        for j = 1:S(i).CC.NumObjects
            P.(propstr)(S(i).CC.PixelIdxList{j}) = S(i).STATS(j).Area;
        end
    end
    P.(propstr) = P.(propstr)./max(P.(propstr)(:))*255;
    P.(propstr) = uint8(P.(propstr));
end

