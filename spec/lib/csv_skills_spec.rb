require 'csv_skills_class'

RSpec.describe "csv_skills" do
  it "generates a count of the domains used in email addresses" do
    counter = DomainCounter.new
    counter.read_file("spec/fixtures/roster.csv")
    counter.write_file("output.csv")

    expect(CSV.read("output.csv")).to eq([
      ["domain", "count"],
      ["yahoo.com", "331"],
      ["gmail.com", "330"],
      ["hotmail.com", "339"],
    ])
  end
end
