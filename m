Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E77F2FE3C9
	for <lists+cgroups@lfdr.de>; Fri, 15 Nov 2019 18:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbfKORSL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 15 Nov 2019 12:18:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:46116 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727531AbfKORSL (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 15 Nov 2019 12:18:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 367BDAD20;
        Fri, 15 Nov 2019 17:18:09 +0000 (UTC)
Date:   Fri, 15 Nov 2019 18:18:07 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        lizefan@huawei.com, tj@kernel.org, hannes@cmpxchg.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        Dietmar.Eggemann@arm.com, morten.rasmussen@arm.com,
        qperret@google.com
Subject: Re: [PATCH v2] sched/topology, cpuset: Account for housekeeping CPUs
 to avoid empty cpumasks
Message-ID: <20191115171807.GH19372@blackbody.suse.cz>
References: <20191104003906.31476-1-valentin.schneider@arm.com>
 <d7ed40aa-1ac1-a42d-51eb-b1bd9f839fb1@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nFBW6CQlri5Qm8JQ"
Content-Disposition: inline
In-Reply-To: <d7ed40aa-1ac1-a42d-51eb-b1bd9f839fb1@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--nFBW6CQlri5Qm8JQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Thu, Nov 14, 2019 at 04:03:50PM +0000, Valentin Schneider <valentin.schn=
eider@arm.com> wrote:
> Michal, could I nag you for a reviewed-by? I'd feel a bit more confident
> with any sort of approval from folks who actually do use cpusets.
TL;DR I played with the v5.4-rc6 _without_ this fixup and I conclude it
unnecessary (IOW my previous theoretical observation was wrong).


The original problem is non-issue with v2 cpuset controller, because
effective_cpus are never empty. isolcpus doesn't take out cpuset CPUs,
hotplug does. In the case, no online CPU remains in the cpuset, it
inherits ancestor's non-empty cpuset.

I reproduced the problem with v1 (before your fix). However, in v1
effective =3D=3D allowed (we're destructive and overwrite allowed on
hotunplug) and we already check the emptiness of=20

  cpumask_intersects(cp->cpus_allowed, housekeeping_cpumask(HK_FLAG_DOMAIN)

few lines higher. I.e. the fixup adds redundant check against the empty
sched domain production.

Sorry for the noise and HTH,
Michal

--nFBW6CQlri5Qm8JQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3O3cgACgkQia1+riC5
qSiGeA//dbxeLleRivvTRMu6ewhKeYA5GfAfmrsle+ZHgxKgu13LIa8eHLAWPu/Z
YyHPHLctNpNYafHe47dMbAxduA4roPTtZzN8AMN4bRkrT85c1ZqCAVel6eZLU9Dj
RIwV9vK3E6RBObG8W9Qq7b6Rhlty6mwnGpxil7oqJq/MxKe0DOYjYKsrl5JROc3G
iywiIignt9izFFqK1z7R4TX4H9Q0ir/FEiu75CWMx7Ch5jSMgCUwcJiE1gTDognS
vKIDIp0BD4nidnpLoP18iaywle6HbZOX6xT2GJXS5waCY6uKzHas++Jh/PdWYpTR
+fzCQDS9otWlwSPUj/GSKwJbRakmxMWsfJp2/QreiWWbcS9XBxEH56jD03PBIF8A
3toQN5kLVu+kWf2v5v+avd6jaIXMRtm5uBigmkmmax/vjq9UtzWI8FzMhcx48BTI
FHzWdwP3BcptZClp6O/4pLQ8doP/RINGtQgvYvnFvEDrJQGO2xxJ78FBRZ7WxQVU
BuS3yDu8Ntxa8CuJBgFNJpN9yDu0rGHbknKDTHZ2vXWT6/v6B3B2UkdGGvmm4mQC
RKoUjKoTQoLDCIvErQLI+PP62twGsz0lGJVm8WEPhVbs5AZIXPAJ8tx8LKngfXE8
38cy25tQ+hKhVtf+jIclTTYaN3Nvh2MBUKpZYXAQwdvXeiGn3NI=
=2oDh
-----END PGP SIGNATURE-----

--nFBW6CQlri5Qm8JQ--
