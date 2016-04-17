#! /usr/bin/perl
use strict; use warnings;
use HTML::TableExtract 'tree';
use Text::CSV;
use LWP::Simple;

# input
my $url= shift @ARGV;
$url =~ /([\w\_\d]+$)/;
my $out_name = $1;
my $html = get($url);
my  $te = HTML::TableExtract->new();
$te->parse($html);

# output
my $csvfile = "$out_name.csv";
my $csv = Text::CSV->new ( { binary => 1, eol => "\n" } ) 
          or die "Cannot use CSV: ".Text::CSV->error_diag ();
open my $fh, '>:encoding(utf-8)', $csvfile or die "$csvfile : $!";

# process
my $count=0;
printf "%3s %4s %4s\n",'Tbl','Rows','Cols';
foreach my $ts ($te->tables){

  my $tree = $ts->tree();
  printf "%3d %4d %4d\n",++$count,$tree->maxrow,$tree->maxcol;

  foreach my $r (0..$tree->maxrow){
    my @cells=();
    
    # is col 1 an img ?
    my $x = $tree->cell($r,0)->look_down('src',qr/png$/);
    push @cells,(defined $x) ? $x->attr('src') : $tree->cell($r,0)->as_text;
    
    for my $c (1..$tree->maxcol){
      my $val = $tree->cell($r,$c)->as_text; 
      push @cells,$val;
    }
    $csv->print ($fh, \@cells);
  }
}
close $fh or die "$csvfile: $!";
