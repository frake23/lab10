# frozen_string_literal: true

require 'net/http'
require 'nokogiri'

class HomeController < ApplicationController
  API_URL = 'http://localhost:3000/calc.xml'
  XSLT_BROWSER_TRANSFORM = '/browser_transform.xslt'
  XSLT_SERVER_TRANSFORM  = "#{Rails.root}/public/server_transform.xslt".freeze

  def request_to_api
    Net::HTTP.post(URI(API_URL), URI.encode_www_form({ 'arr' => params[:arr] })).body
  end

  def calc
    res = request_to_api
    respond_to do |format|
      format.html { @output = xslt_transform(res).to_html }
      format.xml { render xml: insert_browser_xslt(res).to_xml }
      format.rss { render xml: insert_browser_xslt(res).to_xml }
    end
  end

  def rawcalc
    render xml: request_to_api
  end

  def xslt_transform(data, transform: XSLT_SERVER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XSLT(File.read(transform))
    xslt.transform(doc)
  end

  def insert_browser_xslt(data, transform: XSLT_BROWSER_TRANSFORM)
    doc = Nokogiri::XML(data)
    xslt = Nokogiri::XML::ProcessingInstruction.new(doc,
                                                    'xml-stylesheet',
                                                    "type=\"text/xsl\" href=\"#{transform}\"")
    doc.root.add_previous_sibling(xslt).then { doc }
  end
end
