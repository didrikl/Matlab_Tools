function Single_Or_Double_Click(hObject, eventdata, handles, ...
		single_click_callback,double_click_callback)
	% Splitting a GUI callback into a single or double click callbacks. 
	
	% Use a delay to distinguish single click from a double click: If an extra click 
	% within the pause delay, then the else-statement will be true for the extra click.
	persistent chk
	if isempty(chk)
		chk = 1;
		pause(0.25);
		if chk == 1
			single_click_callback(hObject, handles);
			chk = [];
		end
	else
		chk = [];
		double_click_callback(hObject, handles);		
	end
