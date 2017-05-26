function id = Get_ID_From_UserData(userdata)
    
    try 
        id = userdata.save_tags{1};
    catch
        fprintf('\n\tID is not given in table.Properties.UserData.save_tags{1}\n')
        options.Resize='on';
		id = inputdlg(sprintf('Give ID folder name'),...
			'Input needed',[1 35],{''},options);
		id = id{1};
		fprintf(['\tUser-input for ID folder name: ',id,'\n']);
	end
	
	
    