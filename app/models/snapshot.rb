# The program takes an initial word or phrase from
       # the command line (or in the absence of a
       # parameter from the first line of standard
       # input).  In then reads successive words or
       # phrases from standard input and reports whether
       # they are angrams of the first word.
       #
       # Author::    Dave Thomas  (mailto:dave@x.y)
       # Copyright:: Copyright (c) 2002 The Pragmatic Programmers, LLC
       # License::   Distributes under the same terms as Ruby

       # This class holds the letters in the original
       # word or phrase. The is_anagram? method allows us
       # to test if subsequent words or phrases are
       # anagrams of the original.
class Snapshot < ActiveRecord::Base
  belongs_to :users
  #snapshots have items.
  has_many :items, :dependent => :destroy , :order => :position
  has_attached_file :photo, :styles => {:small => "100x100#", :large => "500x500>"},
                    :url => "/assets/snapshots/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/assets/snapshots/:id/:style/:basename.:extension"

  #Title is a necessary field.
  validates :title, :presence => true
  validates_attachment_presence :photo

  # Attributes for the snapshot model.
  # - - Crop
  # The coordinates for the cropped image
  attr_accessor :cropx, :cropy, :cropwidth, :cropheight

  # Defines whether the snapshot is currently cropping. It is cropping if all four
  # cropping values are filled
  def cropping?
      !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  #Fills the geometry to decide which size to use.
  def photo_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(photo.path(style))
  end
  private

  #Reprocesses a photograph.
  def reprocess_photo
    photo.reprocess!
  end
end
