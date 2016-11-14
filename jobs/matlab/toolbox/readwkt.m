function [gds,X,Y] = readwkt(wkt,varargin)
% READWKT   Read WKT string and return a Version 2 Geographic Data Structure
%
%   [GDS,LAT,LON] = READWKT(WKT,...)
%   [GDS,X,Y] = READWKT(WKT,...)
%
% For historical reasons we support our own WKT-flavour format as follows:
%
%     POLYGON ((LAT,LON LAT,LON LAT,LON))
%     POLYGON ((LAT,LON LAT,LON LAT,LON),(LAT,LON LAT,LON LAT,LON))
%     MULTIPOLYGON (((LAT,LON LAT,LON LAT,LON)),((LAT,LON LAT,LON LAT,LON)))
%     MULTIPOLYGON (((LAT,LON LAT,LON LAT,LON)),((LAT,LON LAT,LON LAT,LON),(LAT,LON LAT,LON LAT,LON)))
%
%       Note the placement of commas, LAT before LON, and also that
%       ring-order is the more traditional clockwise ordering.
%
% We also support the WKT standard formats:
%
%     POLYGON ((X Y, X Y, X Y))
%     POLYGON ((X Y, X Y, X Y),(X Y, X Y, X Y))
%     MULTIPOLYGON (((X Y, X Y, X Y)),((X Y, X Y, X Y)))
%     MULTIPOLYGON (((X Y, X Y, X Y)),((X Y, X Y, X Y),(X Y, X Y, X Y)))
%
%       Note the placement of commas, X before Y (i.e LON before LAT), and
%       that ring-order is counter-clockwise.
%
%       See http://en.wikipedia.org/wiki/Well-known_text for details of the
%       standard formats.
%
% Output [..., LAT,LON] or [...,X,Y] retains the ordering of the input
% format, so the actual names used for the output variables are not
% significant.
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

% Check that this is one of the supported geometries
geometry = regexp(wkt,'\s*(\w+)','tokens','once');
switch upper(char(geometry))
    case {'POLYGON' 'MULTIPOLYGON'}
        % Example
        %     wkt = ['MULTIPOLYGON ' ...
        %         '(((40 40, 20 45, 45 30, 40 40)),' ...
        %         ' ((20 35, 45 20, 30 5, 10 10, 10 30, 20 35),' ... 
        %         '  (30 20, 20 25, 20 15, 30 20)))'];
        % % NB. This example from Wikipedia does not show correct ring-ordering
        % Replace the polygon segment delimiters with ampesands
        str = regexprep(wkt,'\s*)\s*,\s*(\s*',' & '); 
        % Remove everything that isn't a digit, dot, minus, comma or ampesand
        str = regexprep(str,'[^\d\.-,&]',' '); 
        % Replace singe apmesands with double NaNs
        str = regexprep(str,'&','nan nan'); 
        % Determine whether this is the standard or non-standard format
        % (Hint. Look for the position of the commas)
        num = sscanf(str,'%f');
        switch numel(num)
            case 1 % LAT,LON LAT,LON LAT,LON
                complient = false;
            case 2 % X Y, X Y, X Y
                complient = true;
            otherwise
                error('OBOE:WKT:RepresentationNotSupported', ...
                    '3d and 4d representations are not supported.')
        end
        % Now remove all the commas
        str = regexprep(str,',',' '); 
        % Read STR as a single column vector
        num = sscanf(str,'%f');
        % Reshape as a 2-column matrix
        num = reshape(num,2,numel(num)./2)';
        % Assign outputs in original order
        X = num(:,1); Y = num(:,2);
        % Interpretaion of order depends on format
        reversed = 0;
        if complient
            num = rot90(num,2);
            reversed = 1;
        end
        % Make the Geographic Data Structure 
        gds = makegds('Polygon',num(:,1),num(:,2), ...
            'ISREVERSED',reversed,'SOURCE','READWKT',varargin{:});
        
    otherwise
        error('OBOE:WKT:GeometryIdentifierNotSupported', ...
            'Geometry identifier not supported: %s',char(geometry))

end
