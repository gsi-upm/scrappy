require 'sinatra'
require 'thin'
require 'haml'
require 'scrappy/server/helpers'
require 'scrappy/server/admin'
require 'scrappy/server/errors'

module Scrappy
  class Server < Sinatra::Base
    helpers JavaScriptHelpers
    register Errors
    register Admin if Scrappy::Options.admin
    
    enable :sessions
    set    :root,          File.join(File.dirname(__FILE__), '..', '..', '..')
    set    :views,         Proc.new { File.join(root, "views") }
    set    :public_folder, Proc.new { File.join(root, "public") }

    get '/:format/*' do |format, url|
      process_request :get, format, url, params[:callback]
    end

    post '/:format/*' do |format, url|
      process_request :post, format, url, params[:callback]
    end

    protected
    def process_request method, format, url, callback
      url = url.gsub("http:/","http://").gsub("https:/","https://") if url.index(/http:\/\w/) or url.index(/https:\/\w/)
      response = agent.proxy :method=>method, :uri=>url, :inputs=>inputs, :format=>format.to_sym
      case response.status
      when :redirect
        redirect "#{settings.base_uri}/#{format}/#{simplify_uri(response.uri)}#{textual_inputs}"
      when :ok
        headers 'Content-Type' => response.content_type
        callback ? "#{callback}(#{response.output})" : response.output
      else
        status 500
        "Internal error"
      end
    end

    def agent
      return @agent if @agent
      if session[:agent].nil? || session[:token] != SESSION_TOKEN
        session[:token] = SESSION_TOKEN
        session[:agent] = Scrappy::Agent.new.id
      end
      @agent = Scrappy::Agent[session[:agent]]
    end

    def inputs
      params.reject{|k,v| ['callback', 'splat', 'format']}
    end
    
    def textual_inputs
      return '' if inputs.merge('callback'=>params[:callback]).reject{|k,v| v.nil?}.empty?
      "?" + (inputs.merge('callback'=>params[:callback]).reject{|k,v| v.nil?}.map{|k,v| "#{CGI.escape(k)}=#{CGI.escape(v)}"}*'')
    end
    
    def simplify_uri uri
      CGI::escape(uri).gsub('%2F','/').gsub('%3A',':')
    end
  end
end