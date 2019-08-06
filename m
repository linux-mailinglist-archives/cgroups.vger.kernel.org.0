Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 742B083673
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 18:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387697AbfHFQMA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 12:12:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:39912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387822AbfHFQL7 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Aug 2019 12:11:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A19EAAC90;
        Tue,  6 Aug 2019 16:11:57 +0000 (UTC)
Date:   Tue, 6 Aug 2019 18:11:53 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tejun Heo <tj@kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alessio Balsini <balsini@android.com>
Subject: Re: [PATCH v13 2/6] sched/core: uclamp: Propagate parent clamps
Message-ID: <20190806161153.GA19991@blackbody.suse.cz>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
 <20190802090853.4810-3-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
In-Reply-To: <20190802090853.4810-3-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 02, 2019 at 10:08:49AM +0100, Patrick Bellasi <patrick.bellasi@=
arm.com> wrote:
> @@ -7095,6 +7149,7 @@ static ssize_t cpu_uclamp_write(struct kernfs_open_=
file *of, char *buf,
>  	if (req.ret)
>  		return req.ret;
> =20
> +	mutex_lock(&uclamp_mutex);
>  	rcu_read_lock();
> =20
>  	tg =3D css_tg(of_css(of));
> @@ -7107,7 +7162,11 @@ static ssize_t cpu_uclamp_write(struct kernfs_open=
_file *of, char *buf,
>  	 */
>  	tg->uclamp_pct[clamp_id] =3D req.percent;
> =20
> +	/* Update effective clamps to track the most restrictive value */
> +	cpu_util_update_eff(of_css(of));
> +
>  	rcu_read_unlock();
> +	mutex_unlock(&uclamp_mutex);
Following my remarks to "[PATCH v13 1/6] sched/core: uclamp: Extend
CPU's cgroup", I wonder if the rcu_read_lock() couldn't be moved right
before cpu_util_update_eff(). And by extension rcu_read_(un)lock could
be hidden into cpu_util_update_eff() closer to its actual need.


--gKMricLos+KVdGMg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAl1JpsAACgkQK2l36XSZ
9y59yRAAiTIJ7zMA4BzWiApDiPUuWBsjGzn3EGAI1lHOu3FP0ILzIJMvHZqRChjv
uENYySwWcX1WMTDdya+T2DlQFgMnmmaoDhfUQsP2WjtFsGgO/2w4iCW+V7E0pfLX
KvYmqSnzd84pGJ13PPlJlaaFtftIPOZSroK9Ne/Qdze8W8NkcyF5EXxEZ1jDYK2Z
OuzOuCTkSfX+G76pZnRkdq+GpomApHpke1Ps4oAYwHfattL2KCum9tNZ1abC2BtO
D9Vstb553sIGcNlV70QsIMO5mCS3v7zdZZE+K86watSuy0yYBq+HarnbYNTzhGdU
7ZQQ6eB+386+jlPinpVwxdu07ZkScZzQmrBMV8IBDyPcSGAj4HreGu/AE/MFKn1u
GuxhhfbvAolvJCO2XxFrko9l1aUAHXOflCEs1Mm2FKvYqYkWG++v2YOSQTFIVhy3
+ZSKSWXeKjSL+rz+FUaEiPzmZrZRNowJfNWNNGBNCFWlyXvXmSVxdXyPs6oJcHI2
t+cCXvdlkUSVYBBlmivh1+ZizXw4RDCh1Vw8yU9Wl5jN+wcOgb/fGfYUeVs+ciDA
hQu+K9hybv1dJrxs9qAbY8vqtZoxxOy5w2XzgyKP1Gg3TevAmVJMcvwE6A1aPd4+
FH0Q0/bjPIDdH2gbWeSa2e3oJXWuVSLBrSLo5nUFFMIY/eTX7WI=
=I3Ys
-----END PGP SIGNATURE-----

--gKMricLos+KVdGMg--
