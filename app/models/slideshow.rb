class Slideshow < ActiveRecord::Base
has_many :slides, :order => :position

def self.search(page)
  paginate :per_page => 2, :page => page
end

end
