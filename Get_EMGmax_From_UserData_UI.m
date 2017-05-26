function EMGmax = Get_EMGmax_From_UserData_UI(userdata)
	
	if not(isfield(userdata, 'EMGmax'))
		fprintf('\n\tEMG reference values not stored in table.Properties.UserData.EMGmax\n')
		options.Resize='on';
		EMGmax = inputdlg(sprintf('Give EMGmax reference value (mV)'),...
			'Input needed',[1 35],{''},options);
		EMGmax = EMGmax{1};
	
		fprintf(['\tUser-input for EMGmax: ',EMGmax,'\n']);
	
	else
		EMGmax = userdata.EMGmax;
	end
	
	if ischar(EMGmax), EMGmax = str2double(EMGmax); end