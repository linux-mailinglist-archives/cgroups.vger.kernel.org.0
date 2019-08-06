Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CB2B83684
	for <lists+cgroups@lfdr.de>; Tue,  6 Aug 2019 18:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387864AbfHFQMM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Aug 2019 12:12:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:40078 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387859AbfHFQML (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Tue, 6 Aug 2019 12:12:11 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 2DF17AE82;
        Tue,  6 Aug 2019 16:12:10 +0000 (UTC)
Date:   Tue, 6 Aug 2019 18:12:06 +0200
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
Subject: Re: [PATCH v13 0/6] Add utilization clamping support (CGroups API)
Message-ID: <20190806161206.GA20526@blackbody.suse.cz>
References: <20190802090853.4810-1-patrick.bellasi@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <20190802090853.4810-1-patrick.bellasi@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 02, 2019 at 10:08:47AM +0100, Patrick Bellasi <patrick.bellasi@arm.com> wrote:
> Patrick Bellasi (6):
>   sched/core: uclamp: Extend CPU's cgroup controller
>   sched/core: uclamp: Propagate parent clamps
>   sched/core: uclamp: Propagate system defaults to root group
>   sched/core: uclamp: Use TG's clamps to restrict TASK's clamps
>   sched/core: uclamp: Update CPU's refcount on TG's clamp changes
>   sched/core: uclamp: always use enum uclamp_id for clamp_id values
Thank you Patrick for your patience. I used the time to revisit the
series once again and I think the RCU locks can be streamlined a bit. If
you find that correct, feel free to add my Reviewed-by to the updated
series (for 1/6 and legacy, I'm just asking).

Michal

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE+amhwRV4jZeXdUhoK2l36XSZ9y4FAl1JptUACgkQK2l36XSZ
9y5W6A//bd2vajYPAer2JvC6d9xuQWZZ5TLPE3p5GabysMeyHBvrsPBtDVkfxPCl
Ig0xnM1ann3/V4zG1hxP1jRoeN8z7e6wzhgCo9NC3LEcrPMSGSu1+3eO9NW9jWEw
xWCYZgcZVNypWOJ0TshOLQVHy9ZvqYw7kfRPKzz4YsuUVUffmz41ImNqIh+OlU+C
lBhfJcFb0CeNqWEcCinM4E8tSuYa80fzH2lx+qtTxNoO8n+QnISkuNF6h5OebgWW
AnJ0AbG8GeF5qV6pcAO+1Au9PzrbeNPhPDiesNuaHZsFwgIzUESlMrsRGecHZl9h
BjBA4tyd4alIxX7tFsit8zny1Xr/AL6ZFZziYdiFJGMucatfp5pQQ2ig7zIOv1pc
84e28nAAQ281V0qvTAaf1GuuTErFCLY7B8H7C4aCtZ1A6ZE/maFwE0NIOB9j9TmM
30VenQ9F1IfTaigHm8BqTjH9L2KnY3L2dQ9jLcdxrcfUJDpMhs/CDu/Lnz9/SRk3
x3PJq2uecZKMaULdCp1rqkdseKqxcZ++gxkzt6wGLwVUwQP8XW2gyWclFWlw/PLU
H8NLcDN1a8BMj1kHxNzTk661nLNr/5zhHVkzDmDs6ydHCSP1o0KJHeJOxtKHg7Lm
p1cQRmFoBN581HHKA9wHYk7GAmEGRLoQ+lXA0lcIb0aIU0boDz0=
=gVva
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
