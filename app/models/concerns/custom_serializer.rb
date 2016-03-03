module CustomSerializer
  extend ActiveSupport::Concern

  def serialize(type=:default)
    @result = {}
    inner = as_json( only: self.class.send((type.to_s + "_params").to_sym) )
    @result[self.class.to_s.downcase] = inner
    @result
  end
end