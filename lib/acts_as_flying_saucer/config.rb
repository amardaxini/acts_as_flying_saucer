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
						:max_memory_mb => 50,
						:nailgun=> false,
						:nailgun_port => '2113',
						:nailgun_host => 'localhost',
		}
		def self.setup_nailgun
			if ActsAsFlyingSaucer::Config.options[:nailgun]
				Nailgun::NailgunConfig.options= {
								:java_bin => ActsAsFlyingSaucer::Config.options[:java_bin],
								:server_address => ActsAsFlyingSaucer::Config.options[:nailgun_host],
								:port_no=>ActsAsFlyingSaucer::Config.options[:nailgun_port]
				}
				Nailgun::NailgunServer.new(["start"]).daemonize
				count =0
				while(!system("lsof -i -n -P|grep #{ActsAsFlyingSaucer::Config.options[:nailgun_port]}") && count<9)
					sleep(1)
					count+=1
				end
				java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
				Dir.glob("#{java_dir}/jar/*.jar") do |jar|
          Nailgun::NgCommand.ng_cp(jar)
        end
				# ADD IN NAILGUN CLASS
			
				Nailgun::NgCommand.ng_alias("Xhtml2Pdf","acts_as_flying_saucer.Xhtml2Pdf")
				Nailgun::NgCommand.ng_alias("encryptPdf", "acts_as_flying_saucer.encryptPdf")

			end
		end
		# cattr_accessor :options
	end

end
