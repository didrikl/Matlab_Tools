function fs = Get_FS_From_UserData_UI(userdata)
	
	if not(isfield(userdata, 'fs'))
		fprintf('\n\tSampling freqency is not given in table.Properties.UserData.fs\n')
		options.Resize='on';
		fs = inputdlg(sprintf('Give sampling frequency (Hz)'),...
			'Input needed',[1 35],{''},options);
		fs = fs{1};
		fprintf(['\tUser-input for fs: ',num2str(fs),'\n']);
	else
		fs = userdata.fs;
	end
	
	if ischar(fs), fs = str2double(fs); end