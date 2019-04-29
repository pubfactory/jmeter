require 'nokogiri'

module Jmeter
	class Property < Nokogiri::XML::Element

		def self.new
			super(@prop_type.to_s, Jmeter::DOCUMENT)
		end
		def initialize(name, document)
			self[:name] = self.class.instance_variable_get(:@xml_name)
		end
	end
end
