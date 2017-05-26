function Save_Table_UI(tab, save_path, save_data, fieldname)
% save table as .mat file with name processing step tags

if nargin<4, fieldname = 'data'; end
if nargin<3, save_data = true; end
global INTERACTIVE_MODE

fprintf('\nSave table')
if not(istable(tab))
    Warn(['\n\t\tData to be saved is not a table',...
          '\n\t\tData not saved.'], '\t')
		  
elseif isempty(tab.Properties.UserData.save_tags)
    Warn(['\n\t\tProperties.UserData.save_tags for table is missing',...
          '\n\t\tNo file name could be created',...
          '\n\t\tData not saved.'], '\t')
		  
else
    
    if not(isfield(tab.Properties.UserData,'save_tags'))
        save_name = 'Untiteled';
	else
		save_name = [strjoin(tab.Properties.UserData.save_tags,'_'),'.mat'];
    end
    
    if INTERACTIVE_MODE
		fprintf(['\n\tFile name: ',save_name,'\n'])
		opt_no = Ask_List({'Save', 'Save with other file name','Do not save'},'',1,'\t');
		if opt_no==3, return; end
		if opt_no==2, save_name = ...
            input(sprintf('\tGive file name (extension not needed)--> '),'s'); end		
    elseif not(save_data), 
		fprintf('\n\tSaving is put to false in job card\n'); 
		return
    end
    
    
    Save_As_MAT( tab, save_name, save_path, fieldname );
end
