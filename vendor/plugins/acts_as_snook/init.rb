$:.unshift(File.join(File.dirname(__FILE__), "lib"))
require "lucky_sneaks/acts_as_snook"

ActiveRecord::Base.send :include, LuckySneaks::ActsAsSnook