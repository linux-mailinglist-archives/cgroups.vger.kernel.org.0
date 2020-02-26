Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD441704BA
	for <lists+cgroups@lfdr.de>; Wed, 26 Feb 2020 17:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgBZQqj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 26 Feb 2020 11:46:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:58574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726490AbgBZQqj (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 26 Feb 2020 11:46:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C8D04AC46;
        Wed, 26 Feb 2020 16:46:36 +0000 (UTC)
Date:   Wed, 26 Feb 2020 17:46:32 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 2/3] mm: memcontrol: clean up and document effective
 low/min calculations
Message-ID: <20200226164632.GL27066@blackbody.suse.cz>
References: <20191219200718.15696-1-hannes@cmpxchg.org>
 <20191219200718.15696-3-hannes@cmpxchg.org>
 <20200221171024.GA23476@blackbody.suse.cz>
 <20200225184014.GC10257@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fDP66DSfTvWAYVew"
Content-Disposition: inline
In-Reply-To: <20200225184014.GC10257@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--fDP66DSfTvWAYVew
Content-Type: multipart/mixed; boundary="QWRRbczYj8mXuejp"
Content-Disposition: inline


--QWRRbczYj8mXuejp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2020 at 01:40:14PM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> Hm, this example doesn't change with my patch because there is no
> "floating" protection that gets distributed among the siblings.
Maybe it had changed even earlier and the example obsoleted.

> In my testing with the above parameters, the equilibrium still comes
> out to roughly this distribution.
I'm attaching my test (10-times smaller) and I'm getting these results:

> /sys/fs/cgroup/test.slice/memory.current:838750208
> /sys/fs/cgroup/test.slice/pressure.service/memory.current:616972288
> /sys/fs/cgroup/test.slice/test-A.slice/memory.current:221782016
> /sys/fs/cgroup/test.slice/test-A.slice/B.service/memory.current:123428864
> /sys/fs/cgroup/test.slice/test-A.slice/C.service/memory.current:93495296
> /sys/fs/cgroup/test.slice/test-A.slice/D.service/memory.current:4702208
> /sys/fs/cgroup/test.slice/test-A.slice/E.service/memory.current:155648

(I'm running that on 5.6.0-rc2 + first two patches of your series.)

That's IMO closer to the my simulation (1.16:0.84)
than the example prediction (1.3:0.6)

> It's just to illustrate the pressure weight, not to reflect each
> factor that can influence the equilibrium.
But it's good to have some idea about the equilibrium when configuring
the values.=20

> I think it still has value to gain understanding of how it works, no?
Alas, the example confused me so that I had to write the simulation to
get grasp of it :-)

And even when running actual code now, I'd say the values in the
original example are only one of the equlibriums but definitely not
reachable from the stated initial conditions.

> > > @@ -6272,12 +6262,63 @@ struct cgroup_subsys memory_cgrp_subsys =3D {
> > >   * for next usage. This part is intentionally racy, but it's ok,
> > >   * as memory.low is a best-effort mechanism.
> > Although it's a different issue but since this updates the docs I'm
> > mentioning it -- we treat memory.min the same, i.e. it's subject to the
> > same race, however, it's not meant to be best effort. I didn't look into
> > outcomes of potential misaccounting but the comment seems to miss impact
> > on memory.min protection.
>=20
> Yeah I think we can delete that bit.
Erm, which part?
Make the racy behavior undocumented or that it applies both memory.low
and memory.min?

> I believe we cleared this up in the parallel thread, but just in case:
> reclaim can happen due to a memory.max set lower in the
> tree. memory.low propagation is always relative from the reclaim
> scope, not the system-wide root cgroup.
Clear now.

Michal

--QWRRbczYj8mXuejp
Content-Type: application/x-sh
Content-Disposition: attachment; filename="run.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/bash=0A=0ACGPATH=3D/sys/fs/cgroup/test.slice=0A=0Afunction stop_test=
() {=0A	systemctl stop test.slice=0A}=0A=0Atrap stop_test SIGINT=0A=0Acat >=
/etc/systemd/system/test.slice <<EOD=0A[Slice]=0AMemoryMax=3D800M=0AEOD=0Ac=
at >/etc/systemd/system/test-A.slice <<EOD=0A[Slice]=0AMemoryLow=3D200M=0AE=
OD=0A=0Asystemctl daemon-reload=0A=0A# swap is enabled, these memeaters all=
oc anonymous memory which they don't use=0Asystemd-run --slice=3Dtest-A.sli=
ce -u B.service -p MemoryLow=3D300M /root/memeater 200 -1 0=0Asystemd-run -=
-slice=3Dtest-A.slice -u C.service -p MemoryLow=3D100M /root/memeater 200 -=
1 0=0Asystemd-run --slice=3Dtest-A.slice -u D.service -p MemoryLow=3D0M /ro=
ot/memeater 200 -1 0=0Asystemd-run --slice=3Dtest-A.slice -u E.service -p M=
emoryLow=3D1000M /root/memeater 0 -1 0=0Asleep 3=0Agrep . $CGPATH/memory.cu=
rrent $CGPATH/test-A.slice/memory.current $CGPATH/test-A.slice/*.service/me=
mory.current=0A=0A# pressure is created by allocating anonymous memory and =
working with all of it=0Asystemd-run --slice=3Dtest.slice   -u pressure.ser=
vice  /root/memeater 590 -1 590=0A=0Awhile sleep 1 ; do=0A	echo=0A	grep . $=
CGPATH/memory.current $CGPATH/pressure.service/memory.current $CGPATH/test-=
A.slice/memory.current $CGPATH/test-A.slice/*.service/memory.current=0Adone=
=0A                                                                        =
 =0A
--QWRRbczYj8mXuejp--

--fDP66DSfTvWAYVew
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl5WoN4ACgkQia1+riC5
qSgDVA/9H8HZI1ZPMuHNA/moy98cedv2f/ozll1vidkkYP4dWd/nh2gK/oCWdsfk
pB0iJO4Ungdfb+x/6dUFjlfDPOA+OWcTagPpxBXAtHCtP6hKVF0EbMaOhCoQR9Jq
l2PoUvjmEdh0WUbHpEIt0KN0ZSCpg1VVDfN6mw0LEd04rK/jyfUjAtDJY0KZFvEM
UC2SvM4/w/W6btrSsFJ2t5G8jydXjrQyDu0o6MODiFD0Gmla3hSgm0/cz5eYxhHG
tgWYTg8sqyq/1ebGeNPxK36xvoY3vQwbgS7WFArcAwXnISscBrICmYWV3B45nEY0
nN79XHcsqtROt3JJDshz5aCCdr4a/pqzG08sk6AJHdUX2XgKvC0dit7tx9yy+Vzk
XqJglitN7dbDAyDvk7bE8Ik1Mrv4zZ9WvIelP2ChcBVVo9DM4LN7oxM2CQy06rmt
PaO3RUa7JRfLIajVLAezPCGbFX6zV7fFIaDd76f+twT2vAg3JMpBpxTEvvghq7mY
0CqbHUCU9LDaSHRKJI2Yy0bvnovEYJO4fbKjBuATMQDszGvlI6o6TjNYHSD3oLPP
E1gTKNylyPFSzBHBPyPuiFiN+72XhDk8qxzyCwxd2p8/uUH9KwTccZSxGybhWha7
ZdfMz1gHQykLUo+YTnqHKPVBDKoxSF5UFiIP97oz7PyBLkwZH+w=
=pjT9
-----END PGP SIGNATURE-----

--fDP66DSfTvWAYVew--
