class Category < ActiveRecord::Base
  has_and_belongs_to_many :photos
  acts_as_tree
    
  def ancestors_name
    if parent
      parent.ancestors_name + parent.name + ':'
    else
      ""
    end
  end
  
  def long_name
    ancestors_name + name
  end
  
  def photos_including_child_categories
    result = photos.clone
    children.each do |c|
      c.photos_including_child_categories.each {|p| result << p if not result.include? p}
    end
    result
  end
end
