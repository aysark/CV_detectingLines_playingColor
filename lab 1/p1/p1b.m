function [ ] = p1b( )
     %close all;
     D = 1;
     N = 100;
     I = rgb2gray(imread('images/small2.png'));
     %I = rgb2gray(imread('images/coins.jpg'));
     %I = rgb2gray(imread('images/b_rect.jpg'));
     subplot(1,2,1);
     imshow(I);
     title('Original');
     
     I_c = edge(I,'canny');
     C_max = -1;
     for m=1:N
         C_edge_points = [];
         p1_id = randsample(find(I_c),1);
         p2_id = randsample(find(I_c),1);
         while (p2_id == p1_id) %ensure both points are different
            p2_id = randsample(find(I_c),1);
         end
         if (p1_id > p2_id)
             t = p1_id;
             p1_id = p2_id;
             p2_id = t;
         end
         [p1_i,p1_j] = ind2sub(size(I_c),p1_id);
         [p2_i,p2_j] = ind2sub(size(I_c),p2_id);
         line = cross([p1_i,p1_j,1],[p2_i,p2_j,1]);
         line_n = line / sqrt(line(1)^2 + line(2)^2); %normalize
         % sanity check that p1 and p2 belong to line
         %dot(line, [p2_i,p2_j,1]) 
         C = 0;
         col_size = size(I_c,1);
         if (p1_i == p2_i)
            line_ids = [p1_id:6:p2_id];
         else
            line_ids = [p1_id:p2_id];
         end
         for i=(p1_id - D*col_size - 1):(p2_id + D*col_size +1)
            if (i > 0 && i < (col_size*size(I,2)) && I_c(i) == 1)
               if ((~ismember(i,[p1_id:p2_id])) && (ismember(i-D,[p1_id:p2_id]) || ismember(i+D,[p1_id:p2_id]) || ismember(i-D + col_size,[p1_id:p2_id]) || ismember(i-D - col_size,[p1_id:p2_id]) || ismember(i - col_size,[p1_id:p2_id]) || ismember(i + col_size,[p1_id:p2_id]) || ismember(i + D - col_size,[p1_id:p2_id]) || ismember(i + D + col_size,[p1_id:p2_id]) )) 
                   C = C + 1;
                   [ep_i,ep_j] = ind2sub(size(I_c),i);
                   %C_edge_points = [C_edge_points(1,:) ep_x; C_edge_points(2,:) ep_y]
                   C_edge_points = cat(2,C_edge_points,[ep_j;ep_i;1]);
               end
            end
         end
         if (C > C_max)
             C_max = C;
             C_max_edge_points = C_edge_points;
             p1_j_max = p1_j;
             p1_i_max = p1_i;
             p2_j_max = p2_j;
             p2_i_max = p2_i;
         end
     end
     [abc, dist] = fitline(C_max_edge_points);
      %line_coefficients
      abc2 = fitline_ls(C_max_edge_points, [1:C_max])
%      -line_coefficients(1)*C_max_edge_points(1,:)+line_coefficients(3)
     subplot(1,2,2);
     imshow(I_c);
     title('Canny edge');
     hold on;
     %plot line on image
     
	 plot([p1_j_max p2_j_max],[p1_i_max p2_i_max], 'Color','b','LineStyle',':');
     yy = (-abc(1) / abc(2))*C_max_edge_points(1,:) + (-abc(3) / abc(2));
     plot(C_max_edge_points(1,:),yy, 'Color','g','LineStyle','-','LineWidth',3);
     yy2 = (-abc2(1) / abc2(2))*C_max_edge_points(1,:) + (-abc2(3) / abc2(2));
     plot(C_max_edge_points(1,:),yy2, 'Color','m','LineStyle','-','LineWidth',3);
     plot(C_max_edge_points(1,:),C_max_edge_points(2,:), 'ro');
     hold off;
%      %first get all the pixels that are 1pixel away from edge
%      filter = [1 1 1; 1 -9 1; 1 1 1];
%      
%      line_feather = I_c((p1_id-size(I_c,1)):(p2_id+size(I_c,1)))
%      filtered = conv2(double(I_c(p1_i:p2_i,p1_j:p2_j)), filter, 'same')
%      subplot(2,2,3);
%      I_c(p1_i:p2_i,p1_j:p2_j)
%      %I_c([p1_id:p2_id])
%      imshow(filtered);
%      title('Canny filtered');
     
end

