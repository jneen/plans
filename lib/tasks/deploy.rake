def git(*a)
  cmd = ['git', *a.map(&:to_s)].join(' ')

  system cmd
end

task :deploy => ['sass:update'] do
  puts '> checkiing out production...'
  git 'checkout production'

  puts '> checking for a diff in the sass files...'
  if git 'diff public/stylesheets/'
    puts '> (no diff found)'
  else
    puts '> committing...'
    git %(add public/stylesheets/)
    git %(commit -m 'update generated stylesheets')
  end

  puts '> pushing to heroku...'
  git 'push heroku production:master'
end
