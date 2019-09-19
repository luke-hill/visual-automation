# frozen_string_literal: true

module Visual
  # Calculate the difference of the 2 images
  class Difference
    attr_reader :difference_array, :base_image

    def initialize(difference_array, base_image)
      @difference_array = difference_array
      @base_image = base_image
    end

    def draw
      create_new_image!(x_y_min_max)
    end

    private

    def x_y_min_max
      [x_diffs.min, y_diffs.min, x_diffs.max, y_diffs.max]
    end

    def x_diffs
      difference_array.map { |xy| xy[0] }
    end

    def y_diffs
      difference_array.map { |xy| xy[1] }
    end

    def create_new_image!(coords)
      base_image.rect(*coords, green, fill_color)
      base_image.save(error_image_filename)
      error_image_filename
    end

    def error_image_filename
      @error_image_filename ||= File.absolute_path("./images/results/DIFF#{rand(20)}.png")
    end

    def green
      ChunkyPNG::Color.rgb(0, 255, 0)
    end

    def transparent
      ChunkyPNG::Color::TRANSPARENT
    end

    def fill_color
      if filled_solid?
        green
      else
        transparent
      end
    end

    # Whether the square will be filled in solid or not
    def filled_solid?
      true
    end
  end
end
