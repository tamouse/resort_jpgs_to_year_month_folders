require 'test_helper'

class ResortJpgsToYearMonthFoldersTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ResortJpgsToYearMonthFolders::VERSION
  end

  def test_get_creation_date_returns_a_date_for_jpg_file
    run_in_tmpdir do |dir, source, destination, test_file, resorter|
      creation_date = resorter.get_creation_date(test_file)
      assert_instance_of(Time, creation_date)
    end
  end

  def test_new_file_name_components_returns_correct_hash
    run_in_tmpdir do |dir, source, destination, test_file, resorter|
      new_file_name_hash = resorter.new_file_name_components(test_file)
      assert_equal({
          name: ::TEST_IMAGE_NAME,
          year: ::TEST_IMAGE_YEAR,
          month: ::TEST_IMAGE_MONTH
        },
        new_file_name_hash)
    end
  end

  def test_that_it_copies_file_into_right_folders
    run_in_tmpdir do |dir, source, destination, test_file, resorter|
      resorter.copy_file(test_file)

      assert Dir.exist?(destination)
      assert Dir.exist?(File.join(destination, TEST_IMAGE_YEAR))
      assert Dir.exist?(File.join(destination, TEST_IMAGE_YEAR, TEST_IMAGE_MONTH))
      assert File.exist?(File.join(destination, TEST_IMAGE_YEAR, TEST_IMAGE_MONTH,
          TEST_IMAGE_NAME))

    end

  end



end
