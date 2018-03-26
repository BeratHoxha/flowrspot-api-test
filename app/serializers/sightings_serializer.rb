class SightingsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :picture, :likes_count, :comments_count

  belongs_to :user, serializer: SightingsUserSerializer

  def picture
    object.picture.url(:medium)
  end

  def likes_count
    # remove this when counter cashe for likes is made
    0
  end

  def comments_count
    # remove this when counter cashe for comments is made
    0
  end
end
