class Gj_app < ActiveRecord::Base
self.primary_key = 'gj_url'

  def self.per_page
    10
  end

  def self.convert
if ENV["OS"] =~ /Windows/
# Set this to point to the right Windows directory for ImageMagick.
"C:\\Program Files\\ImageMagick-6.7.0-Q16\\convert"
else
"/usr/bin/convert"
end
end

end
