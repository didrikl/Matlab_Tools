function tab = Add_Column(tab,col,name)
% Add new column array of possibly unequal length to a table.
% Empty values will be padded in the table if the column is longer the table's
% height, and vice-versa is the array padded if the the column is shorter.
% Padding is done with empty values of the matching data type. 
% 
% Input:
%    tab (table) : Table to be added with new column
%    col (array*): Column to add
%
% Optional input:
%    name (string) : Column name in table. 
%
% If name is not given, then input column must be an assigned variable, f.ex.
% c=[1;2];
% t = Add_Column(t,c)
%
% *Supported array types is the same as supported by Make_Padding.
%
% See also
%     MAKE_PADDING, PAD_ARRAY

if nargin<3, name = inputname(2); end
assert(not(isempty(name)),['Column name must be given though input',...
    ' either as a assigned variable or with explisit input']);

if not(isempty(tab))    
    no_row_diff = height(tab)-numel(col);
    if no_row_diff>0
        col = Pad_Array(col, no_row_diff);
    elseif no_row_diff<0
        tab = varfun(@(t)Pad_Array(t,-no_row_diff), tab);
        tab.Properties.VariableNames = ...
            erase(tab.Properties.VariableNames,'Fun_');
    end
end

valid_name = genvarname(name);
if not(strcmp(name,valid_name))
    fprintf('\n')
    warning('Variable name has been modified to be valid')
    fprintf('\n')
end
tab.(valid_name) = col;