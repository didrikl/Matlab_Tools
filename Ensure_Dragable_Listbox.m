function Ensure_Dragable_Listbox(hObject, string)
	% Redefine listbox to support re-ordering by mouse dragging
	% (this doesn't work in the GUI object create function, therefore done here)
	if not(isfield(hObject.UserData,'is_dragable'))
		hObject.UserData.is_dragable = false;
	end
	
	if not(hObject.UserData.is_dragable)
		pos = hObject.Position;
		hObject = reorderableListbox2( hObject );
		hObject.String = string;
		hObject.Position = pos;
		hObject.UserData.is_dragable = true;
	end
	