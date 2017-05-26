function [inds, act] = Get_Activity_Inds_UI(data, act, act_col_name_expr)
    % Make a logical array of row indices that has a given activity stored in the
    % Activity column or in one or more parallell activity columns
    
	if nargin<3
		act_col_name_expr = '.*Act.*';
	end
		
    vars = data.Properties.VariableNames;
    act_col_ind = find(not(cellfun(@isempty,regexpi(vars,act_col_name_expr))));
    options = cellstr(unique(data{:,act_col_ind}));
    inds = false(height(data),length(act_col_ind));
    
    if not(ismember(act,options));
        Warn('Activity not found','\t')
        options{end+1} = 'Cancel task...';
        options{end+1} = 'Proceed task with no activity match...';
        n_opt = length(options);
        act_num = Ask_List(options,'Choose another activity?',n_opt,'\t');
        if act_num==n_opt-1,
            act = '';
            return;
        elseif act_num==n_opt
            return
        end
        act = options(act_num);
    end
    
    inds = false(height(data),length(act_col_ind));
    for i=1:length(act_col_ind)
        inds(:,i) = data.(vars{act_col_ind(i)})==act;
    end
    inds = logical(sum(inds,2));
   