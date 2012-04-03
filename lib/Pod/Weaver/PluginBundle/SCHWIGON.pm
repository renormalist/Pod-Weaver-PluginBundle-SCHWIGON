use strict;
use warnings;

package Pod::Weaver::PluginBundle::SCHWIGON;
# ABSTRACT: Document your modules like SCHWIGON does

# (well actuall like FLORA - as it is shamelessly stolen)

use Pod::Weaver::Config::Assembler;

sub _exp { Pod::Weaver::Config::Assembler->expand_package($_[0]) }

use namespace::clean;

=head1 DESCRIPTION

This is the L<Pod::Weaver> config I use for building my
documentation. I use it via L<Dist::Zilla::PluginBundle::SCHWIGON>.

=head1 SYNOPSIS

In weaver.ini:

  [@SCHWIGON]

or in dist.ini:

  [PodWeaver]
  config_plugin = @SCHWIGON

=head1 OVERVIEW

This plugin bundle is equivalent to the following weaver.ini file:

  [@CorePrep]

  [Name]

  [Region / prelude]

  [Generic / SYNOPSIS]
  [Generic / DESCRIPTION]
  [Generic / OVERVIEW]

  [Collect / ATTRIBUTES]
  command = attr

  [Collect / METHODS]
  command = method

  [Collect / FUNCTIONS]
  command = func

  [Leftovers]

  [Region / postlude]

  [Authors]
  [Legal]

  [-Transformer]
  transformer = List

  [-Encoding]

=begin Pod::Coverage

mvp_bundle_config

=end Pod::Coverage

=cut

sub mvp_bundle_config {
    return (
        [ '@SCHWIGON/CorePrep',  _exp('@CorePrep'),    {} ],
        [ '@SCHWIGON/Name',      _exp('Name'),         {} ],
        [ '@SCHWIGON/prelude',   _exp('Region'),       { region_name => 'prelude' } ],

        [ 'SYNOPSIS',         _exp('Generic'),      {} ],
        [ 'DESCRIPTION',      _exp('Generic'),      {} ],
        [ 'OVERVIEW',         _exp('Generic'),      {} ],

        [ 'ATTRIBUTES',       _exp('Collect'),      { command => 'attr'   } ],
        [ 'METHODS',          _exp('Collect'),      { command => 'method' } ],
        [ 'FUNCTIONS',        _exp('Collect'),      { command => 'func'   } ],
        [ 'TYPES',            _exp('Collect'),      { command => 'type'   } ],

        [ '@SCHWIGON/Leftovers', _exp('Leftovers'),    {} ],

        [ '@SCHWIGON/postlude',  _exp('Region'),       { region_name => 'postlude' } ],

        [ '@SCHWIGON/Authors',   _exp('Authors'),      {} ],
        [ '@SCHWIGON/Legal',     _exp('Legal'),        {} ],

        [ '@SCHWIGON/List',      _exp('-Transformer'), { transformer => 'List' } ],
        [ '@SCHWIGON/Encoding',  _exp('-Encoding'),    {} ],
    );
}

1;
