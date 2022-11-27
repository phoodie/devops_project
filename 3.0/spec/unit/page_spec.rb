# downloading required libraries
require 'capybara'
require 'capybara/dsl'
# Need selenium to perform DSL logo
require 'selenium-webdriver'

# include a capybara methods
# ref: example_seleniuem_spec.rb
# :browser due to docker constraints, we want it to use "remote" browser not the chrome
# :url yses variables to determine the hostname and port of the selenium site
# "args" disable default browser check and complaining insuf ram
include Capybara::DSL
Capybara.app_host = "http://website" # Using Selenium; connect over network
Capybara.run_server = false # Disable Rack since we are using Selenium.
Capybara.register_driver :selenium do |app|
	Capybara::Selenium::Driver.new(
		app,
		:browser => :remote,
		:url => "http://#{ENV['SELENIUM_HOST']}:#{ENV['SELENIUM_PORT']}/wd/hub",
		:capabilities => Selenium::WebDriver::Remote::Capabilities.chrome( #desire_capabilities is now called capabilities
			"chromeOptions" => {
				"args" => ['--no-default-browser-check', '--disable-dev-shm-usage']
			} 
		)
	)
end
Capybara.default_driver = :selenium

# Creating our first unit tests
describe "Example page render unit tests" do
	it "Should show the Explore California logo" do
		visit('/') #inspect the root dir
		expect(page.has_selector? 'a.logo').to be true # this will make true/false statement
	end
end
