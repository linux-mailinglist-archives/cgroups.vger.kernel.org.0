Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEA0ABAAA
	for <lists+cgroups@lfdr.de>; Fri,  6 Sep 2019 16:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394394AbfIFOSG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 6 Sep 2019 10:18:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:36032 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2394366AbfIFOSG (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 6 Sep 2019 10:18:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9904BAE50;
        Fri,  6 Sep 2019 14:18:04 +0000 (UTC)
Date:   Fri, 6 Sep 2019 16:18:02 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, tglx@linutronix.de,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/4] cgroup: Remove ->css_rstat_flush()
Message-ID: <20190906141801.GC16166@blackbody.suse.cz>
References: <20190816111817.834-1-bigeasy@linutronix.de>
 <20190816111817.834-2-bigeasy@linutronix.de>
 <20190821155329.GJ2263813@devbig004.ftw2.facebook.com>
 <20190822082032.qyy2isvvtj5waymx@linutronix.de>
 <20190822135823.GO2263813@devbig004.ftw2.facebook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <20190822135823.GO2263813@devbig004.ftw2.facebook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 22, 2019 at 06:58:23AM -0700, Tejun Heo <tj@kernel.org> wrote:
> Nack for the whole series.  Please stop mixing interface and locking
> changes.
A bit na=EFve question -- why to keep unused functions that may come
handy, in the future, possibly? (I reckon there is no clear general
answer, the two cases below illustrate that.)

The reasons for ->css_rstat_flush() presence that I see:
- it's the required extension point of rstat mechanism,
- together with cgroup_rstat_lock it keeps a guarantee for potential
  users that they don't need to synchronize on their own when
  aggregating stats.

I'm not so sure about cgroup_rstat_flush_irqsafe() though. That function
is currently not used. Would anyone possibly need doing stats
aggregation in IRQ context? I don't see the reason. Then the
cgroup_rstat_lock could be taken without IRQs disabled as proposed, no? [1]

The "[PATCH 4/4] cgroup: Acquire cgroup_rstat_lock with enabled
interrupts" also moves the IRQs disabling to the per-cpu
cgroup_rstat_cpu_lock. Honestly, I don't understand the reasoning.
(Although, disabling IRQs with this lock may see some use if stat
updates happened from within IRQ handlers.)

Michal

[1] Or do we need IRQs disabled because of cputime_adjust() obtaining
consistent data (in cgroup_base_stat_cputime_show())? Then
cgroup_rstat_flush_hold() shouldn't pass may_sleep =3D true.

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl1yapMACgkQia1+riC5
qShJPQ/7B31c73JmytHOgI20xfrHekaUXXCvLL6U/05WMVckKdOCeSM/ikyhAL1u
sWDz2mKlm3sGC6BDrgNATmecQhz8gtB2R32U5waV9GZufaNZ6YloIPqnx5j5RBW8
E+QRxaThfinr2k/l7zj+mQtRm2kC2zaedi2whBqxlBCcqlicGIxuMhaH7CwNeWJx
7+YW2Lfq3BXkE/fI1xUUplwH7B+ZX4NmtXiF7jaVYAeQD9X9+Ms3IAiDZxDiVYP5
+5daTMbbEIL8lqeU4F5D1OP/Ct3Y3hR+l7EU8sVn6wri6Lzl0AFljlw2RyK+wjdL
TlOsHHN40hU7c+qOZajhAxr8lGZssW/kQVQ7oj0WCgyhyfkSO32WnNUfqnlPXsMv
MYCelzfcySr23XQwqzBhsYcO0P4OVf06C17oi4AyVhAZgN7lxeGQKG3m6qzpBuLf
92Fb5kupB74rRJz/1OJzZLf0/60UwuMNmqJEF7Bc6H7sjxI6qaGQY/h5qC9gkwkz
R5b+m/+6z1nqqR4Tisp1R1XKVjKXfKxJnCiStSJVw35wrurAx85rgihrBHIxEOOJ
ZbnFi+o6ZOng40ZnN01BEOlx3Vff0dHQMivBrUFkmJfTuoDiEYvJkdYFVDefohMT
jpr3IluvQadyX+E3S6wnpOhJEr1Yq7ygK0q9ObojZnbLHiAluZ4=
=GVQ5
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
