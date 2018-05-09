function Summary = Make_Summary(data)

% Inspect non-numeric columns
Summary = struct;
Summary.Table = struct;
Summary.Columns = struct;

n_bins = 10;

non_numeric_values = table;
topsorted_non_numeric_values = table;
numeric_values = table;
for i=1:width(data)
    
    col_summary = struct;
    col = data{:,i};
    col_name = data.Properties.VariableNames{i};
    
    % Inspect columns stored as cell arrays of strings
    if(iscell(col))
        
        cellarr_types = cellfun(@class,col,'UniformOutput', false);
        [unique_cellarr_types, IA, IC] = unique(cellarr_types);
        cellarr_types_count=histc(IC,1:numel(IA));
        col_summary.col_type = 'cell';
        col_summary.content_type = 'cell array of: ' + join( string(cellarr_types_count)+...
            " "+string(unique_cellarr_types), ', ');
                
        % Summary of column
        [unique_vals, unique_vals_count, unique_val_length] = ...
            get_unique_value_summary(col);
         [topsorted_unique_vals_count, mapping_inds] = sort( unique_vals_count, 'descend' );
        %[top_unique_vals_count, mapping_inds] = topkrows(unique_vals_count,10);
        topsorted_unique_vals = unique_vals(mapping_inds);
        
        col_summary.n_empty = sum(cellfun(@isempty,col));
        col_summary.n_unique_values = numel(unique_vals);
        col_summary.longest_value = max(unique_val_length);
        col_summary.unique_values = table(unique_vals, unique_vals_count, unique_val_length,...
            'VariableNames', {'value','occurences_count','value_length'});
        col_summary.topsorted_unique_values = table(topsorted_unique_vals,topsorted_unique_vals_count,...
            'VariableNames', {'value','occurences_count'});
        
        % Summary for the summary of whole table
        non_numeric_values = Add_Column(non_numeric_values,unique_vals,['Value_',col_name]);
        non_numeric_values = Add_Column(non_numeric_values,unique_vals_count,['ValueCount_',col_name]);
        topsorted_non_numeric_values = Add_Column(topsorted_non_numeric_values,topsorted_unique_vals,['Value_',col_name]);
        topsorted_non_numeric_values = Add_Column(topsorted_non_numeric_values,topsorted_unique_vals_count,['ValueCount_',col_name]);
        
    elseif isnumeric(col)
        
        [bin_counts, bin_edges] = histcounts(col,n_bins);
        
        col_summary.min = min(col);
        col_summary.max = max(col);
        col_summary.mean = mean(col);
        col_summary.median = median(col);
        col_summary.mode = mode(col);
        col_summary.col_type = 'numeric';
        col_summary.col_content = class(col);
        col_summary.value_bins= table(bin_edges(1:end-1)',bin_edges(2:end)',bin_counts',...
            'VariableNames', {'bin_lower_edge','bin_upper_edge','bin_counts'});
        
        % Summary for the summary of whole table
        numeric_values = Add_Column(numeric_values,bin_edges(1:end-1)',['bin_lower_edge_',col_name]);
        numeric_values = Add_Column(numeric_values,bin_edges(2:end)',['bin_upper_edge_',col_name]);
        numeric_values = Add_Column(numeric_values,bin_counts',['bin_counts_',col_name]);
        
    end
    
    Summary.Columns.(col_name) = col_summary;
    
end

Summary.Table = fill_col_types_in_table_summary(Summary.Table,data);
Summary.Table.n_rows = height(data);
Summary.Table.n_columns = width(data);
Summary.Table.n_numeric_columns = sum(varfun(@isnumeric,data,'output','uniform'));
Summary.Table.n_cellstr_columns = sum(varfun(@iscellstr,data,'output','uniform'));
Summary.Table.values_non_numeric = non_numeric_values;
Summary.Table.values_topsorted_non_numeric = topsorted_non_numeric_values;
Summary.Table.values_numeric = numeric_values;

end

function table_summary = fill_col_types_in_table_summary(table_summary,data)

col_types = table2cell(varfun(@class,data));
unique_col_types = unique(col_types);
for i=1:numel(unique_col_types)
    table_summary.("n_"+unique_col_types{i}+"_columns") = ...
        sum(strcmp(col_types,unique_col_types{i}));
end

end

function [vals, vals_count, vals_length] = get_unique_value_summary(col)
% Get summary of unique cell array values. Cell arrays of characters/string
% and/or of numeric data is supported.

if not(iscellstr(col))
    char_inds = find(cellfun(@ischar,col));
    [unique_num_vals, num_IA, num_IC] = unique(cell2mat(col(not(char_inds))));
    [unique_str_vals, str_IA, str_IC] = unique(col(char_inds));
    unique_str_vals_count=histc(str_IC,1:numel(str_IA));
    unique_num_vals_count=histc(num_IC,1:numel(num_IA));
    vals = [cellstr(unique_str_vals);num2cell(unique_num_vals)];
    vals_count = [unique_str_vals_count;unique_num_vals_count];
else
    [vals, IA, IC] = unique(col);
    vals = cellstr(vals);
    vals_count=histc(IC,1:numel(IA));
end
vals_length = cellfun(@length,vals);

end
