# frozen_string_literal: true

module Visual
  # Load the two images into memory
  class Loader
    attr_reader :baseline_image_name, :scraped_image_name

    def initialize(baseline_image, scraped_image)
      @baseline_image_name = baseline_image
      @scraped_image_name = scraped_image
    end

    def images
      [
        baseline_image,
        scraped_image
      ]
    end

    def baseline_image_data
      image_data(baseline_image)
    end

    def scraped_image_data
      image_data(scraped_image)
    end

    private

    def baseline_image
      ChunkyPNG::Image.from_file(image_location(baseline_image_name))
    end

    def scraped_image
      ChunkyPNG::Image.from_file(image_location(scraped_image_name))
    end

    def image_location(name)
      File.absolute_path("./images/#{name}.png")
    end

    def image_data(image)
      {
        height: image.height,
        width: image.width,
        area: image.pixels.length
      }
    end
  end
end
