# Onceover-Gatekeeper

*Ensuring nobody overrides compliance settings, with less code review!*

`onceover-gatekeeper` is intended for Puppet users that want to expand their Puppet deployment to multiple teams without drastically increasing the overhead required to ensure that other teams are not using shady solutions (i.e. resource collector overrides) to override the base compliance settings. This is achieved by compiling a base catalog against a subset of code, then ensuring that the complete role does no override anything generated from that subset. It is a plugin for [onceover](https://github.com/dylanratcliffe/onceover) and will not work on its own.

It does however have some limitations and should not be seen as a complete replacement for code review, see the [limitations](#limitations) section for more information.

## Getting started

If you are already using `onceover` to automatically test your Puppet roles, then the getting started process is simple:

  1. Add the gem to your Gemfile

  ```ruby
  gem 'onceover'
  gem 'onceover-gatekeeper' # <<< Add this
  ```

  2. Add a base class to one of the tests in your test matrix

  ```yaml
  test_matrix:
    - all_nodes:
        classes: 'all_classes'
        tests: 'spec'
        static_classes: # Classes that should not be overriden go here
          - 'profile::base'
  ```

## Feature roadmap

  - The ability to pre-compile reference catalogs and run tests against them
