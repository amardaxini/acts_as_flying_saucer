require 'nailgun'
module ActsAsFlyingSaucer

	# Xhtml2Pdf
	#
	class Xhtml2Pdf
		def self.write_pdf(options)
			if 	!File.exists?(options[:input_file])
				File.open(options[:input_file], 'w') do |file|
					file << options[:html]
				end
			end

			java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
			class_path = "'.#{options[:classpath_separator]}#{java_dir}/jar/acts_as_flying_saucer.jar'"

			if options[:nailgun]
				command = "#{Nailgun::NgCommand::NGPATH} --nailgun-server #{ActsAsFlyingSaucer::Config.options[:nailgun_host]}  --nailgun-port #{ ActsAsFlyingSaucer::Config.options[:nailgun_port]} Xhtml2Pdf #{options[:input_file]} #{options[:output_file]}"
			else
				command = "#{options[:java_bin]} -Xmx512m -Djava.awt.headless=true -cp #{class_path} acts_as_flying_saucer.Xhtml2Pdf #{options[:input_file]} #{options[:output_file]}"
			end
			system(command)
		end

		def self.encrypt_pdf(options,output_file_name,password)
			java_dir = File.join(File.expand_path(File.dirname(__FILE__)), "java")
			class_path = "'.#{options[:classpath_separator]}#{java_dir}/jar/acts_as_flying_saucer.jar'"
			if options[:nailgun]
				command = "#{Nailgun::NgCommand::NGPATH}  --nailgun-server #{ActsAsFlyingSaucer::Config.options[:nailgun_host]}  --nailgun-port #{ ActsAsFlyingSaucer::Config.options[:nailgun_port]} encryptPdf #{options[:input_file]} #{options[:output_file]}"
			else
				command = "#{options[:java_bin]} -Xmx#{options[:max_memory_mb]}m -Djava.awt.headless=true -cp #{class_path} acts_as_flying_saucer.encryptPdf #{options[:output_file]} #{output_file_name} #{password}"
			end
			system(command)
		end

	end
end
