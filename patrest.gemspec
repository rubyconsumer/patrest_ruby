# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{patrest}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Trek Glowacki"]
  s.date = %q{2009-04-26}
  s.description = %q{patrest is a Ruby library for talking to libraries using the Ann Arbor District Library\'s PatREST API.'}
  s.email = %q{trek.glowacki@gmail.com}
  s.files = ["README.markdown", "lib/patrest", "lib/patrest/patron", "lib/patrest/record", "lib/patrest/search"]
  s.has_rdoc = false
  s.homepage = %q{http://github.com/trek/patrest-ruby}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary =%q{patrest is a Ruby library for talking to libraries using the Ann Arbor District Library\'s PatREST API.'}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<httparty>, [">= 0.4.3"])
    else
      s.add_dependency(%q<httparty>, [">= 0.4.3"])
    end
  else
    s.add_dependency(%q<httparty>, [">= 0.4.3"])
  end
end
