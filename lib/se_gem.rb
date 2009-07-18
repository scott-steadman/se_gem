
# automagically load core extensions
Dir['lib/se/core_ext/**/*.rb'].each do |file|
  require file.gsub!('.rb','')
end
