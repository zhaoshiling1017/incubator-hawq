#!/usr/bin/perl
#
# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.
#
# SLZY_HDR_END

use POSIX;
use Pod::Usage;
use Getopt::Long;
use Data::Dumper;
use strict;
use warnings;

# SLZY_POD_HDR_BEGIN
# WARNING: DO NOT MODIFY THE FOLLOWING POD DOCUMENT:
# Generated by sleazy.pl version 6 (release Mon Aug 20 12:30:03 2012)
# Make any changes under SLZY_TOP_BEGIN/SLZY_LONG_BEGIN

=head1 NAME

B<caqluniqdef.pl> - convert uniqdef.json to external table format

=head1 VERSION

 This document describes version 1 of caqluniqdef.pl, released
 Tue Oct 30 15:57:43 2012.

=head1 SYNOPSIS

B<caqluniqdef.pl> 

Options:

    -help   brief help message
    -man    full documentation

=head1 OPTIONS

=over 8

=item B<-help>

    Print a brief help message and exits.

=item B<-man>

    Prints the manual page and exits.


=back

=head1 DESCRIPTION


caqluniqdef.pl reads the calico.pl uniqdef.json doc and outputs a "|"
delimited flat file, suitable for input as an external table.

=head2 Usage

 CREATE EXTERNAL TABLE
       EXT_uniqdef  (
       uniq_qry text,
       bcount integer,
       bdelete integer,
       binsert integer,
       bupdate integer,
       basequery_code integer,
       base_qry text,
       colnum char(64),
       cql char(6),
       tablename char(64),
       uniqquery_code integer)
 location ('file://some/file/location' )
	FORMAT 'text' (delimiter '|');




=head1 AUTHORS

Apache HAWQ

Address bug reports and comments to: dev@hawq.incubator.apache.org

=cut
# SLZY_POD_HDR_END

# SLZY_GLOB_BEGIN
my $glob_id;
my $glob_glob;
# SLZY_GLOB_END

# stub for global validation function
sub glob_validate
{
	# look for JSON on normal path, but if it isn't there, add the
	# directory containing this script and look for it there...
	unless (eval "require JSON")
	{
		use FindBin qw($Bin);
		use lib "$Bin";

		unless (eval "require JSON")
		{
			die("Fatal Error: The required package JSON is not installed -- please download it from www.cpan.org\n");
			exit(1);
		}
	}

}

# SLZY_CMDLINE_BEGIN
# WARNING: DO NOT MODIFY THE FOLLOWING SECTION:
# Generated by sleazy.pl version 6 (release Mon Aug 20 12:30:03 2012)
# Make any changes under SLZY_TOP_BEGIN/SLZY_LONG_BEGIN
# Any additional validation logic belongs in glob_validate()

BEGIN {
	    my $s_help  = 0;     # brief help message
	    my $s_man   = 0;     # full documentation

	my $slzy_argv_str;
	$slzy_argv_str = quotemeta(join(" ", @ARGV))
		if (scalar(@ARGV));

    GetOptions(
		'help|?'     =>     \$s_help,
		'man'        =>     \$s_man,
               )
        or pod2usage(2);

	pod2usage(-msg => $glob_id, -exitstatus => 1) if $s_help;
	pod2usage(-msg => $glob_id, -exitstatus => 0, -verbose => 2) if $s_man;
	
	
	$glob_glob = {};
	
	
	# version and properties from json definition
	$glob_glob->{_sleazy_properties} = {};
	$glob_glob->{_sleazy_properties}->{version} = '1';
	$glob_glob->{_sleazy_properties}->{slzy_date} = '1351637863';
	$glob_glob->{_sleazy_properties}->{slzy_argv_str} = $slzy_argv_str;
	
	
	
	glob_validate();


}
# SLZY_CMDLINE_END


# SLZY_TOP_BEGIN
if (0)
{
    my $bigstr = <<'EOF_bigstr';
{
   "args" : [
      {
         "alias" : "?",
         "long" : "Print a brief help message and exits.",
         "name" : "help",
         "required" : "0",
         "short" : "brief help message",
         "type" : "untyped"
      },
      {
         "long" : "Prints the manual page and exits.",
         "name" : "man",
         "required" : "0",
         "short" : "full documentation",
         "type" : "untyped"
      }
   ],
   "long" : "$toplong",
   "properties" : {
      "slzy_date" : 1351637863
   },
   "short" : "convert uniqdef.json to external table format",
   "version" : "1"
}

EOF_bigstr
}
# SLZY_TOP_END

# SLZY_LONG_BEGIN
if (0)
{
	# Construct a series of "Here" documents to contain formatted long
	# strings for the JSON document.

	my $toplong = <<'EOF_longstr';

caqluniqdef.pl reads the calico.pl uniqdef.json doc and outputs a "|"
delimited flat file, suitable for input as an external table.

{HEAD2} Usage

 CREATE EXTERNAL TABLE
       EXT_uniqdef  (
       uniq_qry text,
       bcount integer,
       bdelete integer,
       binsert integer,
       bupdate integer,
       basequery_code integer,
       base_qry text,
       colnum char(64),
       cql char(6),
       tablename char(64),
       uniqquery_code integer)
 location ('file://some/file/location' )
	FORMAT 'text' (delimiter '|');



EOF_longstr
}
# SLZY_LONG_END

if (1)
{
	my $whole_file;
	
	{
        # $$$ $$$ undefine input record separator (\n)
        # and slurp entire file into variable

        local $/;
        undef $/;

		$whole_file = <>;

	}

	my $bigh = JSON::from_json($whole_file);

#	my $d1 = $bigh->[0];
	my $d1 = $bigh;

	for my $k1 (keys(%{$d1}))
	{
		my @foo;

		push @foo, $k1, 
		$d1->{$k1}->{bCount},
		$d1->{$k1}->{bDelete},
		$d1->{$k1}->{bInsert},
		$d1->{$k1}->{bUpdate},
		$d1->{$k1}->{basequery_code},
		$d1->{$k1}->{basic},
		$d1->{$k1}->{colnum},
		$d1->{$k1}->{cql},
		$d1->{$k1}->{tablename},
		$d1->{$k1}->{uniqquery_code};

		print join('|', @foo), "\n";

	}

}
