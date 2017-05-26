function instr_tasks = Find_Instrument_Tasks(tasks, instr_str)
	instr_tasks = tasks(not(cellfun(@isempty,regexp(tasks,[instr_str,'_(\w)']))));
end