# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{corefoundation}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Frederick Cheung"]
  s.date = %q{2012-12-06}
  s.description = %q{FFI based Ruby wrappers for Core Foundation }
  s.email = %q{frederick.cheung@gmail.com}
  s.files = ["lib/corefoundation.rb", "lib/corefoundation/array.rb", "lib/corefoundation/base.rb", "lib/corefoundation/boolean.rb", "lib/corefoundation/data.rb", "lib/corefoundation/date.rb", "lib/corefoundation/dictionary.rb", "lib/corefoundation/extensions.rb", "lib/corefoundation/null.rb", "lib/corefoundation/number.rb", "lib/corefoundation/string.rb", "lib/corefoundation/version.rb", "spec/array_spec.rb", "spec/boolean_spec.rb", "spec/data_spec.rb", "spec/date_spec.rb", "spec/dictionary_spec.rb", "spec/extensions_spec.rb", "spec/null_spec.rb", "spec/number_spec.rb", "spec/spec_helper.rb", "spec/string_spec.rb", "README.md", "LICENSE", "CHANGELOG"]
  s.homepage = %q{http://github.com/fcheung/corefoundation}
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.7")
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{Ruby wrapper for OS X corefoundation}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ffi>, [">= 0"])
      s.add_development_dependency(%q<rspec>, ["~> 2.10"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_development_dependency(%q<redcarpet>, [">= 0"])
    else
      s.add_dependency(%q<ffi>, [">= 0"])
      s.add_dependency(%q<rspec>, ["~> 2.10"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<redcarpet>, [">= 0"])
    end
  else
    s.add_dependency(%q<ffi>, [">= 0"])
    s.add_dependency(%q<rspec>, ["~> 2.10"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<redcarpet>, [">= 0"])
  end
end
