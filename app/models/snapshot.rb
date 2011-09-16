class Snapshot < ActiveRecord::Base
  belongs_to :users
  has_many :items, :dependent => :destroy
  has_attached_file :photo, :styles => {:small => "100x100#", :large => "500x500>"},
                    :url => "/assets/snapshots/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/snapshots/:id/:style/:basename.:extension"

  validates :title, :presence => true
  validates_attachment_presence :photo
  attr_accessor :cropx, :cropy, :cropwidth, :cropheight

  def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  private

  def reprocess_photo
    photo.reprocess!
  end
end
