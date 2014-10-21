my $t; use lib ($t = -e 't' ? 't' : 'test'), 'inc';

use TestpQuery tests => 1;

use pQuery;

open FILE, "$t/document1.html" or die $!;
my $html = do {local $/; <FILE>};
close FILE;
chomp $html;

my $output = '';
pQuery($html)->find('li')->each(sub {
    my $i = shift;
    my $text = pQuery($_)->text();
    $output .= ($i + 1) . ') ' . $text . "\n";
});

is $output, <<'...', 'each() and text() work';
1) one
2) two apple orange
3) apple
4) orange
5) three
...
