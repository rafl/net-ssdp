use strict;
use warnings;
use Test::More;

use Net::SSDP;

my $mainloop = Glib::MainLoop->new;

my $client = Net::SSDP::Client->new($mainloop->get_context);
isa_ok($client, 'Net::SSDP::Client');

my $group = Net::SSDP::ResourceGroup->new($client);
isa_ok($group, 'Net::SSDP::ResourceGroup');
$group->add_resource('foo:bar', 'uuid:42', 'moo');
$group->set_available(1);

my $browser = Net::SSDP::ResourceBrowser->new($client);
isa_ok($browser, 'Net::SSDP::ResourceBrowser');

$browser->set_active(1);

$browser->signal_connect('resource-available' => sub {
    my ($cb_browser, $usn, $locations, $user_data) = @_;
    return unless $usn eq 'uuid:42';

    is($cb_browser, $browser);
    is_deeply($locations, ['moo']);
    is($user_data, 'foo');

    $mainloop->quit;
}, 'foo');

# we'll just quite testing if we couldn't find our resources within 10 seconds
Glib::Timeout->add(10000, sub {
    $mainloop->quit;
    return 0;
});

$mainloop->run;

done_testing;
