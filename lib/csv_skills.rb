require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

def parse_file(read_file)
  domain_counts = {}
  CSV.foreach(read_file) do |row|
    domain = row[1].partition('@').last
    unless domain_counts.has_key?(domain)
      domain_counts[domain] = 0
    end
    domain_counts[domain] += 1
  end
  write_file(domain_counts, "output.csv")
end

def write_file(domain_counts, write_file)
  CSV.open(write_file, "wb") do |csv|
    csv << ["domain", "count"]
    domain_counts.each do |key, value|
      csv << [key, value.to_s]
    end
  end
end

parse_file("spec/fixtures/roster.csv")
