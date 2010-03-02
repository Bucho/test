module SlideshowsHelper
  def thumbnail_tag(slide)
    image_tag("#{slide.photo.thumbnail}", :style =>"vertical-align:middle") if slide
  end 
end
