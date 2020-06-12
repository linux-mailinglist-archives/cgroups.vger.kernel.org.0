Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F551F7C06
	for <lists+cgroups@lfdr.de>; Fri, 12 Jun 2020 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726258AbgFLREA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 12 Jun 2020 13:04:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:41048 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgFLREA (ORCPT <rfc822;cgroups@vger.kernel.org>);
        Fri, 12 Jun 2020 13:04:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 7629CAECE;
        Fri, 12 Jun 2020 17:04:01 +0000 (UTC)
Date:   Fri, 12 Jun 2020 19:03:52 +0200
From:   Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Down <chris@chrisdown.name>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/6] mm, memcg: Prevent memory.low load/store tearing
Message-ID: <20200612170352.GA40768@blackbook>
References: <cover.1584034301.git.chris@chrisdown.name>
 <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
In-Reply-To: <448206f44b0fa7be9dad2ca2601d2bcb2c0b7844.1584034301.git.chris@chrisdown.name>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.

I see suspicious asymmetry, in the current mainline:
>	WRITE_ONCE(memcg->memory.emin, effective_protection(usage, parent_usage,
>			READ_ONCE(memcg->memory.min),
>			READ_ONCE(parent->memory.emin),
>			atomic_long_read(&parent->memory.children_min_usage)));
>
>	WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_usage,
>			memcg->memory.low, READ_ONCE(parent->memory.elow),
>			atomic_long_read(&parent->memory.children_low_usage)));

On Thu, Mar 12, 2020 at 05:33:01PM +0000, Chris Down <chris@chrisdown.name>=
 wrote:
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index aca2964ea494..c85a304fa4a1 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6262,7 +6262,7 @@ enum mem_cgroup_protection mem_cgroup_protected(str=
uct mem_cgroup *root,
>  		return MEMCG_PROT_NONE;
> =20
>  	emin =3D memcg->memory.min;
> -	elow =3D memcg->memory.low;
> +	elow =3D READ_ONCE(memcg->memory.low);
> =20
>  	parent =3D parent_mem_cgroup(memcg);
>  	/* No parent means a non-hierarchical mode on v1 memcg */
> @@ -6291,7 +6291,7 @@ enum mem_cgroup_protection mem_cgroup_protected(str=
uct mem_cgroup *root,
>  	if (elow && parent_elow) {
>  		unsigned long low_usage, siblings_low_usage;
> =20
> -		low_usage =3D min(usage, memcg->memory.low);
> +		low_usage =3D min(usage, READ_ONCE(memcg->memory.low));
>  		siblings_low_usage =3D atomic_long_read(
>  			&parent->memory.children_low_usage);
Is it possible that these hunks were lost during rebase/merge?

IMHO it should apply as:

-- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6428,7 +6428,8 @@ enum mem_cgroup_protection mem_cgroup_protected(struc=
t mem_cgroup *root,
                        atomic_long_read(&parent->memory.children_min_usage=
)));

        WRITE_ONCE(memcg->memory.elow, effective_protection(usage, parent_u=
sage,
-                       memcg->memory.low, READ_ONCE(parent->memory.elow),
+                       READ_ONCE(memcg->memory.low),
+                       READ_ONCE(parent->memory.elow),
                        atomic_long_read(&parent->memory.children_low_usage=
)));

 out:


Michal

--6TrnltStXW4iwmi0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEEoQaUCWq8F2Id1tNia1+riC5qSgFAl7jtXIACgkQia1+riC5
qSjUig//d3bjL+7mCpm6speHzN1vPZbVuEsBjl+P4DhMwGSl1iiwWP8chYdm30Xg
5l8eACsZox2Zta2TvNkqUKaYSanJ3+cY4j6vFecnJ2ADRwTG5OgKJHz4pPpTSDox
9YVzYsOzLVF/cfoOiD2GPer+YBaEMyppaqWwfzAb2XoKUmdHsY1A/nBllvbTSm6c
zbGdMqb3kt/ixm8cljE/0Wyk26QeyydHBQuU9XW1VQZniQhDWwi4tR7lfFCxMYtQ
9/PUKtgmZ+ku8YOEoc9twXbOxR8C3MZo7zZslrcVvqrF1bVOkpYAZMIMGnSLFf9Q
Mdcmbf81yPWEd/7hRO8vC8ICfBnU1nN14f1+MuXt56VWtmLnn/UqJ5sS3vqF5tgV
iBlucq9xjxMKsvoT15tNq3DX+CKL5bdqAOglSmT/XwUW1hsVycQ0spCWQ5J4K/bQ
ljahv3T9G4UgGouUwrVTZxU2+JC7YQg5BqJoC4sf0hLdFcVjdcq/aQis4b8TZLVs
36wBd/QpHGVEh1bZ5LN2AcFY+WhahNswJjM2rx2WB1S9IMhukeIe2C/PjpKnc2Zw
ff7+GBkyif/+0Xwj7N+aXSsLQ/0Xjv3kgcbOXGU0jjdoEpQxyOVtb8mAKGDRHt1D
hIr7XNHBIOUgzGC+YBl0fGDVYCWXEg45umFPdf6OTx8MCONUjQI=
=Uooi
-----END PGP SIGNATURE-----

--6TrnltStXW4iwmi0--
