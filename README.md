[![Build Status](https://travis-ci.org/Rubeasts/gitget.svg?branch=master)](https://travis-ci.org/Rubeasts/gitget)  
[![Gem Version](https://badge.fury.io/rb/gitget.svg)](https://badge.fury.io/rb/gitget)  
# gitget gem

Gitget is a gem that specializes in getting developers and their repository data on Github.

## Installation

If you are working on a project, add this to your Gemfile: `gem 'gitget'`

For ad hoc installation from command line:

```$ gem install gitget```

## Setup Github Credentials

Please setup your your github personal API token https://github.com/settings/tokens

## Usage

Require Gitget gem in your code: `require 'gitget'`

Supply your Github credentials to our library in one of two ways:
- Setup environment variables: `ENV['GH_USERNAME']` and `ENV['GH_TOKEN']`
- or, provide them directly to Gitget:

```ruby
Github::API.config = { username: ENV['GH_USERNAME'],
                       token: ENV['GH_TOKEN'] }
```
