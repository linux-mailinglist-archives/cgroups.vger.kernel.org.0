Return-Path: <cgroups+bounces-16209-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJztM0l2EGoZXgYAu9opvQ
	(envelope-from <cgroups+bounces-16209-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 17:29:13 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EF6D5B6E5D
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 17:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BDEF300DF6C
	for <lists+cgroups@lfdr.de>; Fri, 22 May 2026 15:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB9A40C5A3;
	Fri, 22 May 2026 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="frOLufSF"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A436E2BFC7B
	for <cgroups@vger.kernel.org>; Fri, 22 May 2026 15:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463582; cv=none; b=iaDBm/vS0t2qHA6dY1e+7NBm51el9jZOq82o+x4yKdSRkG30AVYajWX3DUNhonMwdbDGJvwbnc8u2yzsTvEfAmCvbapr/UDFIYppVd9NXWDTnYX8C3aKQG/0stsE4CIJhIVSfPtwVyFX0PWkIedG9vWWAVIzwmnxtu+u78aZnb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463582; c=relaxed/simple;
	bh=j3asqpI8gDocPiQLjR114Plzov6j1keIlqNEsz+jjpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1DCbJ4fGYb2rbW5DF0gcEvwJ+tt5ugAGmALvOcJ/uSACyiq2RO2/31dE5Ft2vJIt36fd1yuTM+NHZsLMW4bx8BYZgUg0kVrc/KGVWxE26MlETgEbEGaJ0LWnqOUao3LB9D9vHWnRcDPEjWhuAJbgmpvMWv9ScwLcmZonTHdSrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=frOLufSF; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4904127c32cso8072495e9.2
        for <cgroups@vger.kernel.org>; Fri, 22 May 2026 08:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779463579; x=1780068379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1vEySuvchtiTT5/Luvk9UxfuyTrDBUvQ3fx5cuplJao=;
        b=frOLufSFn6M9m9T+s5hdMx7NvCM4OttOO5BOmqDn17pFqOhJTWA0DrZEaM+oHNiHZM
         iqjkeejV72hcowzoi4bYFuXyll9t2Xb5NpFwBN0cA/CoiArH8VnSFCXGWhXkCWL/YkSq
         pp66NmumIFoWIKZFwP818kVOBqi8osg/x+6w8huwNXdfBVOhNciuer4tl0Rkhx238m0I
         ukO7xLMjkPOC61UgUFso8DOnuB1dEK6XiIa6uJpsrT1ae42YF+bwIgmEMVyj9q2LsP98
         Um7qihWRA57WzR/ZVM2dcnOssFs4slDczpeIPFunbcBBUdoFCHmaOqJKp1nyjjMt3ZNV
         64Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463579; x=1780068379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1vEySuvchtiTT5/Luvk9UxfuyTrDBUvQ3fx5cuplJao=;
        b=NfXoaJMWii24umF7TaqgERBXj0/J6GmPTvofktKnBTYGDO5DZNqfZGpxuXWo5GOCvL
         x1sKBeX5GN6z1l809qqT9S9ef4dzCum0yXHf3fHsK/sJInerPA+HYCIQw8tOnow2siSA
         HYCne73BPkb0zmkGzyUnFTuGOwGyL6q7MYayCnvSNko1/t9+9LCGhqEVIoAZbyPDjxad
         4BXMrEZkraPameP6FuqzsYUgDISnmnEA5afB6CS/Zwgxpi0QlEB3tBxNdRkgOBQCKnXd
         YngDqil4OZa1SN9TCkFEbFzKYHPj7PTNdns4VqCEu9okDVVGzYr4wIR1n8aAmr6WV6ZV
         RCQw==
X-Forwarded-Encrypted: i=1; AFNElJ+7uu/8vG5CIDq+RcgYY1veQjIM/ZhXSDq7rt7Ig260+G21oyfeOt4+3m6h2QvGDijJWFl745kv@vger.kernel.org
X-Gm-Message-State: AOJu0YyyWWxM7CU0S6Lt92c36HlQl8GE8HD8ee+ndyY05QSHbKD2LWe4
	WCWl9f4y9UVXbCU8KlgdZSQVjiuIG3T9IKQHgA8mF5RtzOqtwbcdFHSksM+BncWwFFc=
X-Gm-Gg: Acq92OEh1nlAEQS5ARZkvUSqKjoQeV5p+uOo37rYbnxukLaXkE6uXT3ilbGxlCSDK1u
	nUGJTCyi3M23b4BMclPrwUTCfi+x6zylN/TmCAnc/xWPuTVawT6Q5gVeQhyrsOj3e1ut+eksJHi
	hfgpHCxuf0GKYZxZztA/ChnTEjR2txZahFDJ5iaNSs25vyMOBLfHSWOdRGkO58GRoCSBjCyxqIi
	6DZTAcEAWjFiNpl+SRz0nnzOl/MB31SBZvEjLwS8E1dD4rfuEXDRm9hl5anRopY7jHFyk1iQxuk
	vN32rlgJp798FmCwPQFkQ3hWlFZlQpyoEz8rWMdZdEYoE9f9Lfq+do3AY78ugwqIYUkE+dRK7g7
	81YQdQHGM/shhGgTE1uEQTAF/EqsxZGo95WqDbWrAjs8ZpF8hYqBW/wyBawwRp5Ed+xU3cLvDlK
	tka0TgdgGIrZejEXGOhRacSw1VFj1AoB5Fn5+Yy3v+2SmrczngxSq92av8w8w=
X-Received: by 2002:a05:600c:4ecc:b0:48a:56de:d62a with SMTP id 5b1f17b1804b1-490424b3c7fmr53184145e9.11.1779463579036;
        Fri, 22 May 2026 08:26:19 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454a0b82sm53694435e9.9.2026.05.22.08.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 08:26:18 -0700 (PDT)
Date: Fri, 22 May 2026 17:26:16 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Maarten Lankhorst <dev@lankhorst.se>, Maxime Ripard <mripard@kernel.org>, 
	Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"T.J. Mercier" <tjmercier@google.com>, Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
	Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
	Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
Message-ID: <ahBxB5a9sX9DEWvl@localhost.localdomain>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="af2hel7jza3hmfqp"
Content-Disposition: inline
In-Reply-To: <20260519-cgroup-dmem-memcg-double-charge-v2-2-db4d1407062b@redhat.com>
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16209-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[cmpxchg.org,kernel.org,linux.dev,linux-foundation.org,lankhorst.se,gmx.de,lwn.net,linuxfoundation.org,vger.kernel.org,kvack.org,lists.freedesktop.org,google.com,amd.com,redhat.com,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim,localhost.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7EF6D5B6E5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--af2hel7jza3hmfqp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] cgroup/dmem: add dmem.memcg control file for
 double-charging to memcg
MIME-Version: 1.0

Hello Eric.

On Tue, May 19, 2026 at 11:59:02AM -0400, Eric Chanudet <echanude@redhat.co=
m> wrote:
> Add a root-only cgroupfs file "dmem.memcg" that lets an administrator
> configure whether allocations in a dmem region should also be charged to
> the memory controller.

This kinda makes sense as it is not unlike io.cost.* device
configurators.

Just for my better understanding -- will there be a space for userspace
to switch this? (No charged dmem allocations happen before responsible
userspace runs, so that the attribute remains unlocked.)

(I'm rather indifferent about the actual double charging/non-charging
matter.)


>=20
> To handle inheritance, dmem adds a depends_on the memory controller,
> unless MEMCG isn't configured in.
>=20
> Double-charging is disabled by default. Once a charge is attempted, the
> setting is locked to prevent inconsistent accounting by a small 4-state
> machine (off, on, locked off, locked on).
>=20
> The memcg to charge is derived from the pool's cgroup, since the pool
> holds a reference to the dmem cgroup state that keeps the cgroup alive
> until it gets uncharged.
>=20
> Signed-off-by: Eric Chanudet <echanude@redhat.com>
> ---
>  Documentation/admin-guide/cgroup-v2.rst |  23 +++++
>  kernel/cgroup/dmem.c                    | 158 ++++++++++++++++++++++++++=
+++++-
>  2 files changed, 178 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admi=
n-guide/cgroup-v2.rst
> index 6efd0095ed995b1550317662bc1b56c7a7f3db23..1d2fa55ddf0faa17baa916a89=
14d3033e8e42359 100644
> --- a/Documentation/admin-guide/cgroup-v2.rst
> +++ b/Documentation/admin-guide/cgroup-v2.rst
> @@ -2828,6 +2828,29 @@ DMEM Interface Files
>  	  drm/0000:03:00.0/vram0 12550144
>  	  drm/0000:03:00.0/stolen 8650752
> =20
> +  dmem.memcg
> +	A readwrite nested-keyed file that exists only on the root
> +	cgroup.

Strictly speaking this is not nested-keyed but flat keyed [1],
which leads me to realization that this is the first instance of a boolean.
All in call, such a composition comes to my mind (latter is RO):

	drm/0000:03:00.0/vram0 enable=3D0|1 locked=3D0|1




> +static ssize_t dmem_cgroup_memcg_write(struct kernfs_open_file *of, char=
 *buf,
> +				       size_t nbytes, loff_t off)
> +{
> +	while (buf) {
> +		struct dmem_cgroup_region *region;
> +		char *options, *name;
> +		bool flag;
> +
> +		options =3D buf;
> +		buf =3D strchr(buf, '\n');
> +		if (buf)
> +			*buf++ =3D '\0';

I recall there was a discussion about accepting only a single device per
write(2) (at the same time I see this idiom is still present in other
dmem.* files, so this is nothing to change in _this_ patch).

Thanks,
Michal

[1] https://www.kernel.org/doc/html/latest/admin-guide/cgroup-v2.html#format

--af2hel7jza3hmfqp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCahB1lBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AhJyQEA4ebIAV+4wgYjb7Cax+hS
43nEgrk4mA0GQOKjivEd/KMA/A581miemqm16N6I0lzKn9Fm64QJ/G5K9t45IDQW
dr8L
=9Z82
-----END PGP SIGNATURE-----

--af2hel7jza3hmfqp--

