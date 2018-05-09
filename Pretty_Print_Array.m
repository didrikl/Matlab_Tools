function array = Pretty_Print_Array(array, max_cols, max_rows)
% Print an array in controlled columns

% Always work with one column
array = reshape(array,numel(array),1);
    
% Re-arrange into columns, if no. of rows is excessive. No. of cols to
% be displayed in the terminal window is set by max_cols.
n_elem = numel(array);
n_cols = ceil(n_elem/max_rows);
if n_elem>max_rows
    
    % If padding might be needed to have full columns of equal length 
    n_padding_entries = max_rows-mod(n_elem,max_rows);
    if n_padding_entries==max_rows
        n_padding_entries = 0;
    end
    
    n_cols = ceil(n_elem/max_rows);
    array = Pad_Array(array, n_padding_entries);
    array = reshape(array,max_rows,n_cols);
    
end

% Print to screen if output is not assigned in the calling code
if nargout==0
    if max_cols<n_cols
        disp(array(:,1:max_cols))
        fprintf('\t...\n\tMore columns can be seen by manual inspection\n\n')
    else
        disp(array)
    end
end
% col_sep_width = 1;
% fun = @(x) length(x);
% col_width = max(cellfun(fun,string_arr))+col_sep_width;
% if mod(j-1,no_of_cols)==0,
%         fprintf(['\n',indent]);
%     else
%         spaces = repmat(' ',col_width-length(string_arr{j-1}),1)';
%         fprintf([', ',spaces]);
%     end
% else
%     if mod(j-1,no_of_cols)==0,
%         str = sprintf(['\n',indent]);
%     else
%         spaces = repmat(' ',col_width-length(string_arr{j-1}),1)';
%         str = sprintf([', ',spaces]);
%     end
% end
