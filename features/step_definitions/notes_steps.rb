require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

Given /the following secrets exist for "(.*)"/ do |email, secrets_table|
  c = User.where(email: email)
  secrets_table.hashes.each do |n|
    c.secrets.create(n)
  end
end

When /I login as "(.*)"/ do |user|
  u = User.where(username: user)
  email = u.email
  password = u.password
  visit(new_user_session_path)
  step %Q[I fill in "Email" with #{email}]
  step %Q[I fill in "Password" with #{password}]
end
