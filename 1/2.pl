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

    return (\@left, \@right);
}

sub get_similarity {
    my %args  = @_;
    my @left  = @{$args{left}};
    my @right = @{$args{right}};

    my %seen;
    my $similarity = 0;

    for my $leftValue (@left) {
        if($seen{$leftValue}) {
            $similarity += $seen{$leftValue};
            next;
        }

        my $count = 0;
        for my $rightValue(@right) {
            $count++ if $leftValue == $rightValue;
        }

        $similarity += $leftValue*$count;
        $seen{$leftValue} = $leftValue*$count;
    }

    return $similarity;
}

my ($left, $right) = read_and_parse($opt{filename} || "input.txt");


print get_similarity(
    left  => $left,
    right => $right,
) . "\n";
