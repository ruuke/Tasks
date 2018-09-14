require_relative 'brand_name'

class Wagon
  include BrandName

  attr_reader :type
end
