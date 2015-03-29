growlReporter  = require 'jasmine-growl-reporter'
nodeReporters  = require '../reporter'
junitReporter  = require '../junit-reporter'

# Node Translation of the Jasmine boot.js file. Seems to work quite well
boot = (jasmineRequire, clockCallback) ->
  jasmine = jasmineRequire.core jasmineRequire
  ###
  Helper function for readability above.
  ###
  extend = (destination, source) ->
    for name, property of source
      destination[name] = property
    return destination

  ###
  Create the Jasmine environment. This is used to run all specs in a project.
  ###
  env = jasmine.getEnv()

  # Attach our reporters
  jasmine.TerminalReporter = nodeReporters.TerminalReporter
  jasmine.JUnitReporter    = junitReporter.JUnitReporter
  jasmine.GrowlReporter    = growlReporter

  # The global.jasmine interface
  extend global, jasmineRequire.interface jasmine, jasmine.getEnv()
  global.jasmine = jasmine

  clockInstaller = jasmine.currentEnv_.clock.install
  clockUninstaller = jasmine.currentEnv_.clock.uninstall
  jasmine.currentEnv_.clock.install = ->
    clockCallback(true, env.clock)
    return clockInstaller()
  jasmine.currentEnv_.clock.uninstall = ->
    clockCallback(false, env.clock)
    return clockUninstaller()

  ###
  Expose the interface for adding custom equality testers.
  ###
  jasmine.addCustomEqualityTester = (tester) ->
    env.addCustomEqualityTester tester

  ###
  Expose the interface for adding custom expectation matchers
  ###
  jasmine.addMatchers = (matchers) ->
    return env.addMatchers matchers

  ###
  Expose the mock interface for the JavaScript timeout functions
  ###
  jasmine.clock = ->
    return env.clock

  return jasmine

module.exports = {boot}
