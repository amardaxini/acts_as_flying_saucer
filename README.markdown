acts\_as\_flying\_saucer
=====================

acts\_as\_flying\_saucer is a library that allows to save rendered views as pdf documents using the [Flying Saucer][1] java library.

[1]: https://xhtmlrenderer.dev.java.net/

Install
-------

Grab the last version from Github:

    sudo gem install acts_as_flying_saucer


Requirements
------------

* JDK 1.5.x or 1.6.x
* Tidy required
* Ubuntu Installation
 * Install tidy with dev and ruby binding.

 * apt-get install tidy
 * apt-get install libtidy-dev
 * apt-get install libtidy-ruby


Usage
-----
### Rails
Just call the acts\_as\_flying\_saucer method inside the controller you want to enable to generate pdf documents.
Then you can call the render\_pdf method. 
It accepts the same options as ActionController::Base#render plus the following ones:
  

:pdf\_file - absolute path for the generated pdf file.
  
:send\_file - sends the generated pdf file to the browser. It's the hash the ActionController::Streaming#send\_file method will receive.  
             
:password  attach password for generated pdf            

:debug_html - (boolean expected) generates html output to the browser for debugging purposes

:clean  - (boolean expected) It cleans up html using tidy (It uses tidy_ffi gem) default is false

:send_to_client - (boolean expected) If it is false it returns output pdf and attachment is not sent to client.

:url - url can be file path or any http url (with http or https) or string. This will generated pdf from file,url or string. 
          
    class FooController < ActionController::Base
      acts_as_flying_saucer
    
      def create
        render_pdf :template => 'foo/pdf_template'
      end
    end
   

  
  
Examples
--------
  
    # Renders the template located at '/foo/bar/pdf.html.erb' and stores the pdf 
    # in the temp path with a filename based on its md5 digest
    render_pdf :file => '/foo/bar/pdf.html.erb'
  
    # renders the template located at 'app/views/foo.html.erb' and saves the pdf
    # in '/www/docs/foo.pdf'
    render_pdf :template => 'foo', :pdf_file => '/www/docs/foo.pdf'
  
    # renders the 'app/views/foo.html.erb' template, saves the pdf in the temp path
    # and sends it to the browser with the name 'bar.pdf'
    render_pdf :template => 'foo', :send_file => { :filename => 'bar.pdf' }
    
    # To send file with password protection
       render_pdf :template => 'foo', :send_file => { :filename => 'bar.pdf' },:password=>"xxx"
  Now pdf is password protected
  
Easy as pie

While converting the xhtml document into a pdf, the css stylesheets and images should be referenced with absolute URLs(either local or remote) or Flying Saucer will not be able to access them. 
If there is no asset host defined, it will set automatically during the pdf generation so the parser can access the requested resources:

View rendered in the browser:

    <%= stylesheet_link_tag("styles.css") %>
    #<link href="/stylesheets/styles.css?1228586784" media="screen" rel="stylesheet" type="text/css" />


    <%= image_tag("rails.png") %>
    # <img alt="Rails" src="/images/rails.png?1228433051" />
  
View rendered as pdf:

    <%= stylesheet_link_tag("styles.css") %>
    #<link href="http://localhost:3000/stylesheets/styles.css" media="print" rel="stylesheet" type="text/css" />


    <%= image_tag("rails.png") %>
    # <img alt="Rails" src="http://localhost:3000/images/rails.png" />
  
The stylesheet media type will be set to 'print' if none was given(otherwise it would not be parsed)

If you need to distinguish if the view is being rendered in the browser or as a pdf, you can use the @pdf\_mode variable, whose value will be set to :create
when generating the pdf version

Sinatra
-------
	 get '/' do
  	   content_type 'application/pdf'
  	   html_content = erb :index
       render_pdf(:template=>html_content,:pdf_file=>"test.pdf",
                :send_file=> {:file_name=>"test.pdf",:stream=>false},:password=>"xxx")
       end
Ruby
----
	class Pdf
    include ActsAsFlyingSaucer::Controller
    acts_as_flying_saucer
  		def generate_pdf(input_file_html_or_string,output_pdf)
  	  		options = ActsAsFlyingSaucer::Config.options.merge({:url=>input_file_html_or_string,:pdf_file=>output_pdf})
  		    render_pdf(options)
  		end
	end

 
Configuration
-------------

These are the default settings which can be overwritten in your enviroment configuration file:

    ActsAsFlyingSaucer::Config.options = {
      :java_bin => "java",          # java binary
      :classpath_separator => ':',  # classpath separator. unixes system use ':' and windows ';'
      :tmp_path => "/tmp",          # path where temporary files will be stored
      :max_memory_mb=>512,
      :nailgun =>false,
      :nailgun_port => '2113',
		  :nailgun_host => 'localhost'
    }
    
    
Advance Configuration (TODO: Manually)
-------------------
Now acts_as_flying_saucer call java each time on creating pdf this will speed down speed of generation of pdf.To overcome this start nailgun server that reads data from specific port and rendered pdf.so there is no need to launch the jvm every time a new pdf is generated.
Generate pdf with nailgun you have to overwrite Configuration make **nailgun option to true**


So to start nailgun with acts_as_flying_saucer gem:

<code>
 sudo gem install nailgun
</code>

Start nailgun server.Before starting nailgun server make sure that your **classpath environment variable** set and point to jre/lib

On startup or manually write following line
You can write into config/initializers/
After setting nailgun host and port
<code>
 ActsAsFlyingSaucer::Config.setup_nailgun
</code>

You can Manage nailgun using
<code>
  nailgun
</code>
It will generate nailgun_config binary and set configuration parameter
and now you can start and stop nailgun server

