![travis badge](https://travis-ci.org/octopusinvitro/conman.svg?branch=master "Conman at Travis")
[![BCH compliance](https://bettercodehub.com/edge/badge/octopusinvitro/conman?branch=master)](https://bettercodehub.com/)

# Contact Management app (ConMan&trade;)

This is a simple console app that keeps a list of contacts. You can:

1. List all contacts
1. Add contact
1. Search contact
1. Edit contact
1. Exit

### To run the app

```bash
$ bundle install
$ bin/app
```

### To run the tests

```bash
$ bundle exec rspec --color
```

Or simply [1]:

```bash
$ rspec --color
```

[1] Unless you have

```bash
alias rspec="rspec --color"
```

in your `.bash_profile`.

### Folder structure

* `bin `: Executables
* `lib `: Sources
* `spec`: Tests

## License

[![License](https://img.shields.io/badge/gnu-license-green.svg?style=flat)](https://opensource.org/licenses/GPL-2.0)
GNU License
