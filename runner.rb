# frozen_string_literal: true

# Run the program
require 'chunky_png'

require_relative 'visual/comparator'
require_relative 'visual/delta'
require_relative 'visual/difference'
require_relative 'visual/loader'

# Load two images into memory
run1 = %w[tapir tapir_hat]
run2 = %w[tapir_hat_light tapir_hat_dark]

# Run Visual Comparison
[run1, run2].each do |image_set|
  # Load Images into memory as Chunky Objects
  t = Time.now
  vl = Visual::Loader.new(*image_set)
  puts "Time to Load #{image_set} #{(Time.now - t).round(3)}s"

  # Compare images and store their raw difference data
  t = Time.now
  vc = Visual::Comparator.new(vl)
  vc.compare
  puts "Time to Compare #{image_set} #{(Time.now - t).round(3)}s"

  # Using the data, draw the difference picture
  t = Time.now
  file = Visual::Difference.new(vc.difference_array, vl.images.first).draw
  puts "Time to Draw Shaded Error of #{image_set} to #{file} #{(Time.now - t).round(3)}s"

  # Also as an aside run the Delta algorithm (This isn't optimised fully)
  t = Time.now
  file = Visual::Delta.new(vl).compare
  puts "Time to Compare and Draw Delta of #{image_set} to #{file} #{(Time.now - t).round(3)}s"
  puts "\n"* 2
end
