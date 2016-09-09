require_relative '../data_mapper_setup'
require 'bcrypt'

class User
  include DataMapper::Resource

  property :id,     Serial
  property :email,  String, :required => true, :unique => true
  property :password_digest, Text

  attr_accessor :password_confirmation
  attr_reader :password

  validates_confirmation_of :password
  validates_format_of :email, :as => :email_address

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def check_password(password)
    BCrypt::Password.create(password) == self.password_digest
  end
end
