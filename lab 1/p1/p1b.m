% Aysar Khalid
% Problem 1: Detecting Lines
% The following function completes tasks (1)-(6) of the problem.
function [ ] = p1b(I_c, D, N, F)
    if nargin ~= 4
       error('Invalid input arguments.')
    end  
     C_max = -1;
     C_max_edge_points_ids = 0;
     for m=1:N
         display(sprintf('--- Iteration %d',m));
         
         % Select to edge points at random
         p1_id =randsample(find(I_c),1);
         p2_id =randsample(find(I_c),1);
         
         % Ensure both points are different
         while (p2_id == p1_id)
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
         % sanity check that p1 and p2 belong to line
         %dot(line, [p2_i,p2_j,1]) 
         distfn = @lineptdist;
         
         % Get edge points within D pixels from line
         [points_within_D, M] = feval(distfn, [p1_j p2_j; p1_i p2_i; 1 1], I_c, D);
         C = intersect(find(I_c),points_within_D);
         if (length(C) > C_max)
             C_max = length(C);
             C_max_edge_points_ids = C;
             p1_j_max = p1_j;
             p1_i_max = p1_i;
             p2_j_max = p2_j;
             p2_i_max = p2_i;
         end
     end
     
     C_max_edge_points = [];
     for i=1:C_max
         [p_i,p_j] = ind2sub(size(I_c), C_max_edge_points_ids(i));
         C_max_edge_points = cat(2,C_max_edge_points,[p_j;p_i;1]);
     end
     
     % plot canny edge
     figure;
     imshow(I_c,'InitialMagnification','fit');
     title('Canny edge');
     hold on;
     
     %plot line on image
	 plot([p1_j_max p2_j_max],[p1_i_max p2_i_max], 'Color','b','LineStyle',':');
     
     % get line of best fit via least squares
     if (C_max > 1)
         abc = fitline(C_max_edge_points);
         abc2 = fitline_ls(C_max_edge_points,[], 0);
         
         % plot our edge points
         plot(C_max_edge_points(1,:),C_max_edge_points(2,:), 'mo');
         
         % overlay fitting line on image
         yy = (-abc(1) / abc(2))*C_max_edge_points(1,:) + (-abc(3) / abc(2));
         plot(C_max_edge_points(1,:),yy, 'Color','r','LineStyle','-','LineWidth',3);
         yy2 = (-abc2(1) / abc2(2))*C_max_edge_points(1,:) + (-abc2(3) / abc2(2));
         plot(C_max_edge_points(1,:),yy2, 'Color','g','LineStyle','-','LineWidth',2);
         
         % remove and detect next line
         if (F > 1)
            p1c(I_c, abc, C_max_edge_points, F);
         end
     else
         display('No edge points found');
     end
     hold off;
     display('--- DONE');
end

