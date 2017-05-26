Environment_Defaults                     % import Matlab environment settings
retain_in_memory
PhysProc_Defaults                        % import defaults for all settings
retain_in_memory  

% =========================================================================================================================
%  WHAT PARTICIPANT ID AND DATA TYPES TO PROCESS, AND WHICH/ORDER OF PROCESSING TASKS
% =========================================================================================================================

config.ID.dir       = {'ID803'};      % ID subject folder, located at read/save base paths 
config.ID.remark    = 'No remarks';   % execution remarks for the log file
                                      % ******** Medilogic data to read **************************************************
%config.ML.Init_type = 'raw';          % read "csv" text files
%config.ML.Init_type = 'lund';         % read binary .mat files
%config.ML.Init_type = 'matlab';       % read binary .mat files
                                      % ******** EMG data to read ********************************************************
%config.EM.Init_type = 'raw';          % read raw S00 files
%config.EM.Init_type = 'lund';         % read binary .mat files
%config.EM.Init_type = 'matlab';       % read binary .mat files
                                      % ******** ActiGraph data to read **************************************************
%config.AG.Init_type = 'raw';          % read "csv" text files and derived activity from Acti4
%config.AG.Init_type = 'matlab';       % read binary .mat files

%config.HR.Init_type  = 'raw';         % read "csv" text files and derived activity from ActiHeart
%config.HR.Init_type  = 'matlab';      % read binary .mat files
%config.HR.Init_type  = 'none';        % read no files

config.EM.Init_Raw_ch_order           = {'Ch3','Ch4','Ch1','Ch2'};

config.ID.tasks = {                   % ********** Available EMG tasks **************************************************                             
    %'EM_Proc_Insert_Time'             % insert a column of elapsed time (sec) derived from the sampling frequency
    %'EM_Proc_QC'                     % quality control (QC), artifact removal, RMS resampling w/ baseline noise removal
    %'EM_Proc_Interpolate'             % time-interpolation (as resampling)
    %'EM_Proc_Insert_TimeStamp'        % insert time stamp column, interpolated from field notes
    %'EM_Proc_Insert_Activity'         % insert field notes activity info (categorical column) at all rows
    %'EM_Proc_Extract_Activity'        % reduce data to belonging to a certain activity only (parallell activities incl.)
    %'EM_Proc_Exclude_Activity'        % remove or substitute rows belonging to a given activity (parallell act. incl.)
    'EM_Proc_Extract_Time'            % reduce data to one or more intervals given by time stamps    
                                      % ********** Available Medilogic tasks ********************************************
    %'ML_Proc_Aggregate'               % aggregate data by row-wise summarizing left, right and all sensor recordings
    %'ML_Proc_Interpolate'             % time-interpolation (as resampling)
    %'ML_Proc_Insert_TimeStamp'        % insert time stamp column, interpolated from field notes
    %'ML_Proc_Insert_Activity'         % insert field notes activity info (categorical column) at all rows
    %'ML_Proc_Extract_Activity'        % reduce data to belonging to a certain activity only (parallell activities incl.)
    %'ML_Proc_Exclude_Activity'        % remove or substitute rows belonging to a given activity (parallell act. incl.)
    %'ML_Proc_Extract_Time'            % reduce data to one or more intervals given by time stamps
	                                  % ********** Available ActiGraph tasks ********************************************	
    %'AG_Proc_Extract_Day1'            % extract data from day 1, to avoid ambiguity in time stamps without date info
	%'AG_Proc_Interpolate'             % time-interpolation (as resampling)
    %'AG_Proc_Insert_TimeStamp'        % insert time stamp column, interpolated from field notes
    %'AG_Proc_Insert_Activity'         % insert field notes activity info (categorical column) at all rows
 	%'AG_Proc_Insert_Angles'           % insert columns with calculated angles
 	%'AG_Proc_Insert_Acti4Activity'  % insert a column of activity derived in Acti4 from the accelerometer data
	
 	%'HR_Proc_Extract_Day1'            % extract data from day 1, to avoid ambiguity in time stamps without date info
	%'HR_Proc_Interpolate'             % time-interpolation (as resampling to evenly distributed samples)
    %'HR_Proc_Insert_TimeStamp'        % insert time stamp column, interpolated from field notes
    %'HR_Proc_Insert_Activity'         % insert field notes activity info (categorical column) at all rows
	};

config.baseread  = 'C:\Data\Proc'; % base directory (path) reading all input data 
config.basesave  = 'C:\Data\Proc'; % base directory (path) saving all output data

config.ML.Proc_Interpolate_fs         = 8;                       % new sampling frequency target after time-interpolation
config.EM.Proc_Interpolate_fs         = 8;                       % new sampling frequency target after time-interpolation
config.AG.Proc_Interpolate_fs         = 8;                       % new sampling frequency target after time-interpolation
config.HR.Proc_Interpolate_fs         = 8;                       % new sampling frequency target after time-interpolation
config.ID.Integrate_fs                = 8;                         % integrated sata sampling frequency; interpolation target as needed.

%config.FN.Init_Raw_save               = true;
config.AG.Init_ActiLife_save             = false;
config.AG_Proc_Extract_Day1_save = false;
config.AG_Proc_Interpolate = false;
config.AG_Proc_Insert_TimeStamp = false;
%config.AG_Proc_Insert_Activity = false;


% config.ID.Integrate_include_emg               = false;                     % include EMG in the integrated data table
% config.ID.Integrate_include_ml                = false;                     % include Medilogic data in the integrated data table
% config.ID.Integrate_include_ag                = false;                     % include ActiGraph data in the integrated data table

% =================================================================================================================================================                                   

Run_Batch % Start of program execution, do not remove this line
WrapUp;
