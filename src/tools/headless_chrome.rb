require "selenium-webdriver"

class HeadlessChrome

  attr_accessor :driver, :wait

  TIME_OUT = 30

  def initialize
    Selenium::WebDriver::Chrome.driver_path = '/usr/local/bin/chromedriver'
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--headless')
    options.add_argument('--no-sandbox')
    options.add_argument('--disable-gpu')
    options.add_argument("--start-maximized")
    @wait = Selenium::WebDriver::Wait.new(timeout: TIME_OUT)
    @driver = Selenium::WebDriver.for :chrome, options: options  # ブラウザ起動 ヘッドレス

    @driver.manage.window.maximize
  end

end