#     Read files from a specified folder directory to sort them out alphanumerically.

# ... file Dir variable initialized
file_path = './'

begin
  # ... process, may raise an exception
  File.directory?(file_path)

  # ... get the all file names under the specified dir
  files = Dir.entries(file_path)

  # ... define the length of the array files
  arr_files = Array.new(files.length)

  # ... assign files name to empty array
  arr_files = files

  # ... sort the array files using sort-by method
  sorted_array = arr_files.sort_by do |s|
    # use `sort_by` for a keyed sort, not `sort`
    s
      .split(/(\d+)/) # split numeric parts from non-numeric
      .map do |s| # the below parses numeric parts as decimals, ignores the rest
      Integer(s, 10); rescue ArgumentError; s
    end
  end.slice(2, 51)

  # ... remove the file's extensions => .jpg, .png, pdf, mp3
  new_arr_files = []
  i = 0
  while i < sorted_array.length
    new_arr_files.push(File.basename(sorted_array[i], File.extname(sorted_array[i])))
    i += 1
  end

  # ... open sample.txt file to parse sorted_array
  File.open('sample.txt', 'w') { |f| f.write "#{Time.now.ctime} - User logged in\n #{new_arr_files}" }

  # ... print into the console to check
  print "\n", new_arr_files
rescue Exception => e
  # ... error handler
  puts "\n", e.message
  puts "\nFailed..! File directory does not exist"
else
  # ... executes when no error
  puts "\nSuccess.. | File directory exist.. | File names written into the file.."
ensure
  # ... always executed
  puts "\nProcess is completed..!!"
end
