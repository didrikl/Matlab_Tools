function Print_Summary(summary,max_cols,max_rows)

if nargin<3, max_rows = 20; end
if nargin<2, max_cols = 10; end

cols = fieldnames(summary.Columns);
fprintf('\n\nValues summary:\n\n')
for i=1:numel(cols)
    col_name = cols{i};
    col = summary.Columns.(col_name);
    
    if strcmpi(col.col_type,'cell')
               
        % Summary of unqiue values printet to screen
        fprintf([col_name,'\n\tUnique values:\n'])
        Pretty_Print_Array(col.unique_values{:,1}, max_cols, max_rows);
        
    elseif strcmpi(col.col_type,'numeric')
        
        % Summary of unqiue values printet to screen
        fprintf([col_name,'\n\n'])
        non_empty_bins = col.value_bins.bin_counts>0;
        disp(col.value_bins(non_empty_bins,:));
        
    end
        
end