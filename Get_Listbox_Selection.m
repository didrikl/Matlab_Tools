function selected = Get_Listbox_Selection(hObject)
	contents = cellstr(hObject.String);
	val = get(hObject,'Value');
	selected = contents(val);
