use HTML::LinkExtor;
use LWP::Simple;

my $page = get(shift);

my $rec = new HTML::LinkExtor;

$rec -> parse($page);

my @enlaces = $rec -> links;

foreach(@enlaces)
{
    while(my($exc) = splice(@$_, 2))
    {
        next unless $exc =~ m/citations/;
        print "$exc\n";
    }
}

die
