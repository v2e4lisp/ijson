require 'ripl'
require 'json'
require "awesome_print"

require "ijson/version"
require "ijson/literal"
require "ijson/be_awesome"

module Ijson
  module_function

  def load json_file
    Command.root = JSON.load File.read json_file
  end

  def start
    require "ijson/ext"
    Ripl.start
  end
end

