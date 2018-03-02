source = 'draft-ietf-rtcweb-sdp-09.xml';

my $IP = '((IP4 \d{1,3}(\.\d{1,3}){3})|(IP6 [0-9a-fA-F:]{4,}))';
my $RAW_IP = '((\d{1,3}(\.\d{1,3}){3})|([0-9a-fA-F:]{4,}))';
my $TOKEN = "[\\\x21\\\x23-\\\x27\\\x2A-\\\x2B\\\x2D-\\\x2E\x30-\x39\x41-\x5A\\\x5E-\\\x7E]+";
my $ICE_CHAR = '[a-zA-Z0-9\+\/]';
my $CONTENT = '(slides|speaker|sl|main|alt)';
my $RID_ID = '[a-zA-Z0-9\_\-]+';
my $RID_PARAM = '((max-width=\d+)|'.
                 '(max-height=\d+)|'.
                 '(max-fps=\d+)|'.
                 '(max-fs=\d+)|'.
                 '(max-br=\d+)|'.
                 '(max-pps=\d+)|'.
                 '(max-bpp=\d+\.\d+)|'.
                 '(depend='.$RID_ID.'(,'.$RID_ID.')*)'.
                ')';


my $SC_ID = '\~?'.$RID_ID;
my $SC_ALT_LIST = $SC_ID.'(,'.$SC_ID.')*';
my $SC_STR_LIST = $SC_ALT_LIST.'(;'.$SC_ALT_LIST.')*';
my $SC_SEND = 'send '.$SC_STR_LIST;
my $SC_RECV = 'recv '.$SC_STR_LIST;
my $SC_VALUE = '('.$SC_SEND.'( '.$SC_RECV.')?|'.$SC_RECV.'( '.$SC_SEND.')?)';

my $DEPEND_TAG = '(lay|mdc)( '.$TOKEN.':\d{1,3}(,\d{1,3})*)*';
my $DEPEND = '\d{1,3} '.$DEPEND_TAG.'(; \d{1-3} '.$DEPEND_TAG.')*';

my $errcount = 0;

my %valid = (
  'v' => '0',
  'o' => '\W+ \d+ \d+ IN '.$IP,
  's' => '.*',
  't' => '\d+ \d+',
  'm' => '(((audio|video) \d+ UDP/TLS/RTP/SAVPF( \d+)+)|(application \d+ UDP/DTLS/SCTP webrtc-datachannel))',
  'c' => 'IN '.$IP,
);

my %attr = (
  'bundle-only' => '',
  'candidate' => $ICE_CHAR.'+ \d{1,5} UDP \d{1,10} '.$RAW_IP.
                 ' \d{1,5} typ (host|srflx|prflx|relay|token)( raddr '.$RAW_IP.')?( rport \d{1,5})?',
  'content' => $CONTENT.'(,'.$CONTENT.')*',
  'depend' => $DEPEND,
  'end-of-candidates' => '',
  'extmap' => '\d{1,5}(/(sendonly|recvonly|rendrecv|inactive))? [a-z0-9-:]+( \W+)*',
  'fingerprint' => '(sha-1|sha-224|sha-256|sha-384|sha-512|md5|md2) [0-9A-F]{2}(:[0-9A-F]{2})*',
  'fmtp' => '\d{0,3} .*',
  'group' => '(LS|FID|GROUP|BUNDLE)( '.$TOKEN.')*',
  'ice-options' => 'trickle',
  'ice-pwd' => $ICE_CHAR.'{22,256}',
  'ice-ufrag' => $ICE_CHAR.'{4,256}',
  'identity' => '[a-zA-Z\d\+\/\=]+',
  'inactive' => '',
  'max-message-size' => '[1-9]\d*',
  'maxptime' => '\d+',
  'mid' => $TOKEN,
  'msid' => $TOKEN.'( '.$TOKEN.')?',
  'ptime' => '\d+',
  'recvonly' => '',
  'rid' => $RID_ID.' (send|recv)( (pt=\d+(,\d+)*(;'.$RID_PARAM.')*)|'.
'('.$RID_PARAM.'(;'.$RID_PARAM.')*))',
  'rtcp' => '\d{1,5}( IN '.$IP.')?',
  'rtcp-fb' => '(\*|\d{1,3}) ((ack( rpsi| app|))|'.
                             '(nack( pli| sli | rpsi| app|))|'.
                             '(ccm (fir|tmmbr|tstr|(vbcm \d{1,8})))|'.
                             '(trr-int \d+))',
  'rtcp-mux' => '',
  'rtcp-mux-only' => '',
  'rtcp-rsize' => '',
  'rtpmap' => '\d{1,3} '.$TOKEN.'\/\d{1,6}(\/.*)?',
  'sctp-port' => '\d{1,5}',
  'sendonly' => '',
  'sendrecv' => '',
  'setup' => '(active|passive|actpass)',
  'simulcast' => $SC_VALUE,
  'tls-id' => '[a-zA-Z0-9\+\/\-\_]{20,255}',
);

open(S, $source) || die $!;
$xml = join ('',<S>);
close (S);
$xml =~ s/<!--.*?-->//gos;

while ($xml =~ /<texttable anchor="[^"]*" title="([^"]*)">(.*?)<\/texttable>/gos) {
  my $title = $1;
  my $body = $2;
  my $column = 0;
  my $sdp = '';
  while ($body =~ /<c>(.*?)<\/c>/gos) {
    if ($column == 0){
      $line = $1;
      $line =~ s/[ \t]*[\r\n]+[ \t]*/ /gos;
      if ($line !~ /\*\*/) {
        $sdp .= "$line\n";
      }
    }
    $column = 1 - $column;
  }
  &process($title, $sdp);
}

sub process {
  my ($title, $sdp) = @_;
  my @session = ('v','o','s','i','u','e','p','c','b','t','r','z','k','a');
  my @media = ('m','i','c','b','k','a');
  my @allowed = @session;
  my $index = 0;
  my $orderWarning = 0;

  print "\n".('='x78)."\n".$title."\n".('='x78)."\n";

  while ($sdp =~ /(.)=(.*?)\n/gos) {
    my $type = $1;
    my $value = $2;
    $value =~ s/ *$//;
    print "$type=$value\n";
    if ($type eq 'm') {
      $index = 0;
      @allowed = @media;
      $orderWarning = 0;
    }
    while ($type ne $allowed[$index] && $index < @allowed) {
      $index++;
    }
    if ($index == @allowed && !$orderWarning) {
      print "*** ERROR: '$type' is not valid here; allowed order is: ". join(', ',@allowed)."\n";
      $errcount++;
      $orderWarning = 1;
    }
    &validateLine($type, $value);
  }
}

sub validateLine {
  my ($type, $value) = @_;
  if ($type eq 'a') {
    $value =~ /([^:]*):?(.*)/;
    my $attr = $1;
    my $attrvalue = $2;
    &check($attr{$1}, $2, $1);
  } else {
    &check($valid{$type}, $value, $type);
  }
}

sub check {
  my ($re, $value, $name) = @_;
  if (defined($re)) {
    if ($value !~ /^$re$/) {
      print "\n*** ERROR: invalid syntax for '$name'\n";
      $errcount++;

      if ($value =~ /  /) {
        $value =~ s/ +/ /g;
        if ($value =~ /^$re$/) { print "*** Note[1]: Removing errant spaces fixes this problem.\n\n";  return }
      }

      $value =~ s/ufrag://;
      if ($value =~ /^$re$/) { print "*** Note[2]: Removing errant 'ufrag:' fixes this.\n\n";  return }

      $value =~ s|RTP/S?AVP|UDP/TLS/RTP/SAVPF|;
      if ($value =~ /^$re$/) { print "*** Note[3]: Using the correct transport value fixes this.\n\n";  return }

      $value =~ s/;$//;
      if ($value =~ /^$re$/) { print "*** Note[4]: Removing trailing semicolon fixes this.\n\n";  return }

      $value =~ s/.*a=.*?://g;
      if ($value =~ /^$re$/) { print "*** Note[5]: Removing duplicate 'a=' fixes this.\n\n";  return }

      $value =~ s/0 2 /0 2 UDP /g;
      if ($value =~ /^$re$/) { print "*** Note[6]: Adding 'UDP' fixes this problem.\n\n";  return }

      $value =~ s/ *: */:/g;
      if ($value =~ /^$re$/) { print "*** Note[7]: Removing errant spaces fixes this problem.\n\n";  return }

      $value =~ s/ //g;
      if ($value =~ /^$re$/) { print "*** Note[8]: Removing errant spaces fixes this problem.\n\n";  return }

      $value =~ s/$/00000000000000000000/g;
      if ($value =~ /^$re$/) { print "*** Note[9]: tls-id must be 20 chars or longer.\n\n";  return }

      die;

      print "\n";

    }
  } else {
    print "*** Warning Not checking syntax of '$name'\n";
  }
}

print "\n\nFound $errcount errors\n";
