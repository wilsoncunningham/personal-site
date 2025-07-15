class HikingController < ApplicationController
  def index
    @gallery_images = [
      { file: "duck-pass-grass.jpg", caption: "Duck Pass, Mammoth Lakes, California" },
      { file: "humphreys.jpg", caption: "Humphreys Peak, Flagstaff, Arizona"},
      { file: "bright-angel.jpg", caption: "Bright Angel Trail, Grand Canyon, Arizona"},
      { file: "toms-thumb.jpg", caption: "Tom's Thumb, Scottsdale, Arizona"},
      { file: "see-canyon.jpg", caption: "See Canyon, Payson, Arizona"},
      { file: "joshua-tree-sunset.jpg", caption: "Joshua Tree National Park, California"},
      { file: "horton-creek.JPG", caption: "Horton Creek, Payson, Arizona"},
      { file: "conness-lake.jpg", caption: "Conness Lakes, Mono County, California"},
      { file: "flatiron-2.jpg", caption: "Flatiron, Superstition Mountains, Arizona"},
      { file: "sedona-red.JPG", caption: "Sedona, Arizona"},
      { file: "oak-creek.jpg", caption:  "Oak Creek, Sedona, Arizona"},
      { file: "flatiron-1.jpg", caption: "Flatiron, Superstition Mountains, Arizona"},
    ]

    render({:template => "hiking"})
  end
end
