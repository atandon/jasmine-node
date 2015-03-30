
jasmine-node v2.0.0
===================

```sh
npm install -g aleclarson/jasmine-node
```

With [**jasmine-core**](https://www.npmjs.com/package/jasmine-core) as a new peer dependency, you gain control of which version of [**Jasmine**](https://github.com/jasmine/jasmine) to use. 

Specifying Jasmine's version when installing is easy:

```sh
npm install -g jasmine-core@2.2.0
```

If you simply want the latest version, omit the trailing `@2.2.0`.

```sh
npm install -g jasmine-core
```

**Be aware:** This repository does NOT support versions of Jasmine `<2.0.0`. 

Feel free to submit a pull request with a polyfill. :wink:

introduction
------------

Write the specifications for your code in `*Spec.js` and `*Spec.coffee` files in the `spec/` directory.
You can use sub-directories to better organise your specs. In the specs use `describe()`, `it()` etc. exactly
as you would in client-side Jasmine specs.

**Note**: your specification files must be named as `*spec.js`, `*spec.coffee` or `*spec.litcoffee`,
which matches the regular expression `/spec\.(js|coffee|litcoffee)$/i`;
otherwise **jasmine-node** won't find them!
For example, `sampleSpecs.js` is wrong, `sampleSpec.js` is right.
You can work around this by using either `--matchAll` or `-m REGEXP`.

You can require **jasmine-node** as a node module:

```javascript
jn = require('jasmine-node');
jn.run({
  specFolders:['./spec']
});
```

The **jasmine-node** object returned contains a defaults object so that you can see
what the expected args are. Pass only the options you need (the rest will be
filled in by the defaults) to the `.run(<options>)` command and away you go!

You can supply the following arguments:
  *  `--autoTest`               -  rerun automatically the specs when a file changes
  *  `--coffee`                 -  load coffee-script which allows execution .coffee files
  *  `--help, -h`               -  display this help and exit
  *  `--junit`                  -  use the junit xml reporter
  *  `--match, -m REGEXP`       -  load only specs containing "REGEXPspec"
  *  `--matchAll`               -  relax requirement of "spec" in spec file names
  *  `--noColor`                -  do not use color coding for output
  *  `--noStackTrace`           -  suppress the stack trace generated from a test failure
  *  `--nunit`                  -  use the nunit xml reporter
  *  `--reporterConfig <file>`  -  configuration json file to use with jasmine-reporters
  *  `--verbose`                -  print extra information per each test run
  *  `--version`                -  show the current version
  *  `--watchFolders PATH`      -  when used with --autoTest, watches the given path(s) and runs all tests if a change is detected

Individual files to test can be added as bare arguments to the end of the args.

Example:

```bash
jasmine-node --coffee spec/AsyncSpec.coffee spec/CoffeeSpec.coffee spec/SampleSpec.js
```

jasmine-reporters options
-------------------------

To use default options, just specify `--junit` or `--nunit`

If you want to configure, also use `--reporterConfig path/to/config.json`

### Example JSON File with known options ###

Please checkout the
[jasmine-reporters](https://github.com/larrymyers/jasmine-reporters) repo for
more configuration information and documentation

```json
{
    "savePath": "./junit-reports/",
    "consolidateAll": true,
    "consolidate": true,
    "useDotNotation": false,
    "filePrefix": ""
}
```

growl notifications
-------------------

**jasmine-node** can display [Growl](http://growl.info) notifications of test
run summaries in addition to other reports.
Growl must be installed separately, see [node-growl](https://github.com/visionmedia/node-growl)
for platform-specific instructions. Pass the `--growl` flag to enable the notifications.

development
-----------

Install the dependent packages by running:

```sh
npm install
```

Before you submit a pull request, run the `test.bash` script to make sure everything's working as expected.

```sh
bash test.bash
```
