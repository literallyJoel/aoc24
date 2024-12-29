use Getopt::Long;

my %opt;

GetOptions(
    \%opt,
    'filename|f=s',
);

sub get_safety {
    my $filename = shift;

    open(FH, '<', $filename) or die "Failed to open file: $!";

    my $safe_count = 0;
    
    while(<FH>){
        my @values = split(" ", $_);
        my $safe   = 1;
        my $is_ascending;
    
        $is_ascending = $values[0] < $values[1];

        for(0..$#values-1) {

            if ($values[$_] == $values[$_ +1]) {
                $safe = 0;
                last;
            }
            
            if($is_ascending && $values[$_] > $values[$_ +1]) {
                $safe = 0;
                last;
            }

            if(!$is_ascending && $values[$_] < $values[$_ +1]) {
                $safe = 0;
                last;
            }

            if(abs($values[$_] - $values[$_ +1]) > 3) {
                $safe = 0;
                last;
            }
        }

        $safe_count += $safe;
    }

    return $safe_count
}

print get_safety($opt{filename} || "input.txt") . "\n";