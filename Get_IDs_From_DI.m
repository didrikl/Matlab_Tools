function ids = Get_IDs_From_DI(di)
	n_id = length(di);
	ids = cell(n_id,1);
	j = 1;
	for i=1:n_id
		if not(isempty(di{i}))
			ids{j} = Get_ID_From_UserData(di{i}.Properties.UserData);
			j = j+1;
		end
	end
	
	if j<n_id
		ids(j+1:end) = [];
	end
	
	ids(cellfun(@isempty,ids)) = [];
