function [id, ml, em, ag, hr, fn] = Preprocess_CLI(id, ml, em, ag, hr, fn, config)
	
	ml = process_individual_data_types(ml, fn, config, 'ML');
	em = process_individual_data_types(em, fn, config, 'EM');
	ag = process_individual_data_types(ag, fn, config, 'EM');
	hr = process_individual_data_types(hr, fn, config, 'HR');
	
	%id = process_individual_data_types(id, fn, config, 'HR');
	
	% any non-optional pre-processing tasks...
    fn  = FN_Proc_QC(fn, config);
    fn  = FN_Proc_Insert_TimeCols(fn, config);
	
end

function data_proc = process_individual_data_types(data, fn, config, module)
    module_config = config.(module);
    save_path = module_config.save_path;
    
    global PHYSPROC_DIR
    global CHOOSE_ALWAYS_DEFAULT_IN_OPTION_LIST
    CHOOSE_ALWAYS_DEFAULT_IN_OPTION_LIST = false;
    global ABORT_ON_ERR;
    ABORT_ON_ERR = false;

    Welcome('Interactive mode processing')
    if isempty(data), Warn(['Empty ',module,' table']); end
      
    % define user interaction menu
    module_path = fullfile(PHYSPROC_DIR,'SourceCode','Preprocess');       
        
    % Processing menu
    fun_list = Get_File_Name_List_From_Pattern(module_path, [module,'_Proc_*.m']);
    extra_opt_list = {...
            'Continue'
            'Revert processed data to initialized data'
            'Update paramter settings'
            'Save table to .mat file on disc'
            'Read/(re-)initialize from .mat file on disc'
            'Read/(re-)initialize from "raw" file(s) on disc'
            'Store a temporary data table copy in memory'
            'Use a temporary data table copy in memory'
            };
    opt_list = [extra_opt_list; fun_list];
    
    % let data be a copy of originally initialized data
    data_proc = data;
    
    while true
        fprintf('\n')
        cprintf('*black',sprintf(['Processing ',module]))
        opt = Ask_List(opt_list,'\n\nTask and I/O options',1,''); 
        if opt==1
            break;
        elseif opt==2
            data_proc = data;   
        elseif opt==3
            module_config = update_config(module_config);
            config.(module) = module_config;
        elseif opt==4
            Save_Table_UI(data_proc, save_path, true);
        elseif opt==5
            init_fun = str2func( [module,'_Init_Matlab']);
            data_proc = init_fun(config);
            data = data_proc;
        elseif opt==6
            init_fun = str2func( [module,'_Init_Raw']);
            data_proc = init_fun(config);
            data = data_proc;
        elseif opt==7
            name = input(sprintf('Give name (fieldname) for memory copy --> '),'s');
            eval([name,'=data_proc;']);
        elseif opt==8
            name = input(sprintf('Give name of table in memory (fieldname) --> '),'s');
            eval(['data=',name,';']);
        elseif opt>length(extra_opt_list)    
            [~,fun_name,~] = fileparts(opt_list{opt});
            fun = str2func(fun_name);
            data_proc = fun(data_proc, config, fn);
        end
        
        fprintf('\nDone.\n')
        if isempty(data_proc)
            Warn('\nProcessed data is empty!'); 
        else
            % print some useful info after processing
            if opt~=1 && opt~=3 && opt~=4 && opt~=7
                fprintf(['\nSize of table: ',mat2str(size(data_proc,1)),...
                    ' rows and ',mat2str(size(data_proc,2)),' columns\n'])
            end
        end
        
    end
end

function config = update_config(config)
    % user interaction for updating a setting in a config structure
    
    % make a list of config names
    option_names = fieldnames(config);
    no_of_char = zeros(length(option_names),1);
    
    % add config values to corresponding names in a nicely formatted list
    for i = 1:length(option_names)
        no_of_char(i) = length(option_names{i});
    end
    base_width = max(no_of_char)+4;
    for i = 1:length(option_names)
        fieldvalue = getfield(config,option_names{i});
        if isempty(fieldvalue)
            fieldvalue = '[empty]';
        elseif iscell(fieldvalue)
            try
                fieldvalue = strjoin(fieldvalue);
            catch
                fieldvalue = '[cell array]';
            end
        elseif isnumeric(fieldvalue)
            fieldvalue = num2str(fieldvalue);
        elseif fieldvalue==true
            fieldvalue = 'true';
        elseif islogical(fieldvalue) && fieldvalue==true
            fieldvalue = 'true';
        elseif islogical(fieldvalue) && fieldvalue==false
            fieldvalue = 'false';
        elseif ischar(fieldvalue)
            fieldvalue = strrep(fieldvalue,'\','\\');
        else
            fieldvalue = '[value]';
        end
        options{i} = [option_names{i},repmat('.',1,base_width-no_of_char(i)),fieldvalue];
    end
    
    options{end+1} = 'Cancel';
    default = length(options);
    opt_no = Ask_List(options,'\n\tSelect which setting to change',default,'\t');
    if opt_no == length(options), return; end
    opt = option_names{opt_no};
    
    % update the setting within the config struct
    %if isstruct(option), update_config(config.(option)); end
    %fprintf(['\n\tCurrent setting: ',config.(option),'\n'])
    while true
        try
            new_setting = input(sprintf('\tGive new setting --> '));
            break
        catch
            fprintf('\n\tIncorrect input. Try again...')
        end
    end
    config.(option_names{opt_no}) = new_setting;
end