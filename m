Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5410A178DAF
	for <lists+cgroups@lfdr.de>; Wed,  4 Mar 2020 10:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbgCDJox (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 4 Mar 2020 04:44:53 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:49122 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728946AbgCDJox (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 4 Mar 2020 04:44:53 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <benjamin@sipsolutions.net>)
        id 1j9QaA-00FLQ5-7t; Wed, 04 Mar 2020 10:44:50 +0100
Message-ID: <d4826b9e568f1ab7df19f94c409df11956a8e262.camel@sipsolutions.net>
Subject: Memory reclaim protection and cgroup nesting (desktop use)
From:   Benjamin Berg <benjamin@sipsolutions.net>
To:     cgroups@vger.kernel.org, linux-mm@kvack.org
Date:   Wed, 04 Mar 2020 10:44:44 +0100
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-X/bjWAe/RYw/yZnfBd4v"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--=-X/bjWAe/RYw/yZnfBd4v
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

TL;DR: I seem to need memory.min/memory.max to be set on each child
cgroup and not just the parents. Is this expected?


I have been experimenting with using cgroups to protect a GNOME
session. The intention is that the GNOME Shell itself and important
other services remain responsive, even if the application workload is
thrashing. The long term goal here is to bridge the time until an OOM
killer like oomd would get the system back into normal conditions using
memory pressure information.

Note that I have done these tests without any swap and with huge
memory.min/memory.low values. I consider this scenario pathological,
however, it seems like a reasonable way to really exercise the cgroup
reclaim protection logic.

The resulting cgroup hierarchy looked something like:

-.slice
=E2=94=9C=E2=94=80user.slice
=E2=94=82 =E2=94=94=E2=94=80user-1000.slice
=E2=94=82   =E2=94=9C=E2=94=80user@1000.service
=E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80session.slice
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80gsd-*.service
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80208803 /usr/lib=
exec/gsd-rfkill
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80gnome-shell-wayland.servi=
ce
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80208493 /usr/bin=
/gnome-shell
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=9C=E2=94=80208549 /usr/bin=
/Xwayland :0 -rootless -noreset -accessx -core -auth /run/user/1000/.mutter=
-Xwayla>
=E2=94=82   =E2=94=82 =E2=94=82 =E2=94=82 =E2=94=94=E2=94=80 =E2=80=A6
=E2=94=82   =E2=94=82 =E2=94=94=E2=94=80apps.slice
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80gnome-launched-tracker-miner-fs.d=
esktop-208880.scope
=E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80208880 /usr/libexec/tra=
cker-miner-fs
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80dbus-:1.2-org.gnome.OnlineAccount=
s@0.service
=E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80208668 /usr/libexec/goa=
-daemon
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80flatpak-org.gnome.Fractal-210350.=
scope
=E2=94=82   =E2=94=82   =E2=94=9C=E2=94=80gnome-terminal-server.service
=E2=94=82   =E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80209261 /usr/libexec/gno=
me-terminal-server
=E2=94=82   =E2=94=82   =E2=94=82 =E2=94=9C=E2=94=80209434 bash
=E2=94=82   =E2=94=82   =E2=94=82 =E2=94=94=E2=94=80 =E2=80=A6 including th=
e test load i.e. "make -j32" of a C++ code


I also enabled the CPU and IO controllers in my tests, but I don't
think that is as relevant. The main thing is that I set
  memory.min: 2GiB
  memory.low: 4GiB

using systemd on all of

 * user.slice,
 * user-1000.slice,
 * user@1000.slice,
 * session.slice and
 * everything inside session.slice
   (i.e. gnome-shell-wayland.service, gsd-*.service, =E2=80=A6)

excluding apps.slice from protection.

(In a realistic scenario I expect to have swap and then reserving maybe
a few hundred MiB; DAMON might help with finding good values.)


At that point, the protection started working pretty much flawlessly.
i.e. my gnome-shell would continue to run without major page faulting
even though everything in apps.slice was thrashing heavily. The
mouse/keyboard remained completely responsive, and interacting with
applications ended up working much better thanks to knowing where input
was going. Even if the applications themselves took seconds to react.

So far, so good. What surprises me is that I needed to set the
protection on the child cgroups (i.e. gnome-shell-wayland.service).
Without this, it would not work (reliably) and my gnome-shell would
still have a lot of re-faults to load libraries and other mmap'ed data
back into memory (I used "perf --no-syscalls -F" to trace this and
observed these to be repeatedly for the same pages loading e.g.
functions for execution).

Due to accounting effects, I would expect re-faults to happen up to one
time in this scenario. At that point the page in question will be
accounted against the shell's cgroup and reclaim protection could kick
in. Unfortunately, that did not seem to happen unless the shell's
cgroup itself had protections and not just all of its parents.

Is it expected that I need to set limits on each child?

Benjamin

--=-X/bjWAe/RYw/yZnfBd4v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEED2NO4vMS33W8E4AFq6ZWhpmFY3AFAl5feI0ACgkQq6ZWhpmF
Y3AWGw/9HeiEx6iQ3yGu+Al2MmjgsXcOk3kpHJshbHFACzCT89QaAaHUMfUen3yV
MUe92csEBuIcRVf0qMFvgMHpcHNT+O8K5aymgw+Hhs74MveMs2qyi1RQ0lw6ooqo
qABY6uLspyZWQxzgIlJmIzZvlKUwS07CR7SulBBYxtRQSrdsHIq9J/R0Wpt9RD7L
QI5cWpPqCm8GlqBbtGyaK78kN00oS1LlivSsdMbPEffDZG4XCsJv2+BQDLgiFfPu
KlropNo+djQVQ/ccLa4ZXxIC0uoxVZbU6hy4D3G6xLckqmRN5xEWQmtjRS/4NMz8
LH9eD1/j2rv4jcoIhndWtqNGy8xSaN72HK9Cor9sujud4qZkUS2oG30m5BQEtSM8
nwJETv4euIP1bVw9URoEtt3Rwli9DuBVoTBUSJGtu8JfopNdezwckfldCGe0Hekg
R99dsqpKf+kThq29tRfRcbCPZU7Lrkn3/lPIBpJEf9VZuL8mx70j+mouSBWSA8R4
HHXxkzDU9YBneROgcFgjAOgrhM54pcfAIRexbmjJX1jiZ2WkurfO6QlaNsT54Vkz
fto8/aE+MIR5qBmAFWRbmypZVOL1Od/j0X7w2CmDavOcDQqdS25BoHSvpTBITjYM
bfLrEnh7CjStdaXNLIBbY3Orbzz5MNkXolqsKtLM2DKE3vqtSVQ=
=YegP
-----END PGP SIGNATURE-----

--=-X/bjWAe/RYw/yZnfBd4v--

