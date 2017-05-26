function h_gl = Plot_Peak_Guideline(h_axes, base_no, xdata, ydata, h_gl)
	% Make (plot) a guide line thoughout all panels located the ydata-peak in axis no
	% with given number in base_no.
	
	zoom_xlim = get(h_axes(base_no),'Xlim');
	zoom = find(xdata{base_no}>=zoom_xlim(1) & xdata{base_no}<=zoom_xlim(2));
    [~,zoom_max_ind] = max(ydata{1}(zoom));
    x_gl = xdata{1}(zoom_max_ind+zoom(1)-1);	
	
	% shade handles to update (by deleting first)
	if nargin==3
		delete(h_gl(ishandle(h_gl)))
	end
	
	n_axes = length(h_axes);
	h_gl = nan(1,n_axes);
	for i=n_axes:-1:1
		h_gl(i) = line([x_gl x_gl], ylim(h_axes(i)), ...
			'Parent', h_axes(i),...
			'Color', [.9 .1 .9],...
			'LineWidth', 0.5);
	end
