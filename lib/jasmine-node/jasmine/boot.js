(function() {
  var boot, growlReporter, junitReporter, nodeReporters;

  growlReporter = require('jasmine-growl-reporter');

  nodeReporters = require('../reporter');

  junitReporter = require('../junit-reporter');

  boot = function(jasmineRequire, clockCallback) {
    var clockInstaller, clockUninstaller, env, jasmine, name, property, _ref;
    jasmine = jasmineRequire.core(jasmineRequire);
    env = jasmine.getEnv();
    _ref = jasmineRequire["interface"](jasmine, env);
    for (name in _ref) {
      property = _ref[name];
      global[name] = property;
    }
    global.jasmine = jasmine;
    clockInstaller = jasmine.currentEnv_.clock.install;
    jasmine.currentEnv_.clock.install = function() {
      clockCallback(true, env.clock);
      return clockInstaller();
    };
    clockUninstaller = jasmine.currentEnv_.clock.uninstall;
    jasmine.currentEnv_.clock.uninstall = function() {
      clockCallback(false, env.clock);
      return clockUninstaller();
    };
    jasmine.addCustomEqualityTester = function(tester) {
      return env.addCustomEqualityTester(tester);
    };
    jasmine.addMatchers = function(matchers) {
      return env.addMatchers(matchers);
    };
    jasmine.clock = function() {
      return env.clock;
    };
    jasmine.TerminalReporter = nodeReporters.TerminalReporter;
    jasmine.JUnitReporter = junitReporter.JUnitReporter;
    jasmine.GrowlReporter = growlReporter;
    return jasmine;
  };

  module.exports = {
    boot: boot
  };

}).call(this);
