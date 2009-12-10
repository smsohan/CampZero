class AttachedFile < ActiveRecord::Base

  belongs_to :service

  has_attached_file :file, :styles => {:small => '80x60>', :medium => '400x300>'},
    :url  => "/attached_files/:id/:style/:basename.:extension",
    :path => ":rails_root/web/attached_files/:id/:style/:basename.:extension"

  validates_attachment_presence :file
  validates_presence_of :service_id

  def name
    file.original_filename
  end

  def url
    file.url
  end

  def path
    file.path
  end

  def content_type
    file.content_type
  end

  def created_at
    file_updated_at
  end

  def updated_at
    file_updated_at
  end
end
