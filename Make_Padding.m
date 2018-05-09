function padding = Make_Padding(array, m)

dims = size(array);
assert(numel(dims)<3, 'No of array dimensions can not be more than 2')
assert(dims(1)==1 || dims(2)==1, 'Input given is a matrix, i.e. having more than 1 non-signleton dimensions')

if iscellstr(array)
    
    % Padding for cell array of strings (all cells contains strings)
    padding_fun = @(m,n) cellstr(repmat(' ',m,n));
    
elseif isnumeric(array)
 
    % Padding all types of numeric arrays
    padding_fun = @(m,n) nan(m,n);
 
else
    
    switch class(array) 
    
        case 'cell'
            % Padding for cell arrays containing not only strings, possibly with mixed
            % data types
            padding_fun = @(m,n) strings(m,n);

        case 'string'
            padding_fun = @(m,n) strings(m,n);
            
        case 'char'
            padding_fun = @(m,n) repmat(' ',m,n);

        case 'datetime'
            padding_fun = @(m,n) nat(m,n);

        case 'categorical'
            padding_fun = @(m,n) categorical(m,n);
            
        otherwise
            error(['Padding of an array of type ',class(array),' is not implemented'])
 
    end
end

if dims(2)>dims(1)
    % Pad array as row
    padding = padding_fun(1,m);
else
    % Pad array as column
    padding = padding_fun(m,1);    
end 

