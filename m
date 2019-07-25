Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 497E474D55
	for <lists+cgroups@lfdr.de>; Thu, 25 Jul 2019 13:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404159AbfGYLlr (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 25 Jul 2019 07:41:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:58006 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404095AbfGYLlr (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Thu, 25 Jul 2019 07:41:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5F5EBAD4C;
        Thu, 25 Jul 2019 11:41:45 +0000 (UTC)
Date:   Thu, 25 Jul 2019 13:41:37 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     cgroups@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Alessio Balsini <balsini@android.com>,
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
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v12 3/6] sched/core: uclamp: Propagate system defaults to
 root group
Message-ID: <20190725114126.GA4130@blackbody.suse.cz>
References: <20190718181748.28446-1-patrick.bellasi@arm.com>
 <20190718181748.28446-4-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wzJLGUyc3ArbnUjN"
Content-Disposition: inline
In-Reply-To: <20190718181748.28446-4-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--wzJLGUyc3ArbnUjN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2019 at 07:17:45PM +0100, Patrick Bellasi <patrick.bellasi@=
arm.com> wrote:
> The clamp values are not tunable at the level of the root task group.
> That's for two main reasons:
>=20
>  - the root group represents "system resources" which are always
>    entirely available from the cgroup standpoint.
>=20
>  - when tuning/restricting "system resources" makes sense, tuning must
>    be done using a system wide API which should also be available when
>    control groups are not.
>=20
> When a system wide restriction is available, cgroups should be aware of
> its value in order to know exactly how much "system resources" are
> available for the subgroups.
IIUC, the global default would apply in uclamp_eff_get(), so this
propagation isn't strictly necessary in order to apply to tasks (that's
how it works under !CONFIG_UCLAMP_TASK_GROUP).
The reason is that effective value (which isn't exposed currently) in a
group takes into account this global restriction, right?


> @@ -1043,12 +1063,17 @@ int sysctl_sched_uclamp_handler(struct ctl_table =
*table, int write,
> [...]
> +	if (update_root_tg)
> +		uclamp_update_root_tg();
> +
>  	/*
>  	 * Updating all the RUNNABLE task is expensive, keep it simple and do
>  	 * just a lazy update at each next enqueue time.
Since uclamp_update_root_tg() traverses down to
uclamp_update_active_tasks() is this comment half true now?


--wzJLGUyc3ArbnUjN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAl05lXAACgkQK2l36XSZ
9y5cgw//QQud17T2NvswG8hJs4iqq9hLqZdoEQh3auHGt5gBhY//Pre7fKieLaeQ
twqmtcup1hN8T5n1s3J88mCC/Hl7uRlvQyHj2TrN5kFbRgrPRExi6desTMWU6hGp
nyfsenwH7NvPPUWlO7RhIQtRJRc23cHen01DxTWDJZrg48oeZnoJV533Sj9Qf6tV
qGTj1ZikLeyPzlVvHwnP1Vb+kBIQ1VTU8dZCkV+0RW4qFtnin7nmYca57/ARC8RV
KnE/DZNVETsikE/J/3dyvxw/5cJGYoZssikqIjnSrmF9eoXvWzkEnUsg2WFO6Rtl
UuFllWgrPScfjBlq1KfsD4WOCGgMtiuUtaOSe3SSnH2dVALsHfgmW5pqnMC38N3O
kEV1abGka6x2VTX1HJyXW/buNP5WQY2fh2dWFm06oe1iC80NiLmIULpTKZYIVdtZ
LWZfAOjcXU3fwdAu8daZOKnizG0mOfQxT7PiaX/A74ucc0DV0C2JnM+MszR3pWIp
huSGQ3AU4V2+OGbJPO7/rht//Du47t77tzF1RXjpjONMq8ONGIeFQ4Ansp3hSQS3
98shobgsl2Be0MUm7nWKHSOay48IoJJuZoKwvoi/rFE3Elnlbs6fcJE5IWdM3PW4
EmmxngweF0LmvVlDGLZ4JP6utbdgvGEUpJ1DUfmkKOnE4bKT60o=
=lOBr
-----END PGP SIGNATURE-----

--wzJLGUyc3ArbnUjN--
