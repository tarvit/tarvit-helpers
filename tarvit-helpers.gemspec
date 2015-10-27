# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: tarvit-helpers 0.0.18 ruby lib

Gem::Specification.new do |s|
  s.name = "tarvit-helpers"
  s.version = "0.0.18"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Vitaly Tarasenko"]
  s.date = "2015-10-27"
  s.description = " Simple extensions to standard Ruby classes and useful helpers. "
  s.email = "vetal.tarasenko@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/tarvit-helpers.rb",
    "lib/tarvit-helpers/extensions/colored_string.rb",
    "lib/tarvit-helpers/extensions/counter.rb",
    "lib/tarvit-helpers/modules/conditional_logger.rb",
    "lib/tarvit-helpers/modules/hash_presenter.rb",
    "lib/tarvit-helpers/modules/hash_presenter/cached_hash_presenter.rb",
    "lib/tarvit-helpers/modules/hash_presenter/custom_hash_presenter.rb",
    "lib/tarvit-helpers/modules/hash_presenter/observable_hash_presenter.rb",
    "lib/tarvit-helpers/modules/hash_presenter/simple_hash_presenter.rb",
    "lib/tarvit-helpers/modules/hash_presenter/with_rules_hash_presenter.rb",
    "lib/tarvit-helpers/modules/non_shared_accessors.rb",
    "lib/tarvit-helpers/modules/recursive_loader.rb",
    "lib/tarvit-helpers/modules/simple_crypt.rb",
    "spec/extensions/counter_spec.rb",
    "spec/modules/hash_presenter_spec.rb",
    "spec/modules/non_shared_accessors_spec.rb",
    "spec/modules/simple_crypt_spec.rb",
    "spec/spec_helper.rb",
    "tarvit-helpers.gemspec"
  ]
  s.homepage = "http://github.com/tarvit/tarvit-helpers"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "Simple extensions to standard Ruby classes and useful helpers."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_development_dependency(%q<shoulda>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_development_dependency(%q<bundler>, ["~> 1.0"])
      s.add_development_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 4.0"])
      s.add_dependency(%q<shoulda>, [">= 0"])
      s.add_dependency(%q<rdoc>, ["~> 3.12"])
      s.add_dependency(%q<bundler>, ["~> 1.0"])
      s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
      s.add_dependency(%q<simplecov>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 4.0"])
    s.add_dependency(%q<shoulda>, [">= 0"])
    s.add_dependency(%q<rdoc>, ["~> 3.12"])
    s.add_dependency(%q<bundler>, ["~> 1.0"])
    s.add_dependency(%q<jeweler>, ["~> 2.0.1"])
    s.add_dependency(%q<simplecov>, [">= 0"])
  end
end

