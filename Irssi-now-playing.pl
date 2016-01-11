use strict;
use Irssi;
use vars qw($VERSION %IRSSI);
$VERSION = "1.0";
%IRSSI = {
    authors     => 'David	',
    contact     => 'xxx',
    name        => 'np',
    description => 'you figure it out',
    license     => '',
    changed     => ''
};

my $npfile = "SÖKVÄGEN TILL DIN NOWPLAYING FIL";

Irssi::command_bind("np", \&cmd_np);


sub cmd_np
{
        my ($args, $server, $dest) = @_;

        my ($msg,@text,@matches);
        if(open(NP, $npfile))
                {
                @text = <NP>;
                $text[0] =~ s/<br>//g;
                @matches = $text[0] =~ m/<td>(.+?)<\/td>/g;
                $msg = $matches[0].' - '.$matches[1].' ['.$matches[2].']';
                close(NP);
        } else {
                print("Could not open ".$npfile);
        }

        if($server && $server->{connected} && $dest && ($dest->{type} eq "CHANNEL" || $dest->{type} eq "QUERY")) {
                if($args eq "") {
                        $dest->command("/SAY ".$msg);
                } else {
                        $dest->command("/MSG ".$args." ".$msg);
                }
        }
}
