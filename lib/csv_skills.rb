require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

# Use Hash.new(0) to remove redundant lines.
def parse_file(read_file)
  domain_counts = Hash.new(0)
  CSV.foreach(read_file) do |row|
    domain = get_domain(row[1])
    domain_counts[domain] += 1
  end
  write_file(domain_counts, "output.csv")
end

# def parse_file(read_file)
#   domain_counts = {}
#   CSV.foreach(read_file) do |row|
#     domain = row[1].partition('@').last
#     unless domain_counts.has_key?(domain)
#       domain_counts[domain] = 0
#     end
#     domain_counts[domain] += 1
#   end
#   write_file(domain_counts, "output.csv")
# end


def write_file(domain_counts, write_file)
  CSV.open(write_file, "wb") do |csv|
    csv << ["domain", "count"]
    domain_counts.each do |key, value|
      csv << [key, value.to_s]
    end
  end
end

#Extracting only domain name from email address
def get_domain(email_address)
  email_address.partition('@').last
end

# If this is here, how many times is `parse_file` being called when we run the specs?
#  -> With method's call below, 'parse_file' will be called twice when we run the specs
# parse_file("spec/fixtures/roster.csv")
