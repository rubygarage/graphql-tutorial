class Comment < ApplicationRecord
  mount_uploader :attachment, AttachmentUploader

  belongs_to :task
end
