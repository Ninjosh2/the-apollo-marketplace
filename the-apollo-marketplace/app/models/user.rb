class User < ActiveRecord::Base
    has_secure_password
    has_many :sale_entries
end