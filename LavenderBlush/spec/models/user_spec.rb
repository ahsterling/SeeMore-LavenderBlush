require 'rails_helper'  # keeps the file DRY so you don't have to refer back to rails_helper.rb

# RSpec.describe Post, :type => :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


describe User do

  describe '.validates' do
    # period indicates this is a class method while octothorp implies instance method
    # describe is only for humans 'it' is the test
    # you could use one 'it' for all four of the following tests
    # but within each 'it' we have a clean slate so there is no interaction
    # between data for different tests

    it 'is valid with a valid body' do
      expect(User.new(name: "Fred Flintstone").valid?).to eq true
      expect(User.new(name: "".valid?).to eq false)
    end

    

  end

end
