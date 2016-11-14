#!/usr/bin/env ruby

logdir = "/storage/oboe/Jobs/"

# step one, parse the job log
jobtypes = {}
users = []
lines = IO.readlines("#{logdir}/oboe_log_production.txt")
lines.each do |l|
  parts = l.split(/,/)
  users << parts[1]
  if !jobtypes[parts[0]].nil?
    jobtypes[parts[0]] += 1
  else
    jobtypes[parts[0]] = 1
  end
end

puts jobtypes
puts users.uniq.count

__END__
