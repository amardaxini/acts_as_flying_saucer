module ActsAsFlyingSaucer

	class Config
		# default options
		class << self
			attr_accessor :options
		end
		ActsAsFlyingSaucer::Config.options = {
						:java_bin => "java",
						:classpath_separator => ':',
						:tmp_path => "/tmp",
						:run_mode => :once,
						:max_memory_mb => 512,
						:nailgun=> false
		}
		class << self
			attr_accessor :options
		end
		# cattr_accessor :options
	end

end
