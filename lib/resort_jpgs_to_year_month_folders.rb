require "exifr"
require "fileutils"
require "resort_jpgs_to_year_month_folders/version"

module ResortJpgsToYearMonthFolders
  class Resorter

    def initialize(source, destination)
      @source = File.realpath(source)
      @destination = File.realpath(destination)
    end

    def get_creation_date(image)
      EXIFR::JPEG.new(image).date_time_original
    end

    def new_file_name_components(image)
      created = get_creation_date(image)
      year = created.strftime("%Y")
      month = created.strftime("%m")
      name = "#{created.strftime("%Y%m%d_%H%M%S")}_#{File.basename(image).downcase.gsub(/ +/,'-')}"
      {
        name: name,
        year: year,
        month: month
      }
    end

    def copy_file(image)
      components = new_file_name_components(image)
      FileUtils.mkdir_p(File.join(@destination, components[:year], components[:month]))
      FileUtils.cp(image, File.join(@destination,
          components[:year],
          components[:month],
          components[:name]
          ))
    end

  end
end
