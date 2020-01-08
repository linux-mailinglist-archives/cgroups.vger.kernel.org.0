Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D20BF134702
	for <lists+cgroups@lfdr.de>; Wed,  8 Jan 2020 17:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbgAHQBJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Jan 2020 11:01:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:38584 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727152AbgAHQBJ (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 8 Jan 2020 11:01:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 145C8AEAF;
        Wed,  8 Jan 2020 16:01:07 +0000 (UTC)
Date:   Wed, 8 Jan 2020 17:01:02 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tejun Heo <tj@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH v2 2/3] clone3: allow spawning processes into cgroups
Message-ID: <20200108160102.GA17415@blackbody.suse.cz>
References: <20191223061504.28716-1-christian.brauner@ubuntu.com>
 <20191223061504.28716-3-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline
In-Reply-To: <20191223061504.28716-3-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2019 at 07:15:03AM +0100, Christian Brauner <christian.brau=
ner@ubuntu.com> wrote:
> This adds support for creating a process in a different cgroup than its
> parent.
Binding fork and migration together looks useful.

> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -5882,21 +5882,176 @@ void cgroup_fork(struct task_struct *child)
>  	INIT_LIST_HEAD(&child->cg_list);
Just a nitpick, I noticed the comment for cgroup_fork should be updated
too (generic migration happens in cgroup_post_fork).

> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> [...]
> @@ -2279,8 +2278,7 @@ static __latent_entropy struct task_struct *copy_pr=
ocess(
>  	write_unlock_irq(&tasklist_lock);
> =20
>  	proc_fork_connector(p);
> -	cgroup_post_fork(p);
> -	cgroup_threadgroup_change_end(current);
> +	cgroup_post_fork(current, p, args);
I can see that when CLONE_INTO_CGROUP | CLONE_NEWCGROUP is passed, then
the child's cgroup NS will be rooted at parent's css set
(copy_namespaces precedes cgroup_post_fork).

Wouldn't it make better sense if this flags combination resulted in
child's NS rooted in its css set?

Michal


--G4iJoqBmSsgzjUCe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl4V/LkACgkQia1+riC5
qSh7ww/+JtgrB5RnfOwdlpOAFEIzNIFUXCtwsKQCZ+yWH6llH6b4JzLIIjX3S5Eq
/99Cm3s9+6TG6Wr534KUcCfml7nToo/efiRjjuf0j0ZAPPR5y9s58s/qqH4oakiD
2j4/FI86+StapFYGv8yJlQ59DZkFoDIYrPu1cYGYVzqcCo0TBSfmIK3kcO6OBA0O
Z1aDXQGz0svw5ssVNMpOp/3P74ctvohlNAgYLNELbeMOoR6JFEiVug0kfQh1E8mo
pPQUt1wsDNAB81h1i/5JKlkS7uYbIeDsV0i/aRM+2NGs323mDKK9iSm8EBXRhCWX
1Y6+PuBLp7ZRPISsBZT+8jCsAwuBo2y48dw/KORd2BdBpZrxF2yLwRZNC2oRPuWX
suMafu+vnI9ompGkrlgs0sFGiYMQiBmM0MtBCYD8MfEiJjPxGn6b17bSBNRxyzOa
Jq1SjbPrWGWy/Pz+2CGFJstRJVsISBJbEejmBhDCo9MviK3V+2LDu0mYPvGXzJ/d
2Kgslb9sdTQbSgeIQy+qcn9mWHZAfuyxC5i+7DJ/bE7l4bofN3TmkeFBriq9D4vU
NELLJCnhQ7kDFhaTkFzMRrBMbkpG5Och8XfWFQDw4uskjTe8w9nORAsq/HtA/Ldv
EHVorBc5qw9PReix/NFxNKD7vQHD0qwqHkG4h9QQbmsrtKB1/lQ=
=atMP
-----END PGP SIGNATURE-----

--G4iJoqBmSsgzjUCe--
