# frozen_string_literal: true

module Visual
  # Compare the two images and store results
  class Comparator
    attr_reader :loader
    attr_reader :base, :sample

    def initialize(loader)
      @loader = loader
      @base, @sample = loader.images
    end

    def compare
      puts 'Beginning comparison, This can take a few seconds.'
      puts "Sample Image Data Being processed: #{loader.scraped_image_data}."
      puts "Base Image Data Being processed: #{loader.baseline_image_data}."

      sample.height.times do |y|
        sample.row(y).each_with_index do |pixel, x|
          difference_array << [x, y] unless pixel == base[x, y]
        end
      end

      raw_metric_dump
    end

    def difference_array
      @difference_array ||= []
    end

    private

    def raw_metric_dump
      puts "pixels (total):       #{pixels}"
      puts "pixels different:     #{pixels_different}"
      puts "pixels different (%): #{pixels_different_as_percent}%"
    end

    def pixels
      loader.baseline_image_data[:area]
    end

    def pixels_different
      difference_array.length
    end

    def pixels_different_as_percent
      (pixels_different.to_f / pixels) * 100
    end
  end
end
