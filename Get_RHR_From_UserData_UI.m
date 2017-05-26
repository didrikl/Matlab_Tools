function RHR = Get_RHR_From_UserData_UI(userdata)
	
	if not(isfield(userdata, 'RHR'))
		fprintf('\n\tRHR reference value not stored in table.Properties.UserData.RHR\n')
		options.Resize='on';
		RHR = inputdlg({'Resting heart rate (HR_min)','Max heart rate (HR_max)'},...
			'Input needed',[1 35],{'',''},options);RHR = RHR{1};	
		fprintf(['\tUser-input for RHR: ',RHR,'\n']);
	
	else
		RHR = userdata.RHR;
	end
	
	if ischar(RHR), RHR = str2double(RHR); end