Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414FF867C5
	for <lists+cgroups@lfdr.de>; Thu,  8 Aug 2019 19:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404223AbfHHRQZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 8 Aug 2019 13:16:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:53980 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404211AbfHHRQY (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 8 Aug 2019 13:16:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 1B717AE48;
        Thu,  8 Aug 2019 17:16:23 +0000 (UTC)
Date:   Thu, 8 Aug 2019 19:16:21 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Alessio Balsini <balsini@android.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Joel Fernandes <joelaf@google.com>,
        Paul Turner <pjt@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Todd Kjos <tkjos@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Tejun Heo <tj@kernel.org>,
        VincentGuittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v13 2/6] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190808171620.GE8617@blackbody.suse.cz>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
 <20190802090853.4810-3-patrick.bellasi@arm.com>
 <20190806161153.GA19991@blackbody.suse.cz>
 <87h86r4rvp.fsf@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <87h86r4rvp.fsf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2019 at 04:08:10PM +0100, Patrick Bellasi <patrick.bellasi@=
arm.com> wrote:
> Well, if I've got correctly your comment in the previous message, I
> would say that at this stage we don't need RCU looks at all.
Agreed.

> Reason being that cpu_util_update_eff() gets called only from
> cpu_uclamp_write() which is from an ongoing write operation on a cgroup
> attribute and thus granted to be available.
>=20
> We will eventually need to move the RCU look only down the stack when
> uclamp_update_active_tasks() gets called to update the RUNNABLE tasks on
> a RQ... or perhaps we don't need them since we already get the
> task_rq_lock() for each task we visit.
Unless you remove css_for_each_descendant_pre() in
cpu_util_update_eff(), the rcu_read_lock() cannot go below it.
(You'd be RCU-accessing other csses that aren't pinned in the write.)

Michal

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl1MWN8ACgkQia1+riC5
qSityw/+JXOBnu4pwW3aN+tZLpsDmQp30H/RvF8UM9xruXiajWC8seiPhBHO/K+d
NTgTcMYp4XLXOBDOPR1OvFFLAhgv38xf4R4+kyvg9Z6Yq0jRbOQR6t/foXIOEKV4
OhkPVNl57zVqJoUmTMN5I7ld8AM/dA4RPas3vG9qLrALc1cycaSGmeTNRNzGo3Ga
zhNO5KOYipeQoMJJw+KslJgfUctj7YPLKrIDeqt7wRJ6s1rJ8srqlR4QJiqnwvpt
Adit3pj4WaOMaYJhX7HuAgEn26kwKkX1Edw9a7BJQny2Zu+CxPrR7AkHPD/eTJyG
XHHBBhW3vsKGYkOSpSTavv1Pc+402OkteacYPiP7Hh38UHPEeOnKjAwJFnDRDUKJ
mwOw08r0d7tMZKBnMgchOPtpOATD2M9/No9z8TVFoxILfcXpMjEQE6apYVNH2rvl
vJkH7wujXxbkWCgL6xopQdyG//G/vGHrPPWJmlhNMvL4Y/KRwj7zEqMvOHC1XQAt
WpqQGv5uI6R0WZv31qSIkoXGsfnNx2oz/tR16SpAQUvKRu7en2KwgvzHQGbBfXmV
LuNR/iu0/tuOac76MEvdu3dAAyoccmdmYmBZSKm0/+wcqDAa8SKu3CIWhWb8Bu5P
+LzuhocAwLPW4ZGSUxuQ+np/D+SyqOJSIhJIlqAmSPtG6TMDGkI=
=LPyl
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
