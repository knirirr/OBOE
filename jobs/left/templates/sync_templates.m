% Copyright 2012, neil.caithness@oerc.ox.ac.uk
%
% This source is subject to the CC BY-NC-SA 3.0 license
% http://creativecommons.org/licenses/by-nc-sa/3.0/
% Please see the URL above for more information.
% All other rights reserved.
%
% THIS CODE AND INFORMATION ARE PROVIDED "AS IS" WITHOUT WARRANTY OF ANY 
% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A
% PARTICULAR PURPOSE.
["% Copyright 2012, neil.caithness@oerc.ox.ac.uk\n", "%\n", "% This source is subject to the CC BY-NC-SA 3.0 license\n", "% http://creativecommons.org/licenses/by-nc-sa/3.0/\n", "% Please see the URL above for more information.\n", "% All other rights reserved.\n", "%\n", "% THIS CODE AND INFORMATION ARE PROVIDED \"AS IS\" WITHOUT WARRANTY OF ANY \n", "% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE\n", "% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A\n", "% PARTICULAR PURPOSE.\n"]
["[\"% Copyright 2012, neil.caithness@oerc.ox.ac.uk\\n\", \"%\\n\", \"% This source is subject to the CC BY-NC-SA 3.0 license\\n\", \"% http://creativecommons.org/licenses/by-nc-sa/3.0/\\n\", \"% Please see the URL above for more information.\\n\", \"% All other rights reserved.\\n\", \"%\\n\", \"% THIS CODE AND INFORMATION ARE PROVIDED \\\"AS IS\\\" WITHOUT WARRANTY OF ANY \\n\", \"% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE\\n\", \"% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A\\n\", \"% PARTICULAR PURPOSE.\\n\"][\"[\\\"% Copyright 2012, neil.caithness@oerc.ox.ac.uk\\\\n\\\", \\\"%\\\\n\\\", \\\"% This source is subject to the CC BY-NC-SA 3.0 license\\\\n\\\", \\\"% http://creativecommons.org/licenses/by-nc-sa/3.0/\\\\n\\\", \\\"% Please see the URL above for more information.\\\\n\\\", \\\"% All other rights reserved.\\\\n\\\", \\\"%\\\\n\\\", \\\"% THIS CODE AND INFORMATION ARE PROVIDED \\\\\\\"AS IS\\\\\\\" WITHOUT WARRANTY OF ANY \\\\n\\\", \\\"% KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE\\\\n\\\", \\\"% IMPLIED WARRANTIES OF MERCHANTABILITY AND/OR FITNESS FOR A\\\\n\\\", \\\"% PARTICULAR PURPOSE.\\\\n\\\"][\\\"function sync_templates\\\\r\\\\n\\\", \\\"\\\\r\\\\n\\\", \\\"filename = {'output_template.htm','error_template.htm'};\\\\r\\\\n\\\", \\\"for f = filename\\\\r\\\\n\\\", \\\"    str = fileread(char(f));\\\\r\\\\n\\\", \\\"    str = regexprep(str,'alt=\\\\\\\"[^\\\\\\\"]*\\\\\\\"','alt=\\\\\\\"\\\\\\\"');\\\\r\\\\n\\\", \\\"    str = regexprep(str,'\\\\xA9','&copy;');\\\\r\\\\n\\\", \\\"    str = regexprep(str,'\\\\x96','&ndash;');\\\\r\\\\n\\\", \\\"    str = regexprep(str,'\\\\xFC','&uuml;');\\\\r\\\\n\\\", \\\"    str = regexprep(str,'\\\\xF6','&ouml;');\\\\r\\\\n\\\", \\\"    fid = fopen(fullfile(char(f)),'w+');\\\\r\\\\n\\\", \\\"    fprintf(fid,'%s',str);\\\\r\\\\n\\\", \\\"    fclose(fid);\\\\r\\\\n\\\", \\\"end\\\\r\\\\n\\\"]\"]"]