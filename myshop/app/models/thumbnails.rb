class Thumbnails
    require 'RMagick'
    include Magick
    def initialize(path=self)
        img = Image.read(path)[0]
        thumb = img.resize_to_fit(240)
        thumb.write path+'_thumb'
    end
end

