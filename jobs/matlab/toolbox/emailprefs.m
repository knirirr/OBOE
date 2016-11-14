function emailprefs
% EMAILPREFS    Sets SMTP preferences and Java properties
%
% Copyright 2012, neil.caithness@oerc.ox.ac.uk

setpref('Internet','E_mail','vibrant.oboe@gmail.com')
setpref('Internet','SMTP_Server','smtp.gmail.com');
setpref('Internet','SMTP_Username','vibrant.oboe@gmail.com');
setpref('Internet','SMTP_Password','************') % digital egg(s) lc
props = java.lang.System.getProperties;
props.setProperty('mail.smtp.auth','true');
props.setProperty('mail.smtp.socketFactory.class','javax.net.ssl.SSLSocketFactory');
props.setProperty('mail.smtp.socketFactory.port','465');  

% Alternative addresses
% noreply.left@gmail.com
% Password hint: What are the girls? First uc, first digital
