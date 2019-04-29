require 'jmeter/property'
module Jmeter
	class HttpSampler < Nokogiri::XML::Element
	end
end
#require 'jmeter/http_sampler/comments'
#require 'jmeter/http_sampler/domain'

module Jmeter
	class HttpSampler < Nokogiri::XML::Element

		def has_property?(klass)
			self.element_children.any? do |element|
				element.class == klass 
			end
		end
		def get_property(klass)
			self.element_children.find do |element|
				element.class == klass
			end
		end
		def add_property(property)
			self.add_child property
		end

		#%i{name enabled}.each do |property|
		#	define_method(property) do |*args|
		#		if args.length == 0
		#			instance_variable_get("@#{property}")
		#		elsif args.length == 1
		#			instance_variable_set("@#{property}", args[0])
		#		else
		#			#Die somehow
		#		end
		#	end
		#	define_method("#{property}=") do |value|
		#		instance_variable_set("@#{property}", value)
		#	end
		#end

		[
			{ method: :comments, type: :stringProp, xml_name: 'TestPlan.comments', klass: 'Comments' },
			{ method: :domain, type: :stringProp, xml_name: 'HTTPSampler.domain', klass: 'Domain' },
			{ method: :port, type: :stringProp, xml_name: 'HTTPSampler.port', klass: 'Port' },
			{ method: :protocol, type: :stringProp, xml_name: 'HTTPSampler.protocol', klass: 'Protocol' },
			{ method: :content_encoding, type: :stringProp, xml_name: 'HTTPSampler.contentEncoding', klass: 'ContentEncoding' },
			{ method: :path, type: :stringProp, xml_name: 'HTTPSampler.path', klass: 'Path' },
			{ method: :method, type: :stringProp, xml_name: 'HTTPSampler.method', klass: 'Method' },
			{ method: :follow_redirects, type: :boolProp, xml_name: 'HTTPSampler.follow_redirects', klass: 'FollowRedirects' },
			{ method: :auto_redirects, type: :boolProp, xml_name: 'HTTPSampler.auto_redirects', klass: 'AutoRedirects' },
			{ method: :use_keepalive, type: :boolProp, xml_name: 'HTTPSampler.use_keepalive', klass: 'UseKeepalive' },
			{ method: :do_multipart_post, type: :boolProp, xml_name: 'HTTPSampler.DO_MULTIPART_POST', klass: 'DoMultipartPost' },
			{ method: :browser_compatible_multipart, type: :boolProp, xml_name: 'HTTPSampler.BROWSER_COMPATIBLE_MULTIPART', klass: 'BrowserCompatibleMultipart' },
			{ method: :image_parser, type: :boolProp, xml_name: 'HTTPSampler.image_parser', klass: 'ImageParser' },
			{ method: :concurrent_downloads, type: :boolProp, xml_name: 'HTTPSampler.concurrentDwn', klass: 'ConcurrentDownload' },
			{ method: :md5, type: :boolProp, xml_name: 'HTTPSampler.md5', klass: 'Md5' },
			{ method: :embedded_url_regexp, type: :stringProp, xml_name: 'HTTPSampler.embedded_url_re', klass: 'EmbeddedUrlRegexp' } ,
			{ method: :ip_source, type: :stringProp, xml_name: 'HTTPSampler.ipSource', klass: 'IpSource' },
			{ method: :proxy_host, type: :stringProp, xml_name: 'HTTPSampler.proxyHost', klass: 'ProxyHost' },
			{ method: :proxy_port, type: :stringProp, xml_name: 'HTTPSampler.proxyPort', klass: 'ProxyPort' },
			{ method: :proxy_user, type: :stringProp, xml_name: 'HTTPSampler.proxyUser', klass: 'ProxyUser' },
			{ method: :proxy_pass, type: :stringProp, xml_name: 'HTTPSampler.proxyPass', klass: 'ProxyPass' },
			{ method: :implementation, type: :stringProp, xml_name: 'HTTPSampler.implementation', klass: 'Implementation' },
			{ method: :connect_timeout, type: :stringProp, xml_name: 'HTTPSampler.connection_timeout', klass: 'ConnectTimeout' },
			{ method: :response_timeout, type: :stringProp, xml_name: 'HTTPSampler.response_timeout', klass: 'ResponseTimeout' },
			{ method: :post_body_raw, type: :stringProp, xml_name: 'HTTPSampler.postBodyRaw', klass: 'PostBodyRaw' },
		].each do |property_hash|
			klass = Class.new(Jmeter::Property) do
				@prop_type = property_hash[:type]
				@xml_name = property_hash[:xml_name]
			end
			const_set(property_hash[:klass], klass)

			define_method("#{property_hash[:method]}=") do |value|
				if self.has_property?(klass)
					self.get_property(klass).content = value
				else
					property = klass.new
					property.content = value
					self.add_property(property)
				end
			end
		end

		def self.new
			super('HTTPSamplerProxy', Jmeter::DOCUMENT)
		end
		def initialize(name, document)
			super
			self[:guiclass] = 'HttpTestSampleGui'
			self[:testclass] = 'HTTPSamplerProxy'
			self[:testname] = ''
			self[:enabled] = 'true'
		end
	end
end

