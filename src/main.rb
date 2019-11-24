require "selenium-webdriver"
require "csv"
require_relative 'tools/headless_chrome'
require_relative 'repository/syllabus'
require_relative 'parser/syllabus'

def get_syllabuses
  chrome = HeadlessChrome.new
  home_url = "https://idc.ibaraki.ac.jp/portal/Public/Syllabus/SearchMain.aspx"
  chrome.driver.navigate.to(home_url)

  select = Selenium::WebDriver::Support::Select.new(chrome.driver.find_element(:xpath, '//*[@id="ctl00_phContents_ddl_fac"]'))
  select.select_by(:text, '工学部') # 工学部を選択

  chrome.driver.execute_script("window.scrollTo(0, 1200);")
  chrome.driver.find_element(:xpath, '//*[@id="ctl00_phContents_ctl04_btnSearch"]').click
  chrome.wait.until{ chrome.driver.current_url == home_url } # 遷移後の待機

  current_tr_len = chrome.driver.find_elements(:xpath, '//*[@id="ctl00_phContents_ucGrid_grv"]/tbody/tr').length
  select = Selenium::WebDriver::Support::Select.new(chrome.driver.find_element(:xpath, '//*[@id="ctl00_phContents_ucGrid_ddlLines"]'))
  select.select_by(:value, '0') # 全件取得
  chrome.wait.until{ chrome.driver.find_elements(:xpath, '//*[@id="ctl00_phContents_ucGrid_grv"]/tbody/tr').length > current_tr_len} # 表示されるまで待機する
  tr_array = chrome.driver.find_elements(:xpath, '//*[@id="ctl00_phContents_ucGrid_grv"]/tbody/tr')
  tr_array.shift # 最初の要素はヘッダーの為削除する
  syllabuses = tr_array.map do |tr|
    syllabus = Repository::Syllabus.new
    link = tr.find_element(:xpath, 'td[4]/a')
    syllabus.url = link.attribute("href")
    syllabus.link_title = link.text
    syllabus
  end

  chrome.driver.quit
  syllabuses
end

def write_csv syllabuses

  CSV.open(ARGV[0],'w') do |csv|
    instance_variables = syllabuses[0].instance_variables
    instance_variables_str = instance_variables.dup.map{|s| s = s.to_s; s.slice!(0); s}
    csv << instance_variables_str

    syllabuses.each do |syllabus|
      values = instance_variables.map do |instance_variable|
        syllabus.instance_variable_get(instance_variable)
      end

      csv << values
    end
  end

end

def main
  syllabuses = get_syllabuses
  syllabuses = syllabuses[0..2]

  syllabuses = syllabuses.map do |syllabus|
    parser = Parser::Syllabus.new
    parser.syllabus = syllabus
    parser.fetch
    parser.parse

    sleep(3)
    parser.syllabus
  end

  write_csv(syllabuses)
end

main