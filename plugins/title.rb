#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# Copyright (c) 2010 Victor Bergoo
# This program is made available under the terms of the MIT License.

require 'cinch'
require 'nokogiri'
require 'curb'
require 'uri'
require 'cgi'

class Title
      include Cinch::Plugin
      
      match /(.*http.*)/, :use_prefix => false
      
      def execute m, message
        URI.extract(message, ["http", "https"]) do |uri|
          begin
            next if ignore uri
            
            m.reply response(m, parse(uri))
          rescue URI::InvalidURIError => e
            m.reply response_invalid(m, uri)
          end
        end
      rescue
        puts "URL doesn't exist or can't be accessed."
      end
      
      def response m, title
        suffix =  m.user.nick[-1] == 's' ? "'" : "'s"
        "URL: #{title}"
      end
      
      def response_invalid m, uri
        "Invalid url: #{uri}"
      end

      private

      def parse uri
        uri.gsub! "#!", "?_escaped_fragment_=" if uri.include? "#!"
        uri.gsub! /#.+$/, "" if uri.include? "#"
        
        call = Curl::Easy.perform(uri) do |easy| 
          easy.follow_location = true
	  easy.max_redirects = config["max_redirects"]
	  easy.headers["User-Agent"] = config["user_agent"] || 'cinch'
        end
        
        html = Nokogiri::HTML(call.body_str)
        title = html.at_xpath('//title')
        
        ignore if title.nil?
        CGI.unescape_html title.text.gsub(/\s+/, ' ')
      end
      
      def ignore uri
        ignore = ["jpg$", "JPG$", "jpeg$", "gif$", "png$", "PNG$", "bmp$", "pdf$", "jpe$", "zip$", "rar$", "mp4$", "avi$", "swf$", "webm$", "mkv$"]
        ignore.concat(config["ignore"]) if config.key? "ignore"
        
        ignore.each do |re|
          return true if uri =~ /#{re}/
        end
        
        false
      end
    end
