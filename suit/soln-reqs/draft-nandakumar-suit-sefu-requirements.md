%%%
    title = "Solution Requirements - Secure Firmware Upgrade (SEFU)"
    abbrev = "SEFU"
    category = "std"
    docName = "draft-nandakumar-suit-sefu-requirements"
    ipr = "trust200902"

    [pi]
    symrefs = "yes"
    sortrefs = "yes"
    toc = "yes"

    [[author]]
    initials = "S."
    surname = "Nandakumar"
    fullname = "Suhas Nandakumar"
    organization = "Cisco"
      [author.address]
      email = "snandaku@cisco.com"
    
    [[author]]
    initials = "C."
    surname = "Jennings"
    fullname = "Cullen Jennings"
    organization = "Cisco"
      [author.address]
      email = "fluffy@iii.ca"

    [[author]]
    initials = "S."
    surname = "Cooley"
    fullname = "Shaun Cooley"
    organization = "Cisco"
      [author.address]
      email = "scooley@cisco.com"


%%%

.# Abstract

The IETF SUIT effort has been forming to define a secure firmware 
upgrade solution for Internet of Things (IOT). Recent vulnerabilities
and the need to upgrade firmware on the IoT devices for security updates in
a standardized, secure, and automated fashion has been the driving 
force behind this work. 

This specification is a requirements document to aid in developing 
a solution for Secure Firmware upgrade of the IoT devices.

{mainmatter}

# Introduction

This draft outlines a set of requirements around firmware download for
IoT devices. A sketch of a proposed solution can be found in <TODO
add ref>. 


# Solution Requirements

Informally, a secure firmware upgrade solution might need to address
following components:

* Secure firmware description container format, in the form of Manifest

* Locating a server to download the firmware from

* Downloading the manifest and the firmware image(s)

* Cryptographic validation of the manifest and signed code images

* Complete the installation

Given above tasks, this specification breaks down the secure firmware
upgrade solution into following requirements:

1. Solution must allow devices that delete the old firmware before installing
the new firmware. Thus implying a solution that can easily be implementable
on a minimal boot-loader

1. Solution must enable devices that have enough memory to have the new firmware 
image of the firmware simultaneously loaded with the existing image.

1. The manifest format should be self describing.

1. Allow a given device to decide which manifest format is appropriate
for it choosing from JSON, CBOR, or perhaps ASN.1 if there is a a
device vendor that plans to use this

1. Manifest must allow metadata about the firmware sourced by a single
manufacturer

1. Optionally, the solution may allow the manifest to describe metadata
about firmwares from different providers

1. The solution should enable firmware that is delivered as a single image

1. Optionally, the solution may enable firmware to be split into multiple images.

1. The charter should recommend a solution agnostic to the format of the firmware image and inter dependencies. Dependency management is complicated and is by nature proprietary and should not be in the initial scope.

1. The proposed solution must provide mechanism to discover where to download the 
firmware where that mechanism includes the ability for a local cache.

1. The proposed solution should allow flexibility to choose the underlying transport 
protocol as defined by the deployment scenarios. The WG should define a MTI set of protocols that firmware serves need to implement and clients can choose which one to use
 
1. The proposed solution must require a device to validate signatures on the manifest
and firmware image(s)

1. Optionally, the solution might want to support encrypted manifest and firmware

1. The proposed solution should enable crypto agility and prevent roll-back attacks.

1. Solution should allow for secure transition between the generations of the keying material

1. Charter should not invent new crypto or transports and use existing techniques



# IANA Consideration 

Not Applicable 


# Security Considerations 

Not Applicable

# Acknowledgements 

Thanks IOTSU workshop.

