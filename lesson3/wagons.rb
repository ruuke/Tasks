require_relative 'maker_name'
class Wagon
  include MakerName
  attr_reader :type
  def initialize(type)    
    @type = type
  end
end
