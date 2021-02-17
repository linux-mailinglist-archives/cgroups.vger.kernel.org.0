Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4167631DE82
	for <lists+cgroups@lfdr.de>; Wed, 17 Feb 2021 18:43:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbhBQRn3 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Feb 2021 12:43:29 -0500
Received: from mx2.suse.de ([195.135.220.15]:42154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234594AbhBQRn0 (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Wed, 17 Feb 2021 12:43:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613583759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a6Rl/czINqek0rZKZZkZim1YkdyieBAQrw40eO7tWpo=;
        b=soFy8+R1BOZzWqypKMO/GP4dVw3MB+lo7eiyCGXhnG4ImOxT6IaKHEB11G9vIuv9sdAyA8
        nw7VQtqcz8RaeT5LDfr2BPqVWi9/ddvB+QBzpoJOQmDYEVNzMUOjsvd/8KSUJszCzOWT0J
        wUDlYi6Sh9TDjry0L3TDFJVGZhBTqjI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E6A9B7B8;
        Wed, 17 Feb 2021 17:42:39 +0000 (UTC)
Date:   Wed, 17 Feb 2021 18:42:32 +0100
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v3 4/8] cgroup: rstat: support cgroup1
Message-ID: <20210217174232.GA19239@blackbody.suse.cz>
References: <20210209163304.77088-1-hannes@cmpxchg.org>
 <20210209163304.77088-5-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Content-Disposition: inline
In-Reply-To: <20210209163304.77088-5-hannes@cmpxchg.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

On Tue, Feb 09, 2021 at 11:33:00AM -0500, Johannes Weiner <hannes@cmpxchg.o=
rg> wrote:
> @@ -1971,10 +1978,14 @@ int cgroup_setup_root(struct cgroup_root *root, u=
16 ss_mask)
>  	if (ret)
>  		goto destroy_root;
> =20
> -	ret =3D rebind_subsystems(root, ss_mask);
> +	ret =3D cgroup_rstat_init(root_cgrp);
Would it make sense to do cgroup_rstat_init() only if there's a subsys
in ss_mask that makes use of rstat?
(On legacy systems there could be individual hierarchy for each
controller so the rstat space can be saved.)

> @@ -5159,11 +5170,9 @@ static struct cgroup *cgroup_create(struct cgroup =
*parent, const char *name,
>  	if (ret)
>  		goto out_free_cgrp;
> =20
> -	if (cgroup_on_dfl(parent)) {
> -		ret =3D cgroup_rstat_init(cgrp);
> -		if (ret)
> -			goto out_cancel_ref;
> -	}
> +	ret =3D cgroup_rstat_init(cgrp);
And here do cgroup_rstat_init() only when parent has it.

> @@ -285,8 +285,6 @@ void __init cgroup_rstat_boot(void)
> =20
>  	for_each_possible_cpu(cpu)
>  		raw_spin_lock_init(per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu));
> -
> -	BUG_ON(cgroup_rstat_init(&cgrp_dfl_root.cgrp));
>  }
Regardless of the suggestion above, this removal obsoletes the comment
cgroup_rstat_init:

         int cpu;
=20
-        /* the root cgrp has rstat_cpu preallocated */
         if (!cgrp->rstat_cpu) {
                 cgrp->rstat_cpu =3D alloc_percpu(struct cgroup_rstat_cpu);

Regards,
Michal

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAmAtVYQACgkQia1+riC5
qSgrug/8CSTeb3l4LFsYInnLNt+TFGvt5ZjsT2mDXjfBjDSY8Nxa0h9Epw58x19L
CbDnD6Q0kLLnK4ZUw4CAM1UWpHqsLaNsRTWg7LhLkpt8YB4r7Mu2TWJFNbq+hvl8
ylFSNrEws0GLv+T7ymT5voKGZacN3TkS7krrEh/4eJfBKIfKVwyfbF984rLCmVk2
ZX7a/e6hc26KKLEEKgRl6bXHeMeQTHe0elonZh7o/U1ganJqzidcs/a4f/kDXy94
NxILYXpoO6A2P3AlzQsMpLxUItsW/8BWEGzwYx3XwXz2Yr5i7fr/5qK24egs4izQ
o9BsDCE4mO+V7WEUxDQjG5LhQLFh4AmsGuk/NQeLZEPebTdkbBeA3FaWDzSd4SWw
GWELqOFMduOse8dAofnWv0dAjSxUspJ2dyVSD9d2mAO4Zf1DohjdAtCR5BmFTS8E
Jq0/DQk4bAY9dou2JzpA5CF8WSp/oKnPoZymFTW5om9bwm8yAsrhshzQ40d5DOD0
lwpswxSbv7cHE+qxyTU2/jEgjKfis9Fir+gS47OjHMQvBuZ4OLU4r7flg5IUo5X1
Vk8zvbDD9Y22pFVAzg5UXgRZZoHepbgJaGUW+E/A4+hy7iWpgX9M44f9Devyjyrt
tL9oj/nw/RKkkdsCn3s4z2ZykQzhU0boLi2qzeHENef45VDHqyY=
=LqMk
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
