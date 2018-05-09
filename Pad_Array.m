function array = Pad_Array(array, m)

if m==0, return; end
dims = size(array);
padding = Make_Padding(array, m);

if dims(2)>dims(1)
    % Pad array as row
    array = [array,padding];
else
    % Pad array as column
    array = [array;padding];    
end 
