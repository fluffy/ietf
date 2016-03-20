%%%
    # Generation tool chain:
    #   mmark (https://github.com/miekg/mmark)
    #   xml2rfc (http://xml2rfc.ietf.org/)
    #
    Title = "WebRTC Dependencies"
    abbrev = "WebRTC Dependencies"
    category = "std"
    docName = "draft-jennings-rtcweb-deps-09"
    ipr= "trust200902"
    area = "art"
    
    [pi]
    subcompact = "yes"
	toc=  "no"
    sortrefs = "yes"
    symrefs = "yes"

    [[author]]
    initials = "C."
    surname = "Jennings"
    fullname = "Cullen Jennings"
    organization = "Cisco "
      [author.address]
      email = "fluffy@iii.ca"
      
%%%

.#  abstract

This draft will never be published as an RFC and is meant purely to help track the
IETF dependencies from the W3C WebRTC documents.

{mainmatter}

Dependencies
============

The key IETF drafts that the W3C GetUserMedia specification normatively depends on is:
[@!I-D.ietf-rtcweb-security-arch].

The key IETF specifications that the W3C WebRTC specification normatively
depended on are:
[@!I-D.ietf-rtcweb-alpn],
[@!I-D.ietf-rtcweb-audio],
[@!I-D.ietf-rtcweb-data-channel],
[@!I-D.ietf-rtcweb-data-protocol],
[@!I-D.ietf-rtcweb-jsep],
[@!I-D.ietf-rtcweb-rtp-usage],
[@!I-D.ietf-rtcweb-security-arch],
[@!I-D.ietf-rtcweb-transports],
[@!I-D.ietf-rtcweb-video],
[@!I-D.ietf-tram-turn-third-party-authz],
[@!I-D.ietf-tsvwg-rtcweb-qos]
and informatively depends on 
[@I-D.ietf-rtcweb-overview], 
[@I-D.ietf-rtcweb-security],
[@I-D.shieh-rtcweb-ip-handling],
and 
[@I-D.ietf-mmusic-trickle-ice].

In addition 3GPP work normatively depends on [@I-D.ietf-rtcweb-gateways].


Right now security normatively depends on
[@!I-D.ietf-rtcweb-overview ].

The drafts webrtc currently normatively depends on that are not WG drafts are:
[@!I-D.shieh-rtcweb-ip-handling] has been adoped by WG but not
published yet. 

A few key drafts that the work informatively depends on:
[@I-D.ietf-rtcweb-gateways], 
[@I-D.hutton-rtcweb-nat-firewall-considerations], 
[@I-D.ietf-avtcore-multiplex-guidelines], 
[@I-D.ietf-avtcore-rtp-topologies-update], 
[@I-D.ietf-avtcore-srtp-ekt], 
[@I-D.ietf-avtext-rtp-grouping-taxonomy], 
[@I-D.ietf-dart-dscp-rtp], 
[@I-D.ietf-mmusic-trickle-ice], 
[@I-D.ietf-rmcat-cc-requirements], 
[@I-D.ietf-rtcweb-use-cases-and-requirements], 
[@I-D.kaufman-rtcweb-security-ui], 
[@I-D.lennox-payload-ulp-ssrc-mux], 
[@I-D.ietf-rtcweb-sdp], 
[@I-D.roach-mmusic-unified-plan], 
[@I-D.ietf-rtcweb-audio-codecs-for-interop].

Dependency Details
-----

draft-ietf-avtcore-multi-media-rtp-session normatively depends on
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
 
draft-ietf-avtcore-rtp-multi-stream normatively depends on
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-avtcore-rtp-multi-stream-optimisation normatively depends on
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-mmusic-msid normatively depends on
[@!I-D.ietf-mmusic-rfc4566bis]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
[@!I-D.ietf-rtcweb-jsep]
 
draft-ietf-mmusic-mux-exclusive normatively depends on
[@!I-D.ietf-ice-rfc5245bis]
 
draft-ietf-mmusic-sctp-sdp normatively depends on
[@!I-D.ietf-mmusic-sdp-mux-attributes]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-mmusic-sdp-bundle-negotiation normatively depends on
[@!I-D.ietf-ice-rfc5245bis]
[@!I-D.ietf-mmusic-ice-sip-sdp]
[@!I-D.ietf-mmusic-mux-exclusive]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-mmusic-sdp-mux-attributes normatively depends on
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
 
draft-ietf-rtcweb-alpn normatively depends on
[@!I-D.ietf-rtcweb-data-channel]
 
draft-ietf-rtcweb-audio normatively depends on
[@!I-D.ietf-rtcweb-audio]
 
draft-ietf-rtcweb-data-channel normatively depends on
[@!I-D.ietf-mmusic-sctp-sdp]
[@!I-D.ietf-rtcweb-data-protocol]
[@!I-D.ietf-rtcweb-jsep]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
[@!I-D.ietf-tsvwg-sctp-ndata]
 
draft-ietf-rtcweb-data-protocol normatively depends on
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-rtcweb-fec normatively depends on
[@!I-D.ietf-payload-flexible-fec-scheme]
 
draft-ietf-rtcweb-jsep normatively depends on
[@!I-D.ietf-ice-trickle]
[@!I-D.ietf-mmusic-msid]
[@!I-D.ietf-mmusic-proto-iana-registration]
[@!I-D.ietf-mmusic-sctp-sdp]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
[@!I-D.ietf-rtcweb-audio]
[@!I-D.ietf-rtcweb-fec]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-rtcweb-video]
 
draft-ietf-rtcweb-overview normatively depends on
[@!I-D.ietf-rtcweb-audio]
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-data-protocol]
[@!I-D.ietf-rtcweb-jsep]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-rtcweb-transports]
[@!I-D.ietf-rtcweb-video]
 
draft-ietf-rtcweb-rtp-usage normatively depends on
[@!I-D.ietf-avtcore-multi-media-rtp-session]
[@!I-D.ietf-avtcore-rtp-circuit-breakers]
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-avtcore-rtp-multi-stream-optimisation]
[@!I-D.ietf-mmusic-mux-exclusive]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
[@!I-D.ietf-rtcweb-audio]
[@!I-D.ietf-rtcweb-fec]
[@!I-D.ietf-rtcweb-overview]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-rtcweb-video]
 
draft-ietf-rtcweb-security normatively depends on
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-rtcweb-security-arch normatively depends on
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-rtcweb-transports normatively depends on
[@!I-D.ietf-ice-dualstack-fairness]
[@!I-D.ietf-mmusic-sctp-sdp]
[@!I-D.ietf-rtcweb-alpn]
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-data-protocol]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-tsvwg-rtcweb-qos]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
[@!I-D.ietf-tsvwg-sctp-ndata]
 
draft-ietf-rtcweb-video normatively depends on
[@!I-D.ietf-payload-vp8]
[@!I-D.ietf-rtcweb-overview]
 
draft-ietf-tsvwg-rtcweb-qos normatively depends on
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-transports]
 

Status
----

Status of key drafts as of Feb 25, 2016.

draft-ietf-avtcore-srtp-encrypted-header-ext   is RFC6904

draft-ietf-avtcore-avp-codecs   is RFC7007

draft-ietf-avtcore-6222bis   is RFC7022

draft-nandakumar-rtcweb-stun-uri   is RFC7064

draft-petithuguenin-behave-turn-uris   is RFC7065

draft-ietf-avtext-multiple-clock-rates   is RFC7160

draft-ietf-tls-applayerprotoneg   is RFC7301

draft-ietf-tram-stun-dtls   is RFC7350

draft-ietf-tram-alpn   is RFC7443

draft-ietf-tsvwg-sctp-prpolicies   is RFC7496

draft-ietf-jose-json-web-algorithms  is RFC7518

draft-ietf-payload-rtp-opus   is RFC7587

draft-ietf-tram-turn-third-party-authz  is RFC7635

draft-ietf-httpbis-tunnel-protocol  is RFC7639

draft-ietf-rtcweb-stun-consent-freshness   is RFC7675

draft-ietf-payload-vp8   Auth 48

draft-ietf-rtcweb-video   Auth 48

draft-ietf-rtcweb-rtp-usage   Miss Ref

draft-ietf-tsvwg-sctp-dtls-encaps   Miss Ref

draft-ietf-rtcweb-data-channel   RFC Ed

draft-ietf-rtcweb-data-protocol   RFC Ed

draft-ietf-avtcore-multi-media-rtp-session   RFC Ed

draft-ietf-avtcore-rtp-multi-stream-optimisation   RFC Ed

draft-ietf-avtcore-rtp-multi-stream   RFC Ed

draft-ietf-rtcweb-audio   IETF LC

draft-ietf-avtcore-rtp-circuit-breakers   IETF LC

draft-ietf-mmusic-proto-iana-registration  IETF LC

draft-ietf-mmusic-sdp-mux-attributes   AD Eval

draft-ietf-rtcweb-security-arch   PubReq

draft-ietf-rtcweb-security   PubReq

draft-ietf-mmusic-sdp-bundle-negotiation   Write Up

draft-ietf-rtcweb-alpn    Write Up

draft-ietf-mmusic-msid  Write Up 
 
draft-ietf-rtcweb-overview   WGLC

draft-ietf-tsvwg-rtcweb-qos   WGLC

draft-ietf-tsvwg-sctp-ndata

draft-ietf-rtcweb-transports

draft-ietf-mmusic-sctp-sdp

draft-ietf-rtcweb-jsep

draft-ietf-rtcweb-fec

draft-ietf-payload-flexible-fec-scheme

draft-ietf-ice-trickle-ice

draft-ietf-ice-dualstack-fairness

draft-shieh-rtcweb-ip-handling (this has been adopted as WG draft)

draft-ietf-avtcore-rtp-topologies-update

draft-ietf-ice-rfc5245bis

draft-ietf-mmusic-ice-sip-sdp

draft-ietf-mmusic-mux-exclusive



{backmatter}
