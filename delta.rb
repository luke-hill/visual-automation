module Visual
  # Calculate a Delta Score based on gradient difference
  class Delta
    include ChunkyPNG::Color

    attr_reader :loader
    attr_reader :base, :sample

    def initialize(loader)
      @loader = loader
      @base, @sample = loader.images
    end

    def compare
      output = ChunkyPNG::Image.new(base.width, sample.width, WHITE)

      puts 'Beginning comparison, This can take a few seconds.'
      puts "Sample Image Data Being processed: #{loader.scraped_image_data}."
      puts "Base Image Data Being processed: #{loader.baseline_image_data}."

      base.height.times do |y|
        base.row(y).each_with_index do |pixel, x|
          unless pixel == sample[x,y]
            score = Math.sqrt(
              (r(sample[x,y]) - r(pixel)) ** 2 +
                (g(sample[x,y]) - g(pixel)) ** 2 +
                (b(sample[x,y]) - b(pixel)) ** 2
            ) / Math.sqrt(MAX ** 2 * 3)

            output[x,y] = grayscale(MAX - (score * 255).round)
            difference_array << score
          end
        end
      end

      raw_metric_dump
      output.save(error_image_filename)
      error_image_filename
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
      (difference_array.inject { |sum, value| sum + value } / pixels) * 100
    end

    def error_image_filename
      @error_image_filename ||= File.absolute_path("./images/results/Delta-DIFF#{rand(20)}.png")
    end
  end
end
