function weight = Get_Weight_From_UserData(userdata)

	if not(isfield(userdata, 'weight'))
	    fprintf('\n\tParticipant ID''s body weight is not given in table.Properties.UserData.weight\n');
		options.Resize='on';
		weight = inputdlg('Participant ID''s body weight (kg)',...
			'Input needed',[1 35],{''},options);
		weight = weight{1};
		fprintf(['\tUser-input for weight: ',weight,'\n\n']);
	else
		weight = userdata.weight;
	end

	if ischar(weight), weight = str2double(weight); end
