Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8946250FF
	for <lists+cgroups@lfdr.de>; Tue, 21 May 2019 15:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbfEUNrg (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 May 2019 09:47:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:54202 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726995AbfEUNrg (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 21 May 2019 09:47:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6B11AECE;
        Tue, 21 May 2019 13:47:34 +0000 (UTC)
Date:   Tue, 21 May 2019 15:47:30 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Song Liu <songliubraving@fb.com>
Cc:     Morten Rasmussen <morten.rasmussen@arm.com>,
        Kernel Team <Kernel-team@fb.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] introduce cpu.headroom knob to cpu controller
Message-ID: <20190521134730.GA12346@blackbody.suse.cz>
References: <20190408214539.2705660-1-songliubraving@fb.com>
 <20190410115907.GE19434@e105550-lin.cambridge.arm.com>
 <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <A2E9A149-9EAA-478D-A096-1D4D4BA442B3@fb.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Song.

On Wed, Apr 10, 2019 at 07:43:35PM +0000, Song Liu <songliubraving@fb.com> =
wrote:
> The load level above is measured as requests-per-second.=20
>=20
> When there is no side workload, the system has about 45% busy CPU with=20
> load level of 1.0; and about 75% busy CPU at load level of 1.5.=20
>=20
> The saturation starts before the system hitting 100% utilization. This is
> true for many different resources: ALUs in SMT systems, cache lines,=20
> memory bandwidths, etc.=20
I have read through the thread continuation and it appears to me there
is some misunderstanding on the latency metric (scheduler latency <=3D
your latency <=3D request wall time?).

Could you please describe how is the latency that you report defined and
measured?

Thanks,
Michal


--r5Pyd7+fXNt84Ff3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAlzkAW4ACgkQK2l36XSZ
9y6i5Q/+PtvIsPw08gmvSIO/fdv4U5u+tI7WHJcUXGWD+sTVdVSlB+MWDfdlblUH
HIyGgIBDGL184mq4kiYzxvSMPyorrtlI2Nbvq9SYqLJWPnZGMTWtOgVgb7roVJQG
xk96LUF3nmWjy6wU5wY0GD3J1yaygsqMLOuCP9LQLx8Mqv7yZ5xY+J98Sdm6s1Uo
y9ePTJLq8r8vA/oHSaLyRTiQeN+QYnFmqJvMaqdImM9FH9pO6WADa1Hp/UfN6KT5
06NwWzaqPJ1e5JZqZ5DZMKZSCaLHNS7pywwuTgHgxoGacbBYywQ3VOF67SDwb5zK
oOsE0YL//9Wd2cH6qh3i5301z+lx+WvFyXu3hnKBUKt2RzlT/CqwickpZxamJ3Pk
PtV/7U/gJV404Z2TXE1cMOwfEfgjIE2WanjfMSyIuhkdxGjruQ0Ik+9DDIWMed08
lgH33hEOLGu1qK4TKVXR/MJjdsUNAR60c4SgAWB5oc9hSjrdFDV9wD+UWviizgjM
WMasTRwVoOaP2H9iiXlXQXX2Tei04aHR2fbW0XawsFO/bne47S/r4eHL2TvxuRZR
W/6Q5p5o4nHvOuRQpZ2zTQ5/SXpcRSMHM7xnvxNzFJxjiR3LJmVb1fsGv7D+xIY4
J74b5569lroFCynIj+8XxVv21JHeVtBgYEH2HKUowuk6/DyftnE=
=vB4R
-----END PGP SIGNATURE-----

--r5Pyd7+fXNt84Ff3--
