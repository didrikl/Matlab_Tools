function Save_Figure_UI(save_path, file_name, save_fig)

if nargin<3, save_fig = true; end
global INTERACTIVE_MODE

fprintf('\nSave figure')

if INTERACTIVE_MODE
    fprintf(['\n\tFile name: ',file_name,'.mat\n'])
    opt_no = Ask_List({'Save', 'Save with other file name','Do not save'},'',1,'\t');
    if opt_no==3, return; end
    if opt_no==2, file_name = input(sprintf('\tGive new file name --> '),'s'); end			
elseif not(save_fig), 
    fprintf('\n\tSaving is put to false in job card\n'); 
    return
end

Save_Figure(file_name, save_path)
