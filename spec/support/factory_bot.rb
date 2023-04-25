require 'factory_bot'

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  FactoryBot.find_definitions
  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryBot.lint
    ensure
      DatabaseCleaner.clean
    end
  end
end
