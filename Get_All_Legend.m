function h_leg = Get_All_Legend(h_fig)
	if nargin==0, h_fig = gcf; end
	
	h = get(h_fig,'children');
	h_leg = [];
	i_leg = 0;
	for k = 1:length(h)
		if strcmpi(get(h(k),'Tag'),'legend')
			i_leg = i_leg+1;
			h_leg(i_leg) = h(k);
			%break;
		end
	end