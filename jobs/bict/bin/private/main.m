function data = main(data)
% MAIN  
%
% Implemented for automation on the OBOE automation server.
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

% ------------------------------------------------------------------------

% Read the input file (should be of type csv)
infile = eval(sprintf('data.dir.work.input.data.%s',regexprep(data.args.infile,'\.','_')));
[num,~] = xlsread(infile);
data.bict.inputfile = data.args.infile;
data.bict.n_rows = sprintf('%i',size(num,1));
data.bict.n_cols = sprintf('%i',size(num,2));
logmsg(0,'Input file read (%s)',data.bict.inputfile);
logmsg(0,'%i species by %i stations',size(num));

% Read the pre-computed indices file
infile = data.dir.work.output.data.indices_csv;
[num,txt] = xlsread(infile);

% Checks
labels = {
    'Indices/Stations'
    ''
    'Number of Individuals (N)'
    'Species Richness Index (S)'
    'Shannon Index (ln) (H)'
    'Shannon Index (log10) (H)'
    'Shannon Index (log2) (H)'
    'Pielou Species Evenness Index(J)'
    'Mergalef Diversity Index (d)'
    'Benthic Quality Index (BQI)'
    'Benthic Quality Index (BQI) NonMatched percentage'
    'Bentix Index'
    'Bentix Index NonMatched percentage'
    'AMBI Index'
    'AMBI Index NonMatched percentage'
    };
if ~isequal(labels,txt(:,1))
    logmsg(1,'Error parsing indices.csv file');
    data.job.status = 'Failed';
    data.job.exception = 'Error parsing indices.csv file';
    return
end


index(1).title      = 'Number of Individuals (N)';
index(1).xlabel     = 'N';
index(1).ylabel     = 'frequency';
index(1).filename   = 'figure_1.png';

index(2).title      = 'Species Richness (S)';
index(2).xlabel     = 'S';
index(2).ylabel     = 'frequency';
index(2).filename   = 'figure_2.png';

index(3).title      = 'Shannon Index (ln) (H'')';
index(3).xlabel     = 'H''';
index(3).ylabel     = 'frequency';
index(3).filename   = 'figure_3a.png';

index(4).title      = 'Shannon Index (log10) (H'')';
index(4).xlabel     = 'H''';
index(4).ylabel     = 'frequency';
index(4).filename   = 'figure_3b.png';

index(5).title      = 'Shannon Index (log2) (H'')';
index(5).xlabel     = 'H''';
index(5).ylabel     = 'frequency';
index(5).filename   = 'figure_3c.png';

index(6).title      = 'Pielou''s Index (J'')';
index(6).xlabel     = 'J';
index(6).ylabel     = 'frequency';
index(6).filename   = 'figure_4.png';

index(7).title      = 'Mergalef''s Index (d)';
index(7).xlabel     = 'd';
index(7).ylabel     = 'frequency';
index(7).filename   = 'figure_5.png';


% Plot histograms for each index
for i = 1:numel(index)
    x = num(i,:);
    hist(x,20)
    title(index(i).title)
    xlabel(index(i).xlabel); 
    ylabel(index(i).ylabel)
    saveas(gcf,fullfile(data.dir.work.output__,'images','figures',index(i).filename))
    close 
end

logmsg(0,'Histograms plotted');



% ------------------------------------------------------------------------
% Set the job status flags
if isempty(data.job.status), data.job.status = 'Success'; end
if isempty(data.job.exception), data.job.exception = 'None'; end
% ------------------------------------------------------------------------

