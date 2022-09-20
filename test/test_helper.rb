ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  # Returns a new attachable object that can be used as an argument for attach.
  def new_attachable
    filename = 'kitten.jpg'

    {
      io: File.open(Rails.root.join('test', 'fixtures', 'files', filename)),
      filename:,
      content_type: 'image/jpeg'
    }
  end
end
