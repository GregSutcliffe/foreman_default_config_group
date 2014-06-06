# Foreman Default Config Group Plugin

A quick plugin to ensure a Host has a particular ConfigGroup applied somewhere
in it's hierarchy.

## Installation

See [How_to_Install_a_Plugin](http://projects.theforeman.org/projects/foreman/wiki/How_to_Install_a_Plugin)
for how to install Foreman plugins

## Compatibility

| Foreman Version | Plugin Version |
| --------------- | --------------:|
| >= 1.5          | 0.0.1          |

## Usage

The configuration is done inside foreman's plugin settings directory which is
`~foreman/config/settings.plugins.d/`.

You can simply copy `default_config_group.yaml.example` and adjust it to fit
your needs. The simplest example would be:

```
---
:default_config_group: 'MyGroup'
```

*Important Note:* You have to restart foreman in order to apply changes in
`default_config_group.yaml`!

## TODO

* Rewrite to hook into the ENC calls rather than the fact uploads

## Contributing

Fork and send me a Pull Request. Thanks!

## Copyright

Copyright (c) 2014 Greg Sutcliffe

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.

