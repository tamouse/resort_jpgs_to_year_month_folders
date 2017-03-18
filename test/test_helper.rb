$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'resort_jpgs_to_year_month_folders'

require 'minitest/autorun'
require 'fileutils'
require 'tmpdir'

TEST_IMAGE = File.expand_path('../test_image.jpg', __FILE__)
TEST_IMAGE_YEAR = '2015'
TEST_IMAGE_MONTH = '03'
TEST_IMAGE_NAME = '20150321_135437_test_image.jpg'

def run_in_tmpdir
  Dir.mktmpdir do |tmpdir|
    Dir.chdir(tmpdir) do |pwd|
      source = 'source'
      destination = 'destination'
      FileUtils.mkdir(source)
      FileUtils.mkdir(destination)
      test_file = File.join(source, File.basename(::TEST_IMAGE))
      FileUtils.cp(::TEST_IMAGE, test_file)
      assert File.exist?(test_file)

      resorter = ::ResortJpgsToYearMonthFolders::Resorter.new(source, destination)

      yield pwd, source, destination, test_file, resorter
    end
  end
end
