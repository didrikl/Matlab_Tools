function [marked_xlim,h_shade] = Mark_Sync_Range(h_fig, h_axes_to_shade, h_shade)
    
	fprintf('\n\t\tClick and drag to mark a range now...\n\t\t(point mark = full range)\n');
	rect = getrect2(h_fig);
	marked_xlim = [rect(1),rect(1)+rect(3)];
	
	% if only a point/vertical line is selected, then make it the full range
	if rect(3)==0
		marked_xlim = get(gca,'xlim'); 
	end
	
	% shade handles to update (by deleting first)
	if nargin==3
		delete(h_shade(ishandle(h_shade)))
	end
	
	n_axes = length(h_axes_to_shade);
	h_shade = nan(1,n_axes);
	for i=1:n_axes
		h_shade(i) = ShadeRange(marked_xlim,'y',0.2,h_axes_to_shade(i));
	end
	
	