%     v = betadiv;
%     for i = 1:5
%         w = nan(size(v,1)-2,size(v,2)-2,9);
%         w(:,:,1) = v(1:end-2,1:end-2);
%         w(:,:,2) = v(1:end-2,2:end-1);
%         w(:,:,3) = v(1:end-2,3:end-0);
%         w(:,:,4) = v(2:end-1,1:end-2);
%         w(:,:,5) = v(2:end-1,2:end-1);
%         w(:,:,6) = v(2:end-1,3:end-0);
%         w(:,:,7) = v(3:end-0,1:end-2);
%         w(:,:,8) = v(3:end-0,2:end-1);
%         w(:,:,9) = v(3:end-0,3:end-0);
%         v(2:end-1,2:end-1) = ...
%             (sum(w,3) - min(w,[],3)) ./ 8; 
%     end
%     betadiv = v;
    
