module SlideshowsHelper
  def thumbnail_tag(slide)
    image_tag "photos/#{slide.photo.thumbnail}" if slide
  end 
end
