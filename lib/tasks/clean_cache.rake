desc 'Delete the cache from `tmp/cache/` folder'
task :clean_cache do
  puts 'Deleting cache from `/tmp/cache/*`'
  rm_r FileList["tmp/cache/*"]
end