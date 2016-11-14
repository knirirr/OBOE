function xls2image(xlsFile,imgFile,sheet,range)

% Open Excel
Application = actxserver('Excel.Application');

% Copy a picture of the spreadsheet (sheet and range) to the system clipboard
Application.Workbooks.Open(xlsFile).Sheets.get('Item',sheet).Range(range).CopyPicture;

% Close Excel
Application.Quit

% Save the clipboard image to a file
imclipboard('paste',imgFile)

