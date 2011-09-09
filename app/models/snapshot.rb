class Snapshot < ActiveRecord::Base
  belongs_to :users
  has_many :items
  has_attached_file :photo,#, :styles => {:small => "300x300>"},
                    :url => "/assets/snapshots/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/snapshots/:id/:style/:basename.:extension"

  validates :title, :presence => true
  validates_attachment_presence :photo
  attr_accessor :cropx, :cropy, :cropwidth, :cropheight
end
