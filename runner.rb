# frozen_string_literal: true

# Run the program
require 'chunky_png'

require_relative 'comparator'
require_relative 'delta'
require_relative 'difference'
require_relative 'loader'

# Load two images into memory
run1 = %w[tapir tapir_hat]
run2 = %w[tapir_hat_light tapir_hat_dark]

# Run Visual Comparison
[run1, run2].each do |image_set|
  # Load Images into memory as Chunky Objects
  t = Time.now
  vl = Visual::Loader.new(*image_set)
  puts "Time taken to Load #{(Time.now - t).round(5)}"
  puts "\n" * 2

  # Compare images and store their raw difference data
  t = Time.now
  vc = Visual::Comparator.new(vl)
  vc.compare
  puts "Time taken to Compare #{(Time.now - t).round(5)}"
  puts "\n" * 2

  # Using the data, draw the difference picture
  t = Time.now
  filename = Visual::Difference.new(vc.difference_array, vl.images.first).draw
  puts "Time taken to Draw to #{filename} #{(Time.now - t).round(5)}"
  puts "\n" * 2

  # Also as an aside run the Delta algorithm (This isn't optimised fully)
  t = Time.now
  filename = Visual::Delta.new(vl).compare
  puts "Time taken to Compare and Draw Delta to #{filename} #{(Time.now - t).round(5)}"
  puts "\n" * 2
end
