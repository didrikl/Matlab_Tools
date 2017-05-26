function intervals = Input_Time_Range_GUI(old_interv, num_lines)
	
	if nargin<1
		old_interv = '';
	end
	if nargin<2
		num_lines = 3;
	end
	
	if isempty(old_interv) && num_lines>1
		defaultans = {char({'00:00:00 - 01:00:00';'10:00:00 - 12:00:00'})};
	elseif isempty(old_interv) && num_lines==1
		defaultans = {'10:00:00 - 12:00:00'};
	else
		defaultans = old_interv;
	end
	
	prompt = {sprintf([...
		'Interval specficiations:',...
		'\nhh:mm:ss - hh:mm:ss'])};
	if num_lines>1
		prompt{1} = [prompt{1},'\n\n(One line per interval)'];
	end
	
	dlg_title = 'Input for extracting time interval(s)';
	answer = inputdlg(prompt,dlg_title,num_lines,defaultans);
	
	intervals = '';
	if isempty(answer), return; end
	
	intervals = cellstr(answer{1});