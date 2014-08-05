require 'ripl'
require 'json'
require "awesome_print"

require "ijson/version"
require "ijson/literal"
require "ijson/be_awesome"
require "ijson/command"
require "ijson/ext"

module Ijson
  module_function

  def load json_file
    Command.root = JSON.load File.read json_file
  end

  def start
    Ripl.start
  end
end

