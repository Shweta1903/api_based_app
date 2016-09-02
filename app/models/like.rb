class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :comment
  belongs_to :liker, class_name: 'User'
  belongs_to :likeable, polymorphic: true
end
