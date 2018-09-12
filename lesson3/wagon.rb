require_relative 'brand_name'

class Wagon
  include BrandName

  attr_reader :type
  
  def initialize(type, number)    
    @type = type
  end
end
