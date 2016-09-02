class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  #has_many :likes, as: :likeable
  belongs_to :parent_comment, class_name:"Comment"
  has_many :nested_comments, class_name:"Comment", foreign_key:"parent_comment_id", dependent: :destroy
  has_many :likes, class_name: "Like", foreign_key: "comment_id", dependent: :destroy
end
