require 'open-uri'

class Bot

  def initialize(quote)
    @quote = quote
  end

  def login_url
    'http://binddesk.atminsurance.com/login/login.asp'
  end

  def rater_url
    'http://binddesk.atminsurance.com/RAPIDRATER/GUARDIAN/default.asp?'
  end

  def doc
    @doc ||= Nokogiri::HTML(open(url))
  end

  def username
    'quotes@binddesk.com'
  end

  def password
    'Binddesk2016'
  end

  def login
    @browser.goto login_url
    @browser.text_field(name: 'un').set('quotes@binddesk.com')
    @browser.text_field(name: 'pwd').set('Binddesk2016')
    @browser.send_keys :enter
    sleep 1
  end

  def fill_defaults
    @browser.goto rater_url
    @browser.select_list(:name, "new_agency_id").select_value("3589")
    @browser.select_list(:name, "new_user_id").select_value("7670")
  end

  def fill_class_codes
    @browser.text_field(name: 'gross_receipts_1').set(@quote.cc1_receipts)
    @browser.text_field(name: 'gross_receipts_2').set(@quote.cc2_receipts)
    @browser.text_field(name: 'gross_receipts_3').set(@quote.cc3_receipts)
    @browser.text_field(name: 'gross_receipts_4').set(@quote.cc4_receipts)
    @browser.select_list(:name, "classification_id_1").select_value(@quote.cc1)
    @browser.select_list(:name, "classification_id_2").select_value(@quote.cc2)
    @browser.select_list(:name, "classification_id_3").select_value(@quote.cc3)
    @browser.select_list(:name, "classification_id_4").select_value(@quote.cc4)
  end

  def fill_rapid_rater
    fill_defaults
    fill_class_codes
    @browser.text_field(name: 'applicant_company_name').set(@quote.insured_name)
    @browser.select_list(:name, "applicant_state").select_value(@quote.something)
    @browser.select_list(:name, "limit_requested").select_value(@quote.something)
    @browser.select_list(:name, "sir_box").select_value(@quote.something)
    @browser.select_list(:name, "loss_runs_available").select_value(@quote.something)
    @browser.select_list(:name, "years_as_current").select_value(@quote.something)
    @browser.select_list(:name, "years_experience").select_value(@quote.something)
    @browser.text_field(name: 'perc_subout').set('10')
    sleep 1
    @browser.text_field(name: 'broker_fee_box').set('50')
    @browser.text_field(name: 'placement_fee_box').set('50')
    @browser.button(alt: 'Get Rate').click
    sleep 1
  end

  def premium
    @browser.input(name: 'QuoteCharge1').value
  end

  def total_policy_cost
    @browser.input(name: 'QuoteCharge15').value
  end

  def to_price(fee_string)
    fee_string

  end

  def extract_rates
    rates = []
    (1..15).each do |c|
      rates << @browser.input(name: "QuoteCharge#{c.to_s}").value unless [9,10,11,12,13,14].include? c
    end
    rates
  end

  def get_rate
    binding.pry
    headless = Headless.new
    headless.start
    @browser = Watir::Browser.new :phantomjs
    login
    fill_rapid_rater
    extract_rates
  end

end
