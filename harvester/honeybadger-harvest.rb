#!/usr/bin/env ruby
# frozen_string_literal: true

# Provide your honeybadger access token as the first argument

@token = ARGV[0]
$LOAD_PATH.unshift('lib')
require 'report_writer'

ReportWriter.write(token: @token, path: '../static')
