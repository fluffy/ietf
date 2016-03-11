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

The key IETF specifications that the W3C GetUserMedia specification normatively depends on is:
[@!I-D.ietf-rtcweb-security-arch] and 
[@!RFC2119].

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
[@!I-D.ietf-tsvwg-rtcweb-qos],
[@!RFC2119],
[@!RFC4566],
[@!RFC5389],
[@!RFC5888],
[@!RFC6236],
[@!RFC6464],
[@!RFC6465],
[@!RFC6544],
[@!RFC7064],
[@!RFC7065]
[@!RFC3264],
[@!RFC5245], 
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
[@I-D.alvestrand-rtcweb-gateways], 
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
[@I-D.ietf-rtcweb-audio-codecs-for-interop],
[@I-D.westerlund-avtcore-multiplex-architecture].

Details
-----


draft-ietf-avtcore-6222bis normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC4086]
[@!RFC4122]
[@!RFC4648]
[@!RFC5342]
 
draft-ietf-avtcore-avp-codecs normatively depends on
[@!RFC2119]
[@!RFC3551]
 
draft-ietf-avtcore-multi-media-rtp-session normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC3551]
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
 
draft-ietf-avtcore-rtp-circuit-breakers normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC3551]
[@!RFC3611]
[@!RFC4585]
[@!RFC5348]
 
draft-ietf-avtcore-rtp-multi-stream normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC3550]
[@!RFC4566]
[@!RFC7022]
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-avtcore-rtp-multi-stream-optimisation normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC3550]
[@!RFC4566]
[@!RFC7022]
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-avtcore-rtp-topologies-update normatively depends on
[@!RFC3550]
[@!RFC4585]
 
draft-ietf-avtcore-srtp-encrypted-header-ext normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC3711]
[@!RFC5234]
[@!RFC5285]
[@!RFC5669]
[@!RFC6188]
 
draft-ietf-avtext-multiple-clock-rates normatively depends on
[@!RFC2119]
[@!RFC3550]
 
draft-ietf-httpbis-tunnel-protocol normatively depends on
[@!RFC2119]
[@!RFC3864]
[@!RFC3986]
[@!RFC7230]
[@!RFC7231]
[@!RFC7301]
 
draft-ietf-ice-dualstack-fairness normatively depends on
[@!RFC2119]
[@!RFC3484]
[@!RFC5245]
[@!RFC6555]
[@!RFC6724]
[@!RFC6982]
 
draft-ietf-ice-rfc5245bis normatively depends on
[@!RFC2119]
[@!RFC5389]
[@!RFC5766]
[@!RFC6724]
 
draft-ietf-jose-json-web-algorithms normatively depends on
[@!RFC2104]
[@!RFC2119]
[@!RFC2898]
[@!RFC3394]
[@!RFC3447]
[@!RFC3629]
[@!RFC4868]
[@!RFC4949]
[@!RFC5652]
[@!RFC6090]
[@!RFC7159]
 
draft-ietf-mmusic-ice-sip-sdp normatively depends on
[@!RFC2119]
[@!RFC3261]
[@!RFC3262]
[@!RFC3264]
[@!RFC3312]
[@!RFC3550]
[@!RFC3556]
[@!RFC3605]
[@!RFC4032]
[@!RFC4091]
[@!RFC4092]
[@!RFC4566]
[@!RFC5226]
[@!RFC5234]
[@!RFC5389]
[@!RFC5768]
[@!RFC6679]
[@!RFC7092]
 
draft-ietf-mmusic-msid normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC4566]
[@!RFC5234]
[@!I-D.ietf-rtcweb-jsep]
 
draft-ietf-mmusic-mux-exclusive normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC4566]
[@!RFC5761]
[@!I-D.ietf-ice-rfc5245bis]
 
draft-ietf-mmusic-proto-iana-registration normatively depends on
[@!RFC2119]
[@!RFC4566]
[@!RFC4571]
[@!RFC4572]
[@!RFC5245]
[@!RFC5764]
[@!RFC6544]
 
draft-ietf-mmusic-sctp-sdp normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC4145]
[@!RFC4289]
[@!RFC4566]
[@!RFC4571]
[@!RFC4572]
[@!RFC4960]
[@!RFC5061]
[@!RFC5226]
[@!RFC5234]
[@!RFC6347]
[@!RFC6838]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-mmusic-sdp-bundle-negotiation normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC3550]
[@!RFC3605]
[@!RFC4566]
[@!RFC4961]
[@!RFC5245]
[@!RFC5285]
[@!RFC5761]
[@!RFC5764]
[@!RFC5888]
[@!RFC6347]
[@!I-D.ietf-ice-rfc5245bis]
[@!I-D.ietf-mmusic-ice-sip-sdp]
[@!I-D.ietf-mmusic-mux-exclusive]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
 
draft-ietf-mmusic-sdp-mux-attributes normatively depends on
[@!RFC2119]
[@!RFC4566]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
 
draft-ietf-mmusic-trickle-ice normatively depends on
[@!RFC2119]
[@!RFC3261]
[@!RFC3262]
[@!RFC3264]
[@!RFC4566]
[@!RFC5234]
[@!RFC5245]
[@!RFC5761]
[@!RFC5888]
[@!RFC6086]
[@!RFC7405]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
[@!I-D.ietf-mmusic-trickle-ice]
 
draft-ietf-payload-flexible-fec-scheme normatively depends on
[@!RFC2119]
[@!RFC3264]
[@!RFC3550]
[@!RFC3555]
[@!RFC4566]
[@!RFC5956]
[@!RFC6363]
[@!RFC6838]
[@!RFC7022]
 
draft-ietf-payload-rtp-opus normatively depends on
[@!RFC2119]
[@!RFC2326]
[@!RFC3264]
[@!RFC3389]
[@!RFC3550]
[@!RFC3551]
[@!RFC3711]
[@!RFC4566]
[@!RFC4855]
[@!RFC5576]
[@!RFC6562]
[@!RFC6716]
[@!RFC6838]
 
draft-ietf-payload-vp8 normatively depends on
[@!RFC2119]
[@!RFC3550]
[@!RFC3551]
[@!RFC4566]
[@!RFC4585]
[@!RFC4855]
[@!RFC6386]
[@!RFC6838]
 
draft-ietf-rtcweb-alpn normatively depends on
[@!RFC2119]
[@!RFC5764]
[@!RFC6347]
[@!RFC7301]
[@!I-D.ietf-rtcweb-data-channel]
 
draft-ietf-rtcweb-audio normatively depends on
[@!RFC3551]
[@!RFC4867]
[@!I-D.ietf-rtcweb-audio]
 
draft-ietf-rtcweb-data-channel normatively depends on
[@!RFC2119]
[@!RFC3758]
[@!RFC4347]
[@!RFC4820]
[@!RFC4821]
[@!RFC4960]
[@!RFC5061]
[@!RFC5245]
[@!RFC6347]
[@!RFC6525]
[@!I-D.ietf-mmusic-sctp-sdp]
[@!I-D.ietf-rtcweb-data-protocol]
[@!I-D.ietf-rtcweb-jsep]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
[@!I-D.ietf-tsvwg-sctp-ndata]
[@!I-D.ietf-tsvwg-sctp-prpolicies]
 
draft-ietf-rtcweb-data-protocol normatively depends on
[@!RFC2119]
[@!RFC3629]
[@!RFC4347]
[@!RFC4960]
[@!RFC5226]
[@!RFC6347]
[@!RFC6455]
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
 
draft-ietf-rtcweb-fec normatively depends on
[@!RFC2119]
[@!RFC2198]
[@!RFC5956]
[@!I-D.ietf-payload-flexible-fec-scheme]
 
draft-ietf-rtcweb-jsep normatively depends on
[@!RFC2119]
[@!RFC3261]
[@!RFC3264]
[@!RFC3552]
[@!RFC3605]
[@!RFC4145]
[@!RFC4566]
[@!RFC4572]
[@!RFC4585]
[@!RFC5124]
[@!RFC5245]
[@!RFC5285]
[@!RFC5761]
[@!RFC5888]
[@!RFC6236]
[@!RFC6347]
[@!RFC6904]
[@!RFC7022]
[@!I-D.ietf-mmusic-msid]
[@!I-D.ietf-mmusic-sctp-sdp]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
[@!I-D.ietf-mmusic-sdp-mux-attributes]
[@!I-D.ietf-mmusic-trickle-ice]
[@!I-D.ietf-rtcweb-audio]
[@!I-D.ietf-rtcweb-data-protocol]
[@!I-D.ietf-rtcweb-fec]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-rtcweb-video]
[@!I-D.nandakumar-mmusic-proto-iana-registration]
 
draft-ietf-rtcweb-overview normatively depends on
[@!RFC3264]
[@!RFC3550]
[@!RFC3711]
[@!RFC5245]
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
[@!RFC2119]
[@!RFC2736]
[@!RFC3550]
[@!RFC3551]
[@!RFC3556]
[@!RFC3711]
[@!RFC4566]
[@!RFC4585]
[@!RFC4588]
[@!RFC4961]
[@!RFC5104]
[@!RFC5124]
[@!RFC5285]
[@!RFC5506]
[@!RFC5761]
[@!RFC5764]
[@!RFC6051]
[@!RFC6464]
[@!RFC6465]
[@!RFC6562]
[@!RFC6904]
[@!RFC7007]
[@!RFC7022]
[@!RFC7160]
[@!RFC7164]
[@!I-D.ietf-avtcore-multi-media-rtp-session]
[@!I-D.ietf-avtcore-rtp-circuit-breakers]
[@!I-D.ietf-avtcore-rtp-multi-stream]
[@!I-D.ietf-avtcore-rtp-multi-stream-optimisation]
[@!I-D.ietf-avtcore-rtp-topologies-update]
[@!I-D.ietf-mmusic-sdp-bundle-negotiation]
[@!I-D.ietf-rtcweb-audio]
[@!I-D.ietf-rtcweb-fec]
[@!I-D.ietf-rtcweb-overview]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-security-arch]
[@!I-D.ietf-rtcweb-video]
 
draft-ietf-rtcweb-security normatively depends on
[@!RFC2119]
[@!RFC2818]
[@!RFC3711]
[@!RFC4347]
[@!RFC4566]
[@!RFC4572]
[@!RFC4627]
[@!RFC4648]
[@!RFC5234]
[@!RFC5245]
[@!RFC5246]
[@!RFC5763]
[@!RFC5764]
[@!RFC5785]
[@!RFC5890]
[@!RFC6454]
[@!I-D.ietf-avtcore-6222bis]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
[@!I-D.muthu-behave-consent-freshness]
 
draft-ietf-rtcweb-security-arch normatively depends on
[@!RFC2119]
[@!RFC2818]
[@!RFC3711]
[@!RFC4347]
[@!RFC4566]
[@!RFC4572]
[@!RFC4627]
[@!RFC4648]
[@!RFC5234]
[@!RFC5245]
[@!RFC5246]
[@!RFC5763]
[@!RFC5764]
[@!RFC5785]
[@!RFC5890]
[@!RFC6454]
[@!I-D.ietf-avtcore-6222bis]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-tsvwg-sctp-dtls-encaps]
[@!I-D.muthu-behave-consent-freshness]
 
draft-ietf-rtcweb-stun-consent-freshness normatively depends on
[@!RFC2119]
[@!RFC5245]
[@!RFC5389]
 
draft-ietf-rtcweb-transports normatively depends on
[@!RFC0768]
[@!RFC0793]
[@!RFC2119]
[@!RFC4571]
[@!RFC4941]
[@!RFC5245]
[@!RFC5389]
[@!RFC5764]
[@!RFC5766]
[@!RFC6062]
[@!RFC6156]
[@!RFC6544]
[@!RFC6724]
[@!RFC7231]
[@!RFC7235]
[@!RFC7639]
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
[@!I-D.martinsen-mmusic-ice-dualstack-fairness]
 
draft-ietf-rtcweb-video normatively depends on
[@!RFC2119]
[@!RFC6184]
[@!RFC6236]
[@!RFC6386]
[@!I-D.ietf-payload-vp8]
[@!I-D.ietf-rtcweb-overview]
 
draft-ietf-tls-applayerprotoneg normatively depends on
[@!RFC2119]
[@!RFC2616]
[@!RFC3629]
[@!RFC5226]
[@!RFC5246]
 
draft-ietf-tram-alpn normatively depends on
[@!RFC5246]
[@!RFC5389]
[@!RFC6347]
[@!RFC7301]
[@!RFC7350]
 
draft-ietf-tram-stun-dtls normatively depends on
[@!RFC2119]
[@!RFC3489]
[@!RFC3958]
[@!RFC5245]
[@!RFC5246]
[@!RFC5389]
[@!RFC5626]
[@!RFC5764]
[@!RFC5766]
[@!RFC5928]
[@!RFC6062]
[@!RFC6335]
[@!RFC6347]
[@!RFC7064]
[@!RFC7065]
 
draft-ietf-tram-turn-third-party-authz normatively depends on
[@!RFC2119]
[@!RFC4648]
[@!RFC4868]
[@!RFC5116]
[@!RFC5389]
[@!RFC6749]
[@!I-D.ietf-jose-json-web-algorithms]
 
draft-ietf-tsvwg-rtcweb-qos normatively depends on
[@!RFC2119]
[@!RFC4594]
[@!RFC7657]
[@!I-D.ietf-rtcweb-data-channel]
[@!I-D.ietf-rtcweb-rtp-usage]
[@!I-D.ietf-rtcweb-security]
[@!I-D.ietf-rtcweb-transports]
 
draft-ietf-tsvwg-sctp-dtls-encaps normatively depends on
[@!RFC1122]
[@!RFC2119]
[@!RFC4347]
[@!RFC4820]
[@!RFC4821]
[@!RFC4960]
[@!RFC6347]
[@!RFC6520]
 
draft-ietf-tsvwg-sctp-ndata normatively depends on
[@!RFC1982]
[@!RFC2119]
[@!RFC3758]
[@!RFC4960]
[@!RFC5061]
[@!RFC6096]
[@!RFC6525]
[@!RFC7053]
 
draft-ietf-tsvwg-sctp-prpolicies normatively depends on
[@!RFC2119]
[@!RFC3758]
[@!RFC4960]
 
draft-nandakumar-rtcweb-stun-uri normatively depends on
[@!RFC2119]
[@!RFC3986]
[@!RFC5234]
 
draft-petithuguenin-behave-turn-uris normatively depends on
[@!RFC2119]
[@!RFC3986]
[@!RFC5234]
[@!RFC5766]
[@!RFC5928]
 
draft-shieh-rtcweb-ip-handling normatively depends on
[@!RFC1918]
[@!RFC4941]
 

Time Estimates
-

The following table has some very rough estimates of when the draft will become an
RFC. Historically these dates have often taken much longer than the estimates
so take this with a large dose of salt.

Last updated Feb 25, 2016.


| [@!RFC6904]    | [@!I-D.ietf-avtcore-srtp-encrypted-header-ext]  |
| [@!RFC7007]    | [@!I-D.ietf-avtcore-avp-codecs]  |
| [@!RFC7022]    | [@!I-D.ietf-avtcore-6222bis]  |
| [@!RFC7064]    | [@!I-D.nandakumar-rtcweb-stun-uri]  |
| [@!RFC7065]    | [@!I-D.petithuguenin-behave-turn-uris]  |
| [@!RFC7160]    | [@!I-D.ietf-avtext-multiple-clock-rates]  |
| [@!RFC7301]    | [@!I-D.ietf-tls-applayerprotoneg]  |
| [@!RFC7350]    | [@!I-D.ietf-tram-stun-dtls]  |
| [@!RFC7443]    | [@!I-D.ietf-tram-alpn]  |
| [@!RFC7496]    | [@!I-D.ietf-tsvwg-sctp-prpolicies]  |
| [@!RFC7518]    | [@!I-D.ietf-jose-json-web-algorithms] |
| [@!RFC7587]    | [@!I-D.ietf-payload-rtp-opus]  |
| [@!RFC7635]    | [@!I-D.ietf-tram-turn-third-party-authz] |
| [@!RFC7639]    | [@!I-D.ietf-httpbis-tunnel-protocol] |
| [@!RFC7675]    | [@!I-D.ietf-rtcweb-stun-consent-freshness]  |
| Auth 48         | [@!I-D.ietf-payload-vp8]  |
| Auth 48         | [@!I-D.ietf-rtcweb-video]  |
| Miss Ref        | [@!I-D.ietf-rtcweb-rtp-usage]  |
| Miss Ref        | [@!I-D.ietf-tsvwg-sctp-dtls-encaps]  |
| RFC Ed          | [@!I-D.ietf-rtcweb-data-channel]  |
| RFC Ed          | [@!I-D.ietf-rtcweb-data-protocol]  |
| RFC Ed          | [@!I-D.ietf-avtcore-multi-media-rtp-session]  |
| RFC Ed          | [@!I-D.ietf-avtcore-rtp-multi-stream-optimisation]  |
| RFC Ed          | [@!I-D.ietf-avtcore-rtp-multi-stream]  |
| IETF LC          | [@!I-D.ietf-rtcweb-audio]  |
| IETF LC          | [@!I-D.ietf-avtcore-rtp-circuit-breakers]  |
| IETF LC          | [@!I-D.ietf-mmusic-proto-iana-registration] |
| AD Eval         | [@!I-D.ietf-mmusic-sdp-mux-attributes]  |
| PubReq         | [@!I-D.ietf-rtcweb-security-arch]  |
| PubReq         | [@!I-D.ietf-rtcweb-security]  |
| Write Up        | [@!I-D.ietf-mmusic-sdp-bundle-negotiation]  |
| Write Up      | [@!I-D.ietf-rtcweb-alpn]  |
| WGLC            | [@!I-D.ietf-rtcweb-overview]  |
| WGLC            | [@!I-D.ietf-tsvwg-rtcweb-qos]  |
|                  | [@!I-D.ietf-tsvwg-sctp-ndata]  |
|                  | [@!I-D.ietf-rtcweb-transports]  |
|                 | [@!I-D.ietf-mmusic-msid]  |
|                 | [@!I-D.ietf-mmusic-sctp-sdp]  |
|                 | [@!I-D.ietf-rtcweb-jsep]  |
|                | [@!I-D.ietf-rtcweb-fec] |
|                | [@!I-D.ietf-payload-flexible-fec-scheme] | 
|                | [@!I-D.ietf-mmusic-trickle-ice]  |
|                | [@!I-D.ietf-ice-dualstack-fairness] |
|               | [@!I-D.shieh-rtcweb-ip-handling] |


{backmatter}
