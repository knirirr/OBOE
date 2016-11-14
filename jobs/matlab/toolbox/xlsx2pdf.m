function xlsx2pdf(xlsxFile,pdfFile)

% Open Excel
excelApplication = actxserver('Excel.Application');

% Uncomment this for debugging
% set(excelApplication,'Visible',1);

% Suppress any alerts
set(excelApplication,'DisplayAlerts',0)

% Open the spreadsheet
mydoc = excelApplication.Workbooks.Open(xlsxFile);

% Save it as PDF
mydoc.ExportAsFixedFormat(0,pdfFile);

% Close the spreadsheet
mydoc.Close;

% Close Excel
excelApplication.Quit;
