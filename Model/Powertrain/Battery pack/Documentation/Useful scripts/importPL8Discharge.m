function [Time,Current,Voltage] = importPL8Discharge(infile)
%IMPORTFILE Import discharge data from a single-cell PL-8 discharge.
%   Auto-generated by MATLAB
%	Written for abk, 2014-11-17

%% Initialize variables.
delimiter = '\t';
if nargin<=2
	startRow = 1;
	endRow = inf;
end

%% Format string for each line of text:
%   column1: date strings (%s)
%	column17: double (%f)
%   column25: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%*s%*s%*s%f%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, endRow(1)-startRow(1)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(1)-1, 'ReturnOnError', false);
for block=2:length(startRow)
	frewind(fileID);
	dataArrayBlock = textscan(fileID, formatSpec, endRow(block)-startRow(block)+1, 'Delimiter', delimiter, 'HeaderLines', startRow(block)-1, 'ReturnOnError', false);
	for col=1:length(dataArray)
		dataArray{col} = [dataArray{col};dataArrayBlock{col}];
	end
end

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Convert the contents of column with dates to serial date numbers using date format string (datenum).
dataArray{1} = datenum(dataArray{1}, 'mm/dd/yy HH:MM:SS PM');

%% Allocate imported array to column variable names
Time = dataArray{:, 1};
Current = dataArray{:, 2};
Voltage = dataArray{:, 3};

