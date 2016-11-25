## OBOE - the Oxford Batch Operation Engine

### Overview

OBOE was originally conceived to fulfil the requirement for an API to allow the running of arbitrary applications from [Scratchpads](http://scratchpads.eu) as part of the [ViBRANT](http://vbrant.eu) project's WP5. Later, it was also used for running the Local Ecological Footprinting Tool [LEFT](https://www.left.ox.ac.uk) as well as other non-Vibrant applications. 

Sadly, lack of continued funding and changes to infrastructure have meant that it can no longer be kept running, but the code has been placed here for future reference. Unfortunately the original installation documents aren't available but there are notes below which will hopefully be of some use to anyone wanting to know what it was all about.

### Setup

#### Server Requirements

For the OBOE application itself a Linux server with a Ruby installation and web server will be sufficient; the original used Phusion Passenger with Nginx. Please refer to Rails documentation for more details.

MongoDB is required; OBOE stored job data within the database. The original setup used a single replication set spread over half-a-dozen real and virtual machines. Again, please see the relevant documentation to set this up. 

The job queuing system used Redis. 

####  Jobs

Each job type was written as an extension in `app/models/jobs/`, and was loaded in `app/models/job.rb`. Each job has the following two methods:

    process_new_#{job_name}
    check_progress_#{job_name}

The first of these will initiate the job and the second (which is called from the Redis queue) will check if it is finished and, if so, clean up and save the output as well as notifying the user. 

As each job extension is a Ruby script it can contain whatever code is necessary to run the batch job. This could be a PUT to an API or simply the copying of the user's input to a shared storage area (an NFS mount, originally) where it would be detected by whatever monitoring script the application servers used. LEFT ran this way, with several Windows servers running custom Matlab code. 

### Licence

This legacy code is licensed under the terms of the [MIT Licence](https://opensource.org/licenses/MIT) except where otherwise stipulated in the jobs directory.


### Questions

If you have any questions then please contact <milo.thurston@oerc.ox.ac.uk>.

### Screenshot

N.B. some images are missing at the bottom as they were added by means of some javascript depending on which services were active.

![alt tag](https://raw.githubusercontent.com/knirirr/OBOE/master/oboe.png)
