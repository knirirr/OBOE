---------------------------------------------------------------------------
These are the implementation notes for the LEFT service for the 
VIBRANT automation server at https://vibrant.oerc.ox.ac.uk/left
---------------------------------------------------------------------------

Directory structure
    See pathto.m and patheto_data.m in /left/bin/private
    The compiled executable expects to run in /left/output/<jobid>
    Paths to files are relative to this location.

---------------------------------------------------------------------------

Updating and compiling the source
    Login to vibrant@cockatrice
        cd ~/Work/Web/vibrant && svn up
        cd ~/left/bin/ && mcc -m -R -nodesktop -R nodisplay -R -logfile -R logfile.txt -N -p map main.m
    Test
        ./run_main.sh /opt/matlab/R2010b ../output/example_output/args.txt

---------------------------------------------------------------------------

Content of args.txt
    args.txt must contain a set of parameter/value pairs taken from the web
    form and written as delimited csv - "p1","v1","p2","v2"...,"pn","vn"
    Some additional field pairs should be added
    (param name is all lower case, no underscores)
    (white space is permitted anywhere)
        "jobtitle"," ",
        "jobdescription"," ",
        "jobsubmitter"," ",
        "jobid"," ",
        "minlatitude"," ",
        "maxlatitude"," ",
        "minlongitude"," ",
        "maxlongitude"," "
        "customtemplate"," ",

---------------------------------------------------------------------------

Email addresses
    Send email from <noreply.left@oerc.ox.ac.uk>
    I've requested the following email addresses for the LEFT project:
        left@oerc.ox.ac.uk
        noreply.left@oerc.ox.ac.uk
        admin.left@oerc.ox.ac.uk
    TODO: Follow-up with IT support
