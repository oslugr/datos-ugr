use Perl::Critic;
my $file = shift;
my $critic = Perl::Critic->new(-severity => 4);
my @violations = $critic->critique($file);
print @violations;