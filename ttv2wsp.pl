#!/usr/bin/perl

use Term::ANSIColor;


#if ($ARGV[0] eq "") { die "Bruk filnavn på en TTV-fil for å konvertere. Programmet output'er til STDOUT så du må redirecte det til en fil med > om du vil ta vare på output."; }

$black 		= "\x00";
$red 		= "\x01";
$green	 	= "\x02";
$yellow 	= "\x03";
$blue 		= "\x04";
$pink		= "\x05";
$cyan	 	= "\x06";
$white 		= "\x07";
$blink		= "\x08";
$double		= "\x0D";
$whitebg	= "\x1D";
$blackbg	= "\x0D";
$redbg 		= "\x01\x1D";
$greenbg	= "\x02\x1D";
$yellowbg	= "\x03\x1D";


my $header = do { local (@ARGV, $/ ) = "header.ttv"; <>};
print "$header";

my $ttvData = do { local (@ARGV, $/ ) = "$ARGV[0]"; <>};

#while (<>) {
#$ttvData .= $_; }

$counter=0;
@data = split("~", $ttvData);
for ($x = 0 ; $x <= $#data; $x++) {
	$data[$x] =~ s/\"//g; 
	chomp ($data[$x]); 
	$data[$x] =~ s/\n//g; 
	$data[$x] =~ s/\'//g;
	print &placeColours(&placeNorChars("$data[$x]"));
	$counter++;
	}

$total = (39*23);
while ($counter <= $total) { print " "; $counter++; }
my $footer = do { local (@ARGV, $/ ) = "footer.ttv"; <>};
print "$footer";


sub placeColours () {
	my $internal = shift(@_);
	$internal =~ s/cyan/$cyan/g;
	$internal =~ s/white/$white/g;
	$internal =~ s/pink/$pink/g;
	$internal =~ s/red/$red/g;
	$internal =~ s/green/$green/g;
	$internal =~ s/blue/$blue/g;
	$internal =~ s/yellow/$yellow/g;
	$internal =~ s/black/$black/g;
	$internal =~ s/blink/$blink/g;
	$internal =~ s/double/$double/g;
	$internal =~ s/whitebg/$whitebg/g;
	$internal =~ s/blackbg/$blackbg/g;
	$internal =~ s/redbg/$redbg/g;
	return $internal;
}

sub stripColours () {
my $internal = shift(@_);
$internal =~ s/$cyan/ /g; 
$internal =~ s/$white/ /g;
$internal =~ s/$pink/ /g; 
$internal =~ s/$red/ /g; 
$internal =~ s/$green/ /g; 
$internal =~ s/$blue/ /g; 
$internal =~ s/$yellow/ /g; 
$internal =~ s/$black/ /g;
$internal =~ s/$blink/ /g;
$internal =~ s/$double/ /g; 
$internal =~ s/$whitebg/ /g;
$internal =~ s/$blackbg/ /g;
$internal =~ s/$redbg/ /g;
return $internal;
}

sub printColours () {
my $internal = shift(@_);
if ($internal =~ $whitebg) { print color 'on_white'; print &stripColours("$internal");  }
if ($internal =~ $blackbg) { print color 'reset'; print &stripColours("$internal"); }
#if ($internal =~ $redbg) { print color 'on_red'; print &stripColours("$internal"); }
#if ($internal =~ $greenbg) { print color 'on_green'; print &stripColours("$internal"); print color 'reset'; }
#if ($internal =~ $yellowbg) { print color 'on_yellow'; print &stripColours("$internal"); }

if ($internal =~ $cyan) { print color 'cyan'; print &stripColours("$internal"); }
if ($internal =~ $white) { print color 'white'; print &stripColours("$internal");  }

if ($internal =~ $pink) { print color 'magenta'; print &stripColours("$internal"); }
if ($internal =~ $red) { print color 'red'; print &stripColours("$internal");  }
if ($internal =~ $green) { print color 'green'; print &stripColours("$internal"); }
if ($internal =~ $blue) { print color 'blue'; print &stripColours("$internal");  }

if ($internal =~ $yellow) { print color 'yellow'; print &stripColours("$internal"); }
if ($internal =~ $black) { print color 'black'; print &stripColours("$internal");  }
if ($internal =~ $blink) { print color 'blink'; print &stripColours("$internal"); }
#if ($internal =~ $double) { print color 'double'; print &stripColours("$internal");  }
#if ($internal =~ $whitebg) { print color 'on_white'; print &stripColours("$internal"); }

else { print &stripColours(&stripNorChars("$internal")); }
}

sub stripNorChars () {
my $b = shift(@_);

#$b =~ s/[\x00-\x1F\x7F]//g;
$b =~ s/{/æ/g;
$b =~ s/}/å/g;
$b =~ s/\|/ø/g;
$b =~ s/\\\\/Ø/g;
$b =~ s/]/Å/g;
$b =~ s/\[/Æ/g;
return $b;
}

sub placeNorChars () {
my $b = shift(@_);
#$b =~ s/[\x00-\x1F\x7F]//g;
$b =~ s/æ{/{/g;
$b =~ s/å/}/g;
$b =~ s/ø/\|/g;
$b =~ s/Ø/\\\\/g;
$b =~ s/Å/]/g;
$b =~ s/Æ/\[/g;
return $b;
}



sub htmlNorChars () {
my $b = shift(@_);

#$b =~ s/[\x00-\x1F\x7F]//g;
$b =~ s/{/&aelig;/g;
$b =~ s/}/&aring;/g;
$b =~ s/\|/&oslash;/g;
$b =~ s/\\\\/&Oslash;/g;
$b =~ s/]/&Aring;/g;
$b =~ s/\[/&AElig;/g;
return $b;
}


