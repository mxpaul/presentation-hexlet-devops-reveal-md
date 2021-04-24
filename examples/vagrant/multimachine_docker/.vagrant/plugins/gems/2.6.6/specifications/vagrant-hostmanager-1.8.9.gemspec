# -*- encoding: utf-8 -*-
# stub: vagrant-hostmanager 1.8.9 ruby lib

Gem::Specification.new do |s|
  s.name = "vagrant-hostmanager".freeze
  s.version = "1.8.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Shawn Dahlen".freeze, "Seth Reeser".freeze]
  s.date = "2018-05-18"
  s.description = "A Vagrant plugin that manages the /etc/hosts file within a multi-machine environment".freeze
  s.email = ["shawn@dahlen.me".freeze, "info@devopsgroup.io".freeze]
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.0.3".freeze
  s.summary = "A Vagrant plugin that manages the /etc/hosts file within a multi-machine environment".freeze

  s.installed_by_version = "3.0.3" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_development_dependency(%q<rake>.freeze, [">= 0"])
    else
      s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
      s.add_dependency(%q<rake>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<bundler>.freeze, ["~> 1.3"])
    s.add_dependency(%q<rake>.freeze, [">= 0"])
  end
end
