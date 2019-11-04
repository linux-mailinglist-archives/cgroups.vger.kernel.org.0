Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1BA5EE7C5
	for <lists+cgroups@lfdr.de>; Mon,  4 Nov 2019 19:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728778AbfKDS5r (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 4 Nov 2019 13:57:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:35630 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728510AbfKDS5r (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Mon, 4 Nov 2019 13:57:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 22F82ACB6;
        Mon,  4 Nov 2019 18:57:45 +0000 (UTC)
Date:   Mon, 4 Nov 2019 19:57:42 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Juri Lelli <juri.lelli@redhat.com>, mathieu.poirier@linaro.org
Cc:     peterz@infradead.org, mingo@redhat.com, rostedt@goodmis.org,
        tj@kernel.org, linux-kernel@vger.kernel.org,
        luca.abeni@santannapisa.it, claudio@evidence.eu.com,
        tommaso.cucinotta@santannapisa.it, bristot@redhat.com,
        lizefan@huawei.com, longman@redhat.com, dietmar.eggemann@arm.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH v9 3/8] cpuset: Rebuild root domain deadline accounting
 information
Message-ID: <20191104185742.GC7827@blackbody.suse.cz>
References: <20190719140000.31694-1-juri.lelli@redhat.com>
 <20190719140000.31694-4-juri.lelli@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20190719140000.31694-4-juri.lelli@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello.

I came across a cgroup_enable_task_cg_lists() call from the cpuset
controller...

On Fri, Jul 19, 2019 at 03:59:55PM +0200, Juri Lelli <juri.lelli@redhat.com> wrote:
> --- a/kernel/cgroup/cpuset.c
> +++ b/kernel/cgroup/cpuset.c
> [...]
> +static void rebuild_root_domains(void)
> +{
> +	struct cpuset *cs = NULL;
> +	struct cgroup_subsys_state *pos_css;
> +
> +	lockdep_assert_held(&cpuset_mutex);
> +	lockdep_assert_cpus_held();
> +	lockdep_assert_held(&sched_domains_mutex);
> +
> +	cgroup_enable_task_cg_lists();
...and I wonder why is it necessary to call at this place?

(IIUC, before cpuset hierarchy is anywhere mounted it's mere top_cpuset,
i.e. processing the top_cpuset alone is enough. And if anyone wants to
create any non-root cpusets, they have to mount the hierachy first, i.e.
no need to call cgroup_enable_task_cg_lists() manually. Also if I'm not
overlooking anything, the race between hotplug and mount (more precisely
new cpuset creation) should be synchronized by cpuset_mutex.)

Thanks,
Michal

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl3AdJ8ACgkQia1+riC5
qSi+RA//fudY8YZhWshSdEbKhCAhyiKaBx3noxOAIsbI07smX9H3cCKqt/VuURNY
jHy+43M9FQ1q3JnygVu5ldGgHUqXtuLugTA7oFSPVtATtHH37TLfpbUrspZBIUBp
OTAJ3OHK2M1GlSCY++gA4KJ2XEI5cJQEc3UWK/pC2UGVlQ29V8UFa55ZQVnrO+pO
EYoVOxlm9p6NoHjtgQ+xNXKjWfqGhrzl9L2VbxlGcBjP4Zkhdm7OE3VHZ6hwozH8
2aTuKte+DuU9GvMqMkmqKJfWHDB/mPNVZOb6IwQx4OOtKfrE3PZKgklBAMp9bolZ
nwmODQbvZDoUKplmYum/RwlIlKFfw5gVa8W/T6oVBytbNqgk+yrUCKZlOIEOwm1e
SJ/AeA5TfKXk7KL/8giEUpRQJCl+egl+ZQFXRZjkzrEDQm9HlOaCJohL7CifK70w
qjk9hkg4Gj9g01brD6qlcbi2ewALZqKjprsPcVOORG6FlF9CN25qypc0P2r+KfuP
IfceIaEO3YolOxrJGY61eDKorEI3L+i2TTAhf4z3HEpf8lnaZl8C0TglGjlZy8F4
k7l4hRJObilzKyjuxyC4pGRHKEKPsqnfP7g+AClPBKlpa77edYuswdOV+TPxmJWl
KVhOnhZgRd8Iyq67vnHMN0aw6xFtSjWQC+Sxu5OuzLTfAOjUTEo=
=VQRg
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
