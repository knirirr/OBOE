function html2pdf(htmlFile,pdfFile)

% Open Word
wordApplication = actxserver('Word.Application');

% Uncomment this for debugging
% set(wordApplication,'Visible',1);

% Get a handle to the documents object
documents = wordApplication.Documents;

% Open the Document
mydoc = documents.Open(htmlFile);

% Save it as PDF
mydoc.SaveAs2(pdfFile,17);

% Close the document
mydoc.Close;

% Close Word
wordApplication.Quit;
