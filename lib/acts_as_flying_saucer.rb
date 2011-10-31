require 'acts_as_flying_saucer/config'
require 'acts_as_flying_saucer/xhtml2pdf'
require 'acts_as_flying_saucer/acts_as_flying_saucer_controller'
require 'nailgun'
require 'tidy_ffi'
require 'net/http'
require 'uri'
if defined?(Rails)
	ActionController::Base.send(:include, ActsAsFlyingSaucer::Controller)
elsif defined?(Sinatra)
	Sinatra::Base.send(:include, ActsAsFlyingSaucer::Controller)
	class Sinatra::Base
		acts_as_flying_saucer
	end
end

module ActsAsFlyingSaucer

end
