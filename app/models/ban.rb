class Ban < ActiveRecord::Base
  validates_presence_of   :ip
  validates_uniqueness_of :ip
  validates_format_of     :ip, :with => /^(?:\d{1,3}\.){3}\d{1,3}$/

  def qut_ip?
    ip =~ /^131\.181(\.\d{1,3}){2}$/
  end
end
