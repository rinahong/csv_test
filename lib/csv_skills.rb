require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

def parse_file
  data = File.read("spec/fixtures/roster.csv")
  rows = data.split("\n")
  domain_counts = {}
  rows.each do |row|
    element = row.split(",")
    domain = element[1].partition('@').last
    unless domain_counts.has_key?(domain)
      domain_counts[domain] = 0
    end
    domain_counts[domain] += 1
  end

  write_file(domain_counts)
end

def write_file(domain_counts)
  puts domain_counts
end
