use Getopt::Long;
use Data::Dumper;

my %opt;

GetOptions(
    \%opt,
    'filename|f=s',
);

sub read_and_parse {
    my $filename = shift;

    open(FH, '<', $filename) or die "Failed to open file: $!";

    my @left;
    my @right;

    while(<FH>){
        my @split = split(' ', $_);
        
        push(@left,  $split[0]);
        push(@right, $split[1]);
    }

    @left  = sort @left;
    @right = sort @right;

    return (\@left, \@right);
}

sub get_distances {
    my %args  = @_;
    my @left  = @{$args{left}};
    my @right = @{$args{right}};

    my $total_distance = 0;

    for(0..$#left) {
        $total_distance += abs($left[$_] - $right[$_]);
    }

    return $total_distance;
}

my ($left, $right) = read_and_parse($opt{filename} || "input.txt");


print get_distances(
    left  => $left,
    right => $right,
) . "\n";
