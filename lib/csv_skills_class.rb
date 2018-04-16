# NOTE Do this last.
#
# Imagine our interface was something like this:
  # counter = DomainCounter.read_file("path/to/file")
  # counter["good_domain.com"] # => 100
  # counter["non_existent.com"] # => 0
  # counter.to_hash # => {"domain" => 1, ...}
  # counter.write_file("path_to_file")
#
# Can you update the existing code to offer this interface?

# ===== How to run in pry =====
# load './lib/csv_skills_class.rb'
# counter = DomainCounter.new
# counter.read_file("spec/fixtures/roster.csv")
# counter.write_file("output.csv")

require 'rubygems'
require 'bundler/setup'
Bundler.require(:default)
require 'csv'

# Why did you choose a module over a class? If you did consider using
# a class, what prevented you from being able to use it?
# Reason why I chose module in Version 3 solution:
# -> I wasn't sure how to call write_file for Hash. ***counter.write_file("output.csv")***
# -> Then, I decided to add custom method (write_file) to Hash class. ***Hash.send(:include, DomainCounter)***
# -> :include takes 'module' instead of 'class'

#Version 4 Solution
class DomainCounter
  def initialize
    @domain_counts = Hash.new(0)
  end

  def [](key)
    @domain_counts[key.to_s]
  end

  def []=(key, value)
    @domain_counts[key.to_s] = value
  end

  def to_hash
    @domain_counts
  end

  def read_file(read_file)
    CSV.foreach(read_file) do |row|
      domain = get_domain(row[1])
      self[domain] += 1
    end
  end

  def write_file(write_file)
    CSV.open(write_file, "wb") do |csv|
      csv << ["domain", "count"]
      self.to_hash.each do |key, value|
        csv << [key, value.to_s]
      end
    end
  end

  private
    def get_domain(email_address)
      email_address.partition('@').last
    end

end
