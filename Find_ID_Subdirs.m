function subdirs = Find_ID_Subdirs(basepath,filter)
	file_list = dir(fullfile(basepath,filter));
	dirIndex = [file_list.isdir];  % Find the index for directories
	subdirs = {file_list(dirIndex).name}'; % Get a list of the files
	subdirs(ismember('.',subdirs)) = [];
	subdirs(ismember('..',subdirs)) = [];
	subdirs = sort_nat(subdirs);
end