class Job
  include MongoMapper::Document

  # this group of extensions handle the processing of each
  # type of job via process_new and check_progress
  include OscExtension
  include TestExtension
  include IdentkeyExtension
  include LeftExtension
  include BeastExtension
  include MrbayesExtension
  include OcpExtension
  include TavernaExtension
  include DurdenExtension
  include MuscleExtension
  include SdmExtension
  include LccExtension
  include GgwsExtension
  include BictExtension
  include CdeExtension
  include MsatfinderExtension
  include ZooqueryExtension

  plugin Joint
  require 'fileutils'
  require 'open-uri'
  require 'stringio'
  require 'time'
  require 'xmlsimple'

  @@per_page = 10 # pagination
  cattr_reader :per_page


  # note that server-submitted jobs are going to have
  # to grab a file from a remote store, as it's not possible
  # to submit jobs via the json interface
  attachment :infile
  attachment :outfile

  before_validation(:set_defaults, :on => :create)
  validate :validate_params
  
  def set_defaults
    if self.status.nil?
      self.update_attributes(:status => 'new')
      self.increment_count
    end
    if self.public.nil?
      self.update_attributes(:public => false)
    end
    if self.parameters.nil?
      self.update_attributes(:parameters => {},:vars => {},:downloads => [])
    end
  end

  def increment_count
    if self.check_count.nil?
      self.check_count = 0
      self.save
    else
      self.check_count += 1
      self.save
    end
  end

  def validate_params
    case self.type
    when 'left','lcc','cde'
      if self.parameters['coords'].blank?
        errors.add "Coordinates: ", "coordinates must be defined (e.g. via the map)"
      end
    when 'sdm'
      if self.parameters['coords'].blank?
        errors.add "Coordinates: ", "coordinates must be defined (e.g. via the map)"
      end
      if self.parameters['species'].blank?
        errors.add "Species: ", "a list of species must be supplied"
      end
    when 'beast','bict','msatfinder'
      if self.infile.blank? and self.inputurl.blank?
        errors.add "File: ", "an input file or URL must be supplied"
      end
    end
  end

  # some stuff for osc machines
  $osc_host = "sal"
  $osc_domain = "oerc.ox.ac.uk"
  $admin_email = "oboe-services@oerc.ox.ac.uk"


# Validations :::::::::::::::::::::::::::::::::::::::::::::::::::::
#validates_uniqueness_of :inputurl


# Assocations :::::::::::::::::::::::::::::::::::::::::::::::::::::
belongs_to :user

# Attribute options extras ::::::::::::::::::::::::::::::::::::::::
key :user, String, :required => false # only required if job was send via scratchpad
key :email, String, :required => true
key :type, String, :required => true
key :status, String, :required => true
key :inputurl, String, :required => false
key :job_name, String, :required => true
key :job_description, String, :required => true
key :errormsg, String, :required => false
key :proper_infilename, String, :required => false
key :proper_outfilename, String, :required => false
key :version, String, :required => false # in order to take things like 1.5.1
key :parameters, Hash, :required => false
key :vars, Hash, :required => false # like parameters, but not taken from user and so 'safe'
key :downloads, Array, :required => false
key :check_count, Integer, :required => false
key :public, Boolean, :required => false
timestamps!

attr_accessible :user,:status,:inputurl,:errormsg,:infile,:outfile,:job_name,:job_description,:parameters,:version,:public,:vars, :downloads
attr_reader :created,:email,:check_count
sanitize :user, :keep_original => false
sanitize :type, :keep_original => false, :required => true
sanitize :inputurl, :keep_original => false
sanitize :job_name, :keep_original => false, :required => true
sanitize :job_description, :keep_original => false
sanitize :parameters#, :keep_original => false

# N.B. for this last one to work then the following file must be hacked:
# $GEM_HOME/gems/mm-sanitize-0.2.0/lib/mm-sanitize.rb
# or, use the gem stored in $RAILS_ROOT/jobs


  # note - some of the available jobs can only be run by certain authorised users
  # Summary of job types available to all users
  # N.B. I've commented out jobs which shouldn't be run for the moment. This is hardly a cunning 
  # solution but it works
  def self.types
    return {'Test' => 'test', # plots a test graph with gnuplot
            'BEAST' => 'beast', # http://code.google.com/p/beast-mcmc/
            'Taverna' => 'taverna', # local taverna server
            'Mr. Bayes' => 'mrbayes',
            'Durden' => 'durden',
            'MUSCLE' => 'muscle',
            'IKey+' => 'identkey',
            'SDM' => 'sdm',
            'LEFT' => 'left',
            'LCC' => 'lcc',
            'CDE' => 'cde',
            'GoldenGATE' => 'ggws',
            'BICT' => 'bict',
            'Msatfinder' => 'msatfinder',
            'ZooQuery' => 'zooquery',
            'One Click Phylogeny' => 'ocp'} # http://www.phylogeny.fr/version2_cgi/simple_phylogeny.cgi
                 
  end

  def self.maptypes
    return ['left','sdm','lcc','cde']
  end


  # which jobs are active
  def self.active?(type)
    active = {'test' => false, 
              'beast' => false,
              'taverna' => false,
              'left' => true,
              'mrbayes' => false,
              'durden' => false,
              'muscle' => false,
              'identkey' => false,
              'lcc' => true,
              'cde' => true,
              'sdm' => false,
              'ggws' => false,
              'bict' => false,
              'msatfinder' => true,
              'zooquery' => false,
              'ocp' => false}
    return active[type]
  end

  # how long should a timeout last on the show page
  def self.timeout?(type)
    case type
    when 'test','ggws','identkey'
      return 5000
    when 'left','sdm'
      return 3000000
    when 'cde'
      return 30000
    when 'mrbayes','beast'
      return 360000
    else 
      return 60000
    end

  end

  # information about specific jobs, e.g. icons &c.
  def self.information
    info = YAML::load(File.open("#{Rails.root}/config/jobtypes.yml"))
  end


  # types of parameter available for each job type
  def self.paramtypes(type)
    case type
    when 'test'
      return {'infile' => {'required' => 'optional',
                           'description' => 'doesn\'t get used for anything',
                           'mime-type' => 'any'},
              'test'   => {'name' => 'Test parameter',
                           'description' => 'Does not serve any useful function.',
                           'format' => 'free text',
                           'required' => 'no',
                           'hidden' => 'no'},
              'coords' => {'name' => 'Coordinates',
                           'required' => 'no',
                           'hidden' => 'no',
                           'format' => 'free text',
                           'description' => 'Does not serve any useful function, used only for testing.'}
               }
    when 'left'
      return {'infile' => {'required' => 'optional', 
                           'description' => 'zip file of species data',
                           'mime-type' => 'application/zip'},
              'coords' => {'name' => 'Coordinates',
                           'description' => 'POLYGON((a,b c,d))',
                           'format' => 'text',
                           'required' => 'yes',
                           'hidden' => 'no'},
              'nlat' =>   {'name' => 'North-latitude',
                           'description' => 'Used only for a simplified variant of the LEFT job',
                           'format' => 'text',
                           'required' => 'no',
                           'hidden' => 'yes'},
              'slat' =>   {'name' => 'South-latitude',
                           'description' => 'Used only for a simplified variant of the LEFT job',
                           'format' => 'text',
                           'required' => 'no',
                           'hidden' => 'yes'},
              'wlong' =>  {'name' => 'West-longitude',
                           'description' => 'Used only for a simplified variant of the LEFT job',
                           'format' => 'text',
                           'required' => 'no',
                           'hidden' => 'yes'},
              'elong' =>  {'name' => 'East-longitude',
                           'description' => 'Used only for a simplified variant of the LEFT job',
                           'format' => 'text',
                           'required' => 'no',
                            'hidden' => 'yes'},
              'location' =>  {'name' => 'location',
                           'description' => 'Include figure 1 - Location',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'globcover' =>  {'name' => 'globcover',
                           'description' => 'Include figure 2 - Globcover',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'ecoregions' =>  {'name' => 'ecoregions',
                           'description' => 'Include figure 3 - Ecoregions',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'speciesrecords' =>  {'name' => 'speciesrecords',
                           'description' => 'Include figure 4 - Species records',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'betadiversity' =>  {'name' => 'betadiversity',
                           'description' => 'Include figure 5 - Beta diversity',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'vulnerability' =>  {'name' => 'vulnerability',
                           'description' => 'Include figure 6 - Vulnerability',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'fragmentation' =>  {'name' => 'fragmentation',
                           'description' => 'Include figure 7 - Fragmentation',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'migratoryspecies' =>  {'name' => 'migratoryspecies',
                           'description' => 'Include figure 8 - Migratoryspecies',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'hydrosheds' =>  {'name' => 'hydrosheds',
                           'description' => 'Include figure 9 - Hydrosheds',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'resilience' =>  {'name' => 'resilience',
                           'description' => 'Include figure 10 - Resilience',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},
              'summary' =>  {'name' => 'summary',
                           'description' => 'Include figure 11 - Summary',
                           'format' => 'boolean',
                           'required' => 'no',
                           'hidden' => 'no'},

            }

    when 'sdm'
      return {'coords' => {'name' => 'Coordinates',
                           'description' => 'POLYGON((a,b c,d))',
                           'format' => 'text',
                           'required' => 'yes',
                           'hidden' => 'no'},
              'species' => {'name' => 'Species',
                           'description' => 'list of species',
                           'format' => 'text',
                           'required' => 'yes',
                           'hidden' => 'no'},

            }
    when 'lcc'
      return {'coords' => {'name' => 'Coordinates',
                           'description' => 'POLYGON((a,b c,d))',
                           'format' => 'text',
                           'required' => 'yes',
                           'hidden' => 'no'}

            }

    when 'cde'
      return {'coords' => {'name' => 'Coordinates',
                           'description' => 'POLYGON((a,b c,d))',
                           'format' => 'text',
                           'required' => 'yes',
                           'hidden' => 'no'}

            }

    when 'beast'
      return {'infile' => {'required' => 'yes',
                           'descripton' => 'Output of BEAUti',
                           'mime-type' => 'appliction/xml'}, 
              'version'=>  {'name' => 'BEAST version',
                          'description' => 'Version of BEAST to be executed.',
                          'format' => "array: ['#{Job.osc_versions(type).collect {|x| x[0]}.join("','")}']",
                          'required' => 'yes',
                          'hidden' => 'no'},
              'oscid' => {'name' => 'Remote ID',
                          'description' => 'ID used by the OSC system to track this job.',
                          'format' => 'text: $id.$hostname',
                          'required' => 'no',
                          'hidden' => 'yes'}
              } 
    when 'ocp'
      return {'infile' => {'required' => 'yes',
                           'description' => 'fasta file of sequence data',
                           'mime-type' => 'text/plain' },
              'result_url' => {'name' => 'Result URL',
                               'description' => 'URL for finished run on remote system.',
                               'format' => 'URL',
                               'required' => 'no',
                               'hidden' => 'yes'}
             } 
    when 'bict'
      return {'infile' => {'required' => 'yes',
                           'description' => 'csv file of species information',
                           'mime-type' => 'text/plain' },
              'analysis_type' => {'name' => 'Analysis type',
                                  'required' => 'yes',
                                  'format' => "text: bqif,bab",
                                  'description' => 'Choice of two analysis types',
                                  'hidden' => 'no'}
             } 

    when 'taverna'
      # N.B. some baclava handling will have to be added at some point
      return {'infile'   =>  {'required' => 'optional',
                              'description' => 'whatever input data the workflow requires',
                              'mime-type' => 'text/plain'},
                              # 'input' is wrong; rails won't accept xml - fix!
              'input'    => {'name' => 'Input data for the workflow. The port name is always needed.',
                             'description' => 'Input port : Value to set input port.',
                             'format' => 'array INPUT:VALUE|INPUT:VALUE',
                             'required' => 'yes',
                             'hidden' => 'no'},
              'workflow' => {'name' => 'The workflow to be executed',
                             'description' => 'A Taverna workflow in t2flow format.',
                             'format' => 't2flow',
                             'required' => 'yes',
                             'hidden' => 'yes'},
              'serverid' => {'name' => 'Taverna server job id',
                             'description' => 'ID used by the Taverna server in URLs.',
                             'format' => 'string',
                             'required' => 'no',
                             'hidden' => 'yes'},
               }
    when 'mrbayes'
      return {'infile' => {'required' => 'yes',
                           'descripton' => 'Nexus formatted alignment',
                           'mime-type' => 'text/plain'}, 
              'version'=> {'name' => 'Mr. Bayes version',
                          'description' => 'Version of Mr. Bayes to be executed.',
                          'format' => "array: ['#{Job.osc_versions(type).collect {|x| x[0]}.join("','")}']",
                          'required' => 'yes',
                          'hidden' => 'no'},
              'oscid' => {'name' => 'Remote ID',
                          'description' => 'ID used by the OSC system to track this job.',
                          'format' => 'text: $id.$hostname',
                          'required' => 'no',
                          'hidden' => 'yes'}
              } 
    when 'msatfinder'
      return {'infile' => {'required' => 'yes',
                           'descripton' => 'Genbank or FASTA file',
                           'mime-type' => 'text/plain'}, 
              'flank_size'=> {'name' => 'Flank Size',
                          'description' => 'No. of bases either side of repeate to extract.',
                          'format' => "integer",
                          'required' => 'yes',
                          'hidden' => 'no'},
              'motif_threshold' => {'name' => 'Motif Threshold',
                          'description' => 'String of values determining motif size and threshold',
                          'format' => 'string: 1,12|2,8|3,5|4,5|5,5|6,5',
                          'required' => 'yes',
                          'hidden' => 'no'},
              'engine'=>  {'name' => 'Engine',
                          'description' => 'Method for finding microsatellites.',
                          'format' => "array: ['regexp','multipass','iterative']",
                          'required' => 'yes',
                          'hidden' => 'no'}

              } 

    when 'durden'
      return {'infile'   =>  {'required' => 'no',
                              'description' => 'Not used',
                              'mime-type' => 'NA'},
              'inputurl' => {'name' => 'Input file URL',
                             'description' => 'Web-accessible input file',
                             'format' => 'URL',
                             'required' => 'yes',
                             'hidden' => 'no'},
              'tile_size' => {'name' => 'Tile size',
                             'description' => 'Default 256.',
                             'format' => 'integer',
                             'required' => 'no',
                             'hidden' => 'no'}
               }
    when 'muscle'
      # this stuff is dreadful. It turns out that XmlSimple is the culprit
      formats = Job.form_parameters('muscle')
      description = ""
      extra = {}
      formats.each do |v|
        if v['values'].nil?
          if v['name'][0] == 'Sequence'
            description = v['description'][0].gsub(/\t/,"")
          end
        else
          name = v['ID']
          extra[name] = {'name' => v['name'][0],
                         'description' => v['description'][0],
                         'format' => "array: #{v['values'][0]['value'].collect {|x| x['value'][0]}.to_s.gsub(/"/,"'")}",
                         'required' => 'yes',
                         'hidden' => 'no'}
        end
      end
      default = {'infile' => {'required' => 'yes',
                             'description' => description,
                             'mime-type' => 'text/plain'},
                 'identifier' => {'name' => 'identifier',
                                  'description' => 'EBI\'s ID for this job',
                                  'format' => 'text',
                                  'required' => 'no',
                                  'hidden' => 'yes'},
                 'retries' => {'name' => 'retries',
                                  'description' => 'How many times the EBI server has been queried',
                                  'format' => 'text',
                                  'required' => 'no',
                                  'hidden' => 'yes'}
               }
      return default.merge(extra)

    when 'ggws'
      # this section is a bit of a hack for a couple of reasons:
      # 1. I don't yet know how the scratchpad server wants to see this sort of
      # parameter return for a service which offers many subservices, each with their own
      # parameters.
      # 2. All the services in this test version of GoldenGATE have the same input and
      # output formats, so I can get away with only querying the first - for now...
      services = Job.form_parameters('ggws')
      default = {'infile' => {'required' => 'no',
                             'description' => 'Not used',
                             'mime-type' => 'text/plain'},
                 'functionName' => {'required' => 'yes',
                             'name' => 'Service name',
                             'format' => "array: #{services['service'].collect {|x| x['name']}.to_s.gsub(/"/,"'")}",
                             'description' => 'Service to be invoked on the data',
                             'hidden' => 'no',
                             'mime-type' => 'text/plain'},
                 'inputFormat' => {'required' => 'yes',
                             'name' => 'Input format',
                             'format' => "array: #{services['service'][0]['inputFormat'].collect {|x| x['name']}.to_s.gsub(/"/,"'")}",
                             'description' => 'Format of the input data',
                             'hidden' => 'no',
                             'mime-type' => 'text/plain'},
                 'outputFormat' => {'required' => 'yes',
                             'name' => 'Output format',
                             'description' => 'Service output format',
                             'format' => "array: #{services['service'][0]['outputFormat'].collect {|x| x['name']}.to_s.gsub(/"/,"'")}",
                             'hidden' => 'no',
                             'mime-type' => 'text/xml'},
                 'INTERACTIVE' => {'required' => 'yes',
                             'name' => 'Interactive',
                             'description' => "no",
                             'hidden' => 'no',
                             'mime-type' => 'text/xml'}

               }

      return default
    when 'identkey'
      default = {'infile' => {'required' => 'no',
                           'description' => 'Not used',
                           'mime-type' => 'NA'},
              'inputurl' => {'name' => 'Input file URL',
                             'description' => 'Web-accessible input file',
                             'format' => 'URL',
                             'required' => 'yes',
                             'hidden' => 'no'},
              'keyurl' => {'name' => 'Output file URL',
                           'description' => 'Location of the generated key',
                           'format' => 'URL',
                           'required' => 'no',
                           'hidden' => 'yes'}
               }
      extra = {}
      Job.form_parameters('identkey').each_pair do |k,v|
        extra[k] = {'name' => v['name'],
                    'description' => v['name'],
                    'format' => "array: #{v['values'].to_s.gsub(/"/,"'")}",
                    'required' => 'yes',
                    'hidden' => 'no'}
      end
      return default.merge(extra)

      # more stuff to follow here

    when 'zooquery'
      return {'sql' => {'name' => 'SQL Query',
                           'description' => 'A legitimate SQL SELECT statement',
                           'format' => 'test',
                           'required' => 'yes',
                           'hidden' => 'no'}

            }
    else
      return nil
    end

  end

  # for correct formatting of BICT parameter names on the "show" page
  def self.bict_types
    return Hash({"BQI/AMBI/Bentix" => "bab", "BQI family" => "bqif"})
  end

  # this should return a hash of available types of service, suitable for displaying in a drop-down
  # list, e.g. for GoldenGATE or Taverna
  def self.servicetypes(type,services)
    case type
    when 'ggws'
      final = Hash.new
      services['service'].each do |s|
        final[s['name']] = s['label']
      end
      return final 
    else
      return {}
    end
  end

  # another method brought in because of GoldenGATE; this one determines what options are available
  # for a particular service. As above, I've cheated by using the zeroth method
  # To get around this some sort of dynamic form construction using javascript is required
  def self.serviceinputtypes(type,method,services)
    case type
    when 'ggws'
      final = Hash.new
      services['service'][0][method].each do |s|
        final[s['name']] = s['label']
      end
      return final 
    else
      return {}
    end
  end

  # This is a manually compiled list of application versions available on the OSC systems.
  # It ought to be updated to populate itself, somehow...
  def self.osc_versions(type)
    case type
    when'beast'
      return [['1.7.4','1.7.4']]
    when'mrbayes'
      return [['3.2.1','3.2.1'],['3.1.2','3.1.2']]
    else
      return []
    end
  end


  # some more complex parameters are needed for Mr. Bayes user selections
  def self.form_parameters(type)
    case type
    when 'mrbayes'
      return {}
    when 'muscle' 
      # query the muscle server to find these out
      # return as name => {values => %w{value1 value2}, description  => "some text" }&c.
      returns = []
      url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/parameters/"
      resource = RestClient::Resource.new url
      response = resource.get
      result = XmlSimple.xml_in(response.body)
      result['id'].each do |i|
        url = "http://www.ebi.ac.uk/Tools/services/rest/muscle/parameterdetails/#{i}"
        resource = RestClient::Resource.new url
        response = resource.get
        details = XmlSimple.xml_in(response.body)
        returns.push(details.merge({"ID" => i}))
      end
      return returns

    when 'ggws'
      # query voonith
      returns = []
      url = "http://172.24.13.84:8080/GgWS/ws"
      resource = RestClient::Resource.new url
      response = resource.get
      result = XmlSimple.xml_in(response.body)
      return result
      # N.B. returns a hash with key 'service'

    when 'identkey'
      return {'representation' => {'values' => %w{tree flat}, 'name' => 'Representation'},
              'format' => {'values' => %w{txt html pdf sdd dot zip}, 'name' => 'Format'},
              'few' => {'values' => %w{no yes}, 'name' => 'Few states character first'},
              'merge' => {'values' => %w{no yes}, 'name' => 'Merge character states if remaining taxa are similar'},
              'pruning' => {'values' => %w{no yes}, 'name' => 'Pruning'},
              'verbosity' => {'values' => %w{h}, 'name' => 'Verbosity'},
              'score' => {'values' => %w{xper}, 'name' => 'Score method'}
      }
    else
      return {}
    end

  end

  # reset job to new
  def reset_new
    self.update_attributes(:status =>'new',:errormsg=>nil)
  end

  # as there's no longer an outputurl entry then this will be faked here
  def outputurl
    if Rails.env.production?
      return "http://oboe.oerc.ox.ac.uk/download/#{self.id}"
    elsif Rails.env.development?
      return "http://bonnacon.oerc.ox.ac.uk:3000/download/#{self.id}"
    elsif Rails.env.test?
      return "http://bonnacon.oerc.ox.ac.uk:3000/download/#{self.id}"
    end

  end

  # get an input file
  def get_infile
    uri = URI.parse(self.inputurl)
    self.infile = open(uri)
    self.proper_infilename = self.inputurl.split(/\//).to_a[-1]
    self.save
  end

  # it would be useful to have a decent output name to use when
  # writing data
  def inname
    if self.proper_infilename.nil?
      return self.infile_name
    else
      return self.proper_infilename
    end
  end

  # Process newly submitted jobs
  def process_new
    # each time a job is run then then a note is made that the owning user
    # has run a job. This is so we can get a count of jobs even if the user
    # deletes them
    user = User.find_by_email(self.email)
    if user.runs["#{self.type}"].blank?
      user.runs["#{self.type}"] = 1
    else
      user.runs["#{self.type}"] += 1
    end
    user.save

    # get the input file, if it has not already been loaded
    begin
      if self.infile.nil? and !self.inputurl.nil?
        self.get_infile unless (self.type == 'durden' or self.type == 'identkey')
      end
    rescue
      self.jobfail("Could not get input file","could not get input file")
      return
    end

    # before processing the job, write a brief summary to the log of this job. It
    # should be csv: type,user,id,date
    logfile = "#{Vibrant::Application.config.dropbox}/oboe_log_#{Rails.env}.txt"
    begin
      open(logfile, 'a') do |f|
        f.puts "#{self.type},#{self.email},#{self.id},#{self.created_at}"
      end
    rescue
      Rails.logger.error("Could not write to logfile!")
    end
    
    # having got the file, we can now commence the processing
    begin
      self.send("process_new_#{self.type}")
    rescue
      self.update_attributes(:status =>'not yet available')
    end
   end

  # Check on the running ones
  def check_progress
    self.increment_count
    begin
      self.send("check_progress_#{self.type}")
    rescue
      self.update_attributes(:status =>'not yet available')
    end
  end

  # the three methods below relate to user e-mails; they get the 'blurb' that
  # goes into the notification email and the address from which it should come

  # success
  def blurb_win
    case self.type
    when 'test'
      "Thanks for using this service."
    when 'left'
"Please contact #{self.email_from} if you have any queries regarding the analysis or the output and one of the team will respond.

Best regards,
The LEFT development team."

    end
  end

  # FAIL
  def blurb_fail
    case self.type
    when 'test'
      "We will investigate this problem as soon as possible"
    when 'left'
"The development team has already been notified and will attempt to re-run the analysis or contact you shortly.

Best regards,
The LEFT development team."

    end
  end

  # I suppose a default from me, in the absence of any specific 
  # vibrant error message, will have to do
  def email_from
    case self.type
    when 'test'
      "milo.thurston@oerc.ox.ac.uk"
    when 'left','sdm','lcc','cde'
      "neil.caithness@oerc.ox.ac.uk"
    else
      "noreply.oboe@oerc.ox.ac.uk"
    end
  end

  # this method should be called any time the job processing goes
  # wrong; it will log the error and e-mail the user. Don't forget
  # to return after calling this!
  def jobfail(log,msg)
    Rails.logger.error("#{log} #{self.id}")
    self.update_attributes(:status =>'error',:errormsg => msg)
    user = User.find_by_email(self.email)
    UserMailer.job_failed(user,self).deliver 
    UserMailer.admin_job_failed(self).deliver
  end

  # this is the colour used to draw shapes on maps...
  # SDM may need changing for visibility
  def self.fill_colour(jobtype)
    colour = { 'left' => '#CE4C96',
               'lcc' => '#963B13',
               'cde' => '#E68A00',
               'sdm' => '#31B369' }
    return colour[jobtype]
  end

end
