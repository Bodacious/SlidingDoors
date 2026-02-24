# This file is used by Rack-based servers to start the application.

$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "sliding_doors"

run SlidingDoors.application
