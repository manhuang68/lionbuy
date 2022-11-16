Given /the following order histories exist/ do |oh_table|
  oh_table.hashes.each do |h|
    History.create h
  end
end