#!/usr/bin/perl

use Term::ANSIColor;

my $file = "$ARGV[0]";
my $data = do { local( @ARGV, $/ ) = $file ; <> } ;


$black 		= "[\x00]";
$red 		= "[\x01]";
$green	 	= "[\x02]";
$yellow 	= "[\x03]";
$blue 		= "[\x04]";
$pink		= "[\x05]";
$cyan	 	= "[\x06]";
$white 		= "[\x07]";
$blink		= "[\x08]";
$double		= "[\x0D]";
$whitebg	= "[\x1D]";
$blackbg	= "[\x0D]";
$redbg 		= "[\x01\x1D]";
$greenbg	= "[\x02\x1D]";
$yellowbg	= "[\x03\x1D]";

@lines = split("", $data);
for ($k =0; $k < 40; $k++) { $header .= $lines[$k]; }
for ($j = 40; $j < 961; $j ++) { $text .= "$lines[$j]";}
for ($l=961;$l<=$#lines;$l++) { $footer .= $lines[$l]; }

@otherLines = split("", $text);
#open (OUT, ">$file.ttv");

$tempcounter=0;
for ($i = 0; $i <= $#otherLines; $i++) {
	$line = $otherLines[$i];
	$newline = &storeColours($line);
	print "\"$newline\"~";
#	print OUT "\"$newline\"~";
	$tempcounter++;
	if ($tempcounter==40) { $tempcounter=0; print OUT "\n"; }
	}

#close OUT;

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
return $internal; }

sub storeColours () {
my $internal = shift(@_);
$internal =~ s/$cyan/'cyan'/g;
$internal =~ s/$white/'white'/g;
$internal =~ s/$pink/'pink'/g;
$internal =~ s/$red/'red'/g;
$internal =~ s/$green/'green'/g;
$internal =~ s/$blue/'blue'/g;
$internal =~ s/$yellow/'yellow'/g;
$internal =~ s/$black/'black'/g;
$internal =~ s/$blink/'blink'/g;
$internal =~ s/$double/'double'/g;
$internal =~ s/$whitebg/'whitebg'/g;
$internal =~ s/$blackbg/'blackbg'/g;
$internal =~ s/$redbg/'redbg'/g;
return $internal; }



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


