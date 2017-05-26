function Integrate_FS_Check(handles)

fs = handles.integrate_fs_edit.String;

if isempty(fs)
	handles.integrate_fs_edit.BackgroundColor = handles.setting_gui_figure.UserData.unspecified_col;
	handles.integrate_fs_edit.UserData.is_unspecified = true;
	handles.integrate_fs_info_text.Visible = 'on';
else
	handles.integrate_fs_edit.BackgroundColor = handles.setting_gui_figure.UserData.specified_col;
	handles.integrate_fs_edit.UserData.is_unspecified = false;
	handles.integrate_fs_info_text.Visible = 'off';
end



%if handles.output.EM.Proc_Interpolate_fs ~= handles.output.ML.Proc_Interpolate_fs