Then /^I should see \((.*)\)$/ do |expr|
  string = "#{eval expr}".gsub('"', '\\"')
  Then %Q{I should see "#{string}"}
end

Then /^I should see "([^\"]*)" followed by "([^\"]*)"$/ do |string1, string2|
  Then %Q{I should see /(?m:#{Regexp.escape string1}.*#{Regexp.escape string2})/}
end

Then /^I should see the following in order:$/ do |table|
  # table is a Cucumber::Ast::Table
  strings = table.raw.flatten
  regexp = strings.collect {|s| Regexp.escape s }.join '.*'
  Then %Q{I should see /(?m:#{regexp})/}
end

Then /^I should (not )?see an element matching "([^\"]*)"$/ do |negation, selector|
  if negation
    response.should_not have_tag(selector)
  else
    response.should have_tag(selector)
  end
end