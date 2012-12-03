class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :trackable, :validatable

   has_many :items, :through => :snapshots, :order => :position
  has_many :snapshots

  # These attributes for a user
  attr_accessible :email, :password, :password_confirmation, :remember_me


  validates :email, :presence => true
end
