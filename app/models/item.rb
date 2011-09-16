class Item < ActiveRecord::Base
  belongs_to :snapshots
  belongs_to :users

  validates :name, :presence => true
  validates :description, :presence => true
  validates :price, :presence => true,
                    :numericality => {:greater_than_or_equal_to => 0.01}
  has_attached_file :photo, :styles => {:small => "50x50#", :large => "300x300>"},
                      :processors => [:cropper],
                      :url => "/assets/items/:id/:style/:basename.:extension",
                      :path => ":rails_root/public/assets/items/:id/:style/:basename.:extension"

   attr_accessor :crop_x, :crop_y, :crop_w, :crop_h


   after_update :reprocess_photo, :if => :cropping?

  def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end

  def self.search(search)
    if search
      find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    else
      find(:all)
  end
  end
  private

  def reprocess_photo
    photo.reprocess!
  end

end
