Gem::Specification.new do |s|
  s.name        = 'libraryh3lp'
  s.version     = '0.1.0'
  s.date        = '2013-07-18'
  s.summary     = "Libraryh3lp Ruby SDK"
  s.description = "Convenience wrappers for the LibraryH3lp REST API."
  s.authors     = ["Mike McCarty"]
  s.email       = 'mike@nubgames.come'
  s.files       = [
                   "lib/libraryh3lp/calls.rb",
                   "lib/libraryh3lp/chats.rb",
                   "lib/libraryh3lp/presence.rb",
                   "lib/libraryh3lp/questions.rb",
                   "lib/libraryh3lp/queues.rb",
                   "lib/libraryh3lp/reports.rb",
                   "lib/libraryh3lp/resource.rb",
                   "lib/libraryh3lp/services.rb",
                   "lib/libraryh3lp/users.rb",
                   "lib/libraryh3lp/widgets.rb"]
  s.homepage    =
    'https://github.com/nubgames/libraryh3lp-sdk-ruby'
end