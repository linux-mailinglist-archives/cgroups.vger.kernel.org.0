Return-Path: <cgroups+bounces-8701-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 945FEAFF0CE
	for <lists+cgroups@lfdr.de>; Wed,  9 Jul 2025 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8858E1C4289E
	for <lists+cgroups@lfdr.de>; Wed,  9 Jul 2025 18:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F114523A995;
	Wed,  9 Jul 2025 18:22:23 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548BB23958F;
	Wed,  9 Jul 2025 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085343; cv=none; b=SQaC49TAoMFYEV3ptbEGpplzrYsi6BLVBuy0eX001ZdXJV9iyiDBJHyCHzpQnP5eKMYh8YZs6535YHxX8tDns6NdoD6lbmLj8wbqREzbgfikS1v0gHv+GpjA8lKOcS9Cn4uslIrJMWbMgz0nq3ffLTP1dl+IjQC/ke7Eexj0Ru4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085343; c=relaxed/simple;
	bh=LYlalR3RLd6f+/Ka8VLwgGoSqq6pp8Fap9inGG3QKg8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VicAETDXTBzMC/mHY/ZkD4lhm3Kdel2tSimUTpPq/6XWxX+ngtie4Dcz2g3TC5hosp7U20rIsZODW5HtsnYysPm6i0SXZT929MUD6jBthGcofK4wgNF6kSdSr5QTTEnEaPD/dkrYxJl+sUpcPqSr++Osn0pLxq6QnaBOfOzN6Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [89.234.162.240] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZZQv-004kJU-1J;
	Wed, 09 Jul 2025 18:22:16 +0000
Received: from ben by deadeye with local (Exim 4.98.2)
	(envelope-from <ben@decadent.org.uk>)
	id 1uZZQt-0000000Ansu-2wDp;
	Wed, 09 Jul 2025 20:22:15 +0200
Message-ID: <b26b60b7d0d2a5ecfd2f3c45f95f32922ed24686.camel@decadent.org.uk>
Subject: Re: [PATCH 4/4] cgroup: Do not report unavailable v1 controllers in
 /proc/cgroups
From: Ben Hutchings <ben@decadent.org.uk>
To: Michal =?ISO-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc: Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>, Johannes
 Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, Roman
 Gushchin	 <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Chen Ridong	 <chenridong@huawei.com>,
 1108294@bugs.debian.org
Date: Wed, 09 Jul 2025 20:22:09 +0200
In-Reply-To: <20240909163223.3693529-5-mkoutny@suse.com>
References: <20240909163223.3693529-1-mkoutny@suse.com>
	 <20240909163223.3693529-5-mkoutny@suse.com>
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Mdj+QvgzK/UNDkneOc1n"
User-Agent: Evolution 3.56.1-1 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 89.234.162.240
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--=-Mdj+QvgzK/UNDkneOc1n
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2024-09-09 at 18:32 +0200, Michal Koutn=C3=BD wrote:
> This is a followup to CONFIG-urability of cpuset and memory controllers
> for v1 hierarchies. Make the output in /proc/cgroups reflect that
> !CONFIG_CPUSETS_V1 is like !CONFIG_CPUSETS and
> !CONFIG_MEMCG_V1 is like !CONFIG_MEMCG.
>=20
> The intended effect is that hiding the unavailable controllers will hint
> users not to try mounting them on v1.

This change can cause problems for the OpenJDK JVM, as reported in
<https://bugs.debian.org/1108294>.

Since OpenJDK version 11, the JVM can detect and adapt to cpuset and
memory limits.  It supports both the cgroups v1 and v2 API, but before
version 25 it always relied on /proc/cgroups to detect whether those
controllers were enabled.

The result of this patch is that if CONFIG_MEMCG_V1 is disabled the JVM
can easily trigger OOM when otherwise it would trim its memory usage
through garbage collection.  (For cpusets, I'm not sure of the impact
but I think it might make bad decisions about the size of thread pools.)

Although the fix in OpenJDK 25 can probably be backported to older
versions, this issue primarily affects container workloads so fixing
this in distribution packages would not be sufficient.

The obvious compatibility fix for this at the kernel level is to enable
CONFIG_{CPUSETS,MEMCG}_V1.  But since the v1 API has long been
deprecated and is not actually needed by OpenJDK, I would prefer not to
do that.

Would you consider reverting this change for the sake of compatibility?

Ben.

> Signed-off-by: Michal Koutn=C3=BD <mkoutny@suse.com>
> ---
>  kernel/cgroup/cgroup-v1.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/cgroup/cgroup-v1.c b/kernel/cgroup/cgroup-v1.c
> index 784337694a4be..e28d5f0d20ed0 100644
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -681,11 +681,14 @@ int proc_cgroupstats_show(struct seq_file *m, void =
*v)
>  	 * cgroup_mutex contention.
>  	 */
> =20
> -	for_each_subsys(ss, i)
> +	for_each_subsys(ss, i) {
> +		if (cgroup1_subsys_absent(ss))
> +			continue;
>  		seq_printf(m, "%s\t%d\t%d\t%d\n",
>  			   ss->legacy_name, ss->root->hierarchy_id,
>  			   atomic_read(&ss->root->nr_cgrps),
>  			   cgroup_ssid_enabled(i));
> +	}
> =20
>  	return 0;
>  }

--=20
Ben Hutchings
73.46% of all statistics are made up.

--=-Mdj+QvgzK/UNDkneOc1n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmhus1EACgkQ57/I7JWG
EQlMxg//Zu5qojY6j83XeXXdP+Nfmb6fFI9BIxkDydDpUDo+nVbaocvUlKBmssLq
gT92YpjnemhmsHM9iTlGrMJ7A+PfqmYCUzRGYWHI/grx6GiO/PMxC4Qs5PfMAdRC
SZsldb1qzQWB+8fh0NBwmAOX0UiYyx38yZe3jzz47pCoLAlold4U84x02ayPsvw5
vHCwbCoCwtBFl1mStS0alqPozuLeiJFocONjE4jgyDKCnNv0S5NLwbfdFFbA60nh
WolGPvsTtkUP1HRjXoGnpnNVseb5ZQ9H2d1Z2itvH6/mumnLFttdecJm3QiPg6LG
Npis/j2LIqiR82DpQqg7Yi4H658Roo0j2cN//Gjij/6wET2Mwk4S1AV6Qk3IevJ9
lzqRO7xvTe+VjUvtfhLQYvAlYaIL2oJBL9d6ofTBtIhA+3xdeaRrMRHi5ah55pre
Rq4px/nQAaU9fao8B9HvA/TDYAtCLOmwe12jvjthhuK0crqH4RvhGUD6/sCT2u51
2DNeCeJUyUeGZWEYXhyloeI8x4alJxeGCW0bGhxLj8Im8T95RUNWG+V82QEz9Q5L
l3IHyTEFC/yQeP7yMflCInl4oe8kUFZT4J9fN5Z/wPXN2JYe7QiT/HvtmtQoQQT9
FBNrT4PbC4PW8Cf6WLMnNk620qsg8ErGzsQx00tjMYwVK0VJLug=
=Ws1Z
-----END PGP SIGNATURE-----

--=-Mdj+QvgzK/UNDkneOc1n--

