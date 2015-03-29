
growlReporter  = require 'jasmine-growl-reporter'
nodeReporters  = require '../reporter'
junitReporter  = require '../junit-reporter'

boot = (jasmineRequire, clockCallback) ->

  jasmine = jasmineRequire.core jasmineRequire
  env = jasmine.getEnv()

  global[name] = property for name, property of jasmineRequire.interface jasmine, env
  global.jasmine = jasmine
  
  clockInstaller = jasmine.currentEnv_.clock.install
  jasmine.currentEnv_.clock.install = ->
    clockCallback(true, env.clock)
    return clockInstaller()
  
  clockUninstaller = jasmine.currentEnv_.clock.uninstall
  jasmine.currentEnv_.clock.uninstall = ->
    clockCallback(false, env.clock)
    return clockUninstaller()

  # Expose the interface for adding custom equality testers.
  jasmine.addCustomEqualityTester = (tester) ->
    env.addCustomEqualityTester tester

  # Expose the interface for adding custom expectation matchers
  jasmine.addMatchers = (matchers) ->
    return env.addMatchers matchers

  # Expose the mock interface for the JavaScript timeout functions
  jasmine.clock = ->
    return env.clock

  # Add reporters
  jasmine.TerminalReporter = nodeReporters.TerminalReporter
  jasmine.JUnitReporter    = junitReporter.JUnitReporter
  jasmine.GrowlReporter    = growlReporter

  return jasmine

module.exports = { boot }
