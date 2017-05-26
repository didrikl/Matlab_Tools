function Shift_Plot_Lines(h_plt,y,D)
	% Aligning the signals plotted to visualize if the delay found is good.
	% removed/truncated, and if so some nan entries are introduced at the
	% end to retain number of samples. Vice versa applies if D is negative.
	
	if iscell(y)
		for i=1:length(y)
			if D>0
				y{i} = [y{i}(D+1:end),nan(1,D)];
			elseif D<0
				D = -D;
				y{i} = [nan(1,D),y{i}(1:end-D)];
			end
			set(h_plt(i), 'YData', y{i})
		end
	else	
		if D>0
			y = [y(D+1:end),nan(1,D)];
		elseif D<0
			D = -D;
			y = [nan(1,D),y(1:end-D)];
		end
		set(h_plt, 'YData', y)
	end
	
	
