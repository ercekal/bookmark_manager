require 'dm-migrations'
require 'data_mapper'
require 'dm-postgres-adapter'

class Links

  include DataMapper::Resource

  property :id, Serial
  property :name, String

end
