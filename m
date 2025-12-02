Return-Path: <cgroups+bounces-12248-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E3AC9AD63
	for <lists+cgroups@lfdr.de>; Tue, 02 Dec 2025 10:24:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F173A5FFD
	for <lists+cgroups@lfdr.de>; Tue,  2 Dec 2025 09:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A4A30BBA6;
	Tue,  2 Dec 2025 09:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xe7VmHc1"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9483081B1
	for <cgroups@vger.kernel.org>; Tue,  2 Dec 2025 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764667458; cv=none; b=Q51lIbV6kxTqk/n2dukgnv9bk8Ap8xJ7mx2y111tS6/42E1YSeg9NR1uS0z56ZVSmzcLtej2f4hwnxagL2bTJZ8z7djyLUfEoVrBkY/iLdOiBzf9h1HKDpLIbKepPc7gszHoWc0Vr3u/+7siPKMhArOxyO+XQk90JeMS8XdhVHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764667458; c=relaxed/simple;
	bh=qChFaz+qavZxRFTL8KHiCodBH71ndhxe1sfZcodfMh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TNUdnMOq7O5njtZf66jLU0fhrZ5Fsll2l69V02Kv5FiBWPt3JH6JMbG3PiTnyZ1RCeV+748FqAqI5+Kj8+eL8lrlQdhrAK4im243PFha1qvSdQJscSw/tfuwIhL92JqCcZqiogQAgEt9Y+8KmreKtkP8NA9F83n3Lwi6OQoHpWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xe7VmHc1; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-42e2e6aa22fso1170534f8f.2
        for <cgroups@vger.kernel.org>; Tue, 02 Dec 2025 01:24:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1764667453; x=1765272253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N91S9Nht6SbGPGn5zJ6T2Y5cGjPkfPmkAdTz7db9chI=;
        b=Xe7VmHc11jFposkpxCMrTLNJ+YGhavIgbwzGpT3K3vFyWTDtIU1bspETl3Q/ev+vx0
         2vjbenrmv6fj/CczPmsuyBe7d6kPZuDYBPfSVvB1COZJ3K8yHunual4VcnqlnwwtAZHy
         IahZLOquon/Yif/jCT+4yBt9d3GJcozYaGroUR8JAobQgKZd2WgEnX3qV8hhfw6Uuq+V
         HfSD6wvu8iqZ8ZghXs65mxcnXrOJalgKYOTV8khnq2YNAWObzWmWnhvlczRZlHcrbmdr
         FFywLgmDK8GixpkHp5hGwiknDAy5BH+ID2cZ3K0R5d1c+ffjmJ44V6Z9/mgeGL+KucxK
         SRvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764667453; x=1765272253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N91S9Nht6SbGPGn5zJ6T2Y5cGjPkfPmkAdTz7db9chI=;
        b=pQk6VUl4TF2z70P0Cpcy/ap8yIWWHNZPtDENoUCf0onnCiikIQ4wLu5aAryerdYs38
         ppiPdb/5nRtzc3OhpiNZCT9RKgp6hOL3Xw5TPAqxGWMyx9Yym5SerIOpcJNUf5quAwFp
         C7q+C3xvCMpwHUuBnMwsggeYi3dXeO+whahfAIuVw093BTJybCjZQoFkxG5JYJl7ItTe
         lKH5kHm/MzqhgrLbRgo5PGH8kfecHLc4jwBbdlJQQuXMnIwbJEU+/ebTG67Bj7gPTLfh
         /G2MdK/4BJ5zwpDsqVGqH0PO//AJOkGUZ7qBPhxD9YwXAMpWbm9V3XjGmA2TrV3VPihy
         Qt2g==
X-Forwarded-Encrypted: i=1; AJvYcCU4Qtx5UHk0L3a4+2/GUCZuGyscCKGiB0dyOQpYsCFE0xCVOKevJIWosHxEYkJn8aASVRlDNicb@vger.kernel.org
X-Gm-Message-State: AOJu0Ywl9vkq4lc4FCaku0qpMzQTJoz6iQ9D8rRz6OqQo2EF2RBeg/dZ
	zgOBVYbeWl2l7K1xoa/t8UEU2xUug+9q8JSm+dyV6iuyIVskNjBfD4En7PHakztnO1Q=
X-Gm-Gg: ASbGncvaZxnnwCsUmjhcgt0IUACUH9peKykShGjLIF3wj9N6vIJ3x7V75UmvE0/nsF0
	BheTXyry1OELvpv3bScluBdImZX5fVepsh8rtakWGWsUze2bCksIewLY/GZLp81Z+u0OkzJ4Xdd
	JnhkAyIeR/oC2ZUujeLrdub90uzX9imUfwnnhZpDRTtIVPEsXGxSnH6eSiUZwpuf2yvJh/s4u4n
	KytamxHjWnTE/IxBFKRsILevLRIbJ/7iGBhQhbNMfqQXNJoY9SOcnLigA0/XpCCqlf8G7CnLSTr
	gPADg8kgqssJXuOrA2HYWGIDbbUlUvJvUEzrEqw99lZeN2DZ31dN9hbfrgyw0nT/hSvy76HR1I2
	6lxbyyaP0WHZvrLGib28EX+1UHbK7w2Qpeyck7UYPrqWUDjmaBIuYxDMoKsVDul+Xtov1YDjMTd
	RynPoov6x1iTDEPmNxJJKYw85qdgrsPzA=
X-Google-Smtp-Source: AGHT+IHkrMNbp8hJXoEMkZ+SIZoe31wRrWXuCF1y50XcLmwh+HDC7UPLpkaWwjAPpyxx+HljgQinPQ==
X-Received: by 2002:a05:6000:2310:b0:42b:5603:3ce6 with SMTP id ffacd0b85a97d-42e0f213a3cmr30750012f8f.18.1764667453373;
        Tue, 02 Dec 2025 01:24:13 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca8bae9sm30452035f8f.33.2025.12.02.01.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 01:24:12 -0800 (PST)
Date: Tue, 2 Dec 2025 10:24:11 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: tj@kernel.org, hannes@cmpxchg.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, lujialin4@huawei.com, chenridong@huawei.com
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
Message-ID: <nz6urfhwkgigftrovogbwzeqnrsnrnslmxcvpere7bv2im4uho@mdfhkvmpret4>
References: <20251126020825.1511671-1-chenridong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a6dlfxhmnufx3yae"
Content-Disposition: inline
In-Reply-To: <20251126020825.1511671-1-chenridong@huaweicloud.com>


--a6dlfxhmnufx3yae
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH -next] cgroup: Use descriptor table to unify mount flag
 management
MIME-Version: 1.0

Hi Ridong.

On Wed, Nov 26, 2025 at 02:08:25AM +0000, Chen Ridong <chenridong@huaweiclo=
ud.com> wrote:
> From: Chen Ridong <chenridong@huawei.com>
>=20
> The cgroup2 mount flags (e.g. nsdelegate, favordynmods) were previously
> handled via scattered switch-case and conditional checks across
> parameter parsing, flag application, and option display paths. This
> leads to redundant code and increased maintenance cost when adding/removi=
ng
> flags.
>=20
> Introduce a `cgroup_mount_flag_desc` descriptor table to centralize the
> mapping between flag bits, names, and apply functions. Refactor the
> relevant paths to use this table for unified management:
> 1. cgroup2_parse_param: Replace switch-case with table lookup
> 2. apply_cgroup_root_flags: Replace multiple conditionals with table
>    iteration
> 3. cgroup_show_options: Replace hardcoded seq_puts with table-driven outp=
ut
>=20
> No functional change intended, and the mount option output format remains
> compatible with the original implementation.

At first I thought this is worthy but then I ran into the possible
(semantic) overlap with the cgroup2_fs_parameters array (the string
`name`s are duplicated in both :-/), I didn't figure out a way how to
make such an polymorphic array in C (like when cgroup_mount_flag_desc
would be a class that inherits from fs_parameter_spec and you could pass
the array of the formers to consumers (fs_parse()) of latters).

So I'm wondering whether there exists some way to avoid possible
divergence between definitions of the two arrays...

(Below are some notes I had made.)

>=20
> Signed-off-by: Chen Ridong <chenridong@huawei.com>
> ---
>  kernel/cgroup/cgroup.c | 107 +++++++++++++++++++----------------------
>  1 file changed, 49 insertions(+), 58 deletions(-)
>=20
> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
> index e717208cfb18..1e4033d05c29 100644
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -2005,6 +2005,36 @@ static const struct fs_parameter_spec cgroup2_fs_p=
arameters[] =3D {
>  	{}
>  };
> =20
> +struct cgroup_mount_flag_desc {
> +	u64 flag;

This could use an enum for CGROUP_ROOT_* values.
(For readability/convenience.)

> +	const char *name;
> +	void (*apply)(struct cgroup_root *root, u64 bit, bool enable);

I leave up to your discretion whether the cgroup_root should be passed
explicitly (it's always cgrp_dfl_root and existing functions reach to
the symbol already).

> +};
> +
> +static void apply_cgroup_favor_flags(struct cgroup_root *root,
> +					     u64 bit, bool enable)
> +{
> +	return cgroup_favor_dynmods(root, enable);
> +}
> +
> +static void __apply_cgroup_root_flags(struct cgroup_root *root,
> +					      u64 bit, bool enable)

I think double underscore is overkill given `static` and the previous
helper.

> +{
> +	if (enable)
> +		root->flags |=3D bit;
> +	else
> +		root->flags &=3D ~bit;
> +}
> +
> +static const struct cgroup_mount_flag_desc mount_flags_desc[nr__cgroup2_=
params] =3D {
> +{CGRP_ROOT_NS_DELEGATE, "nsdelegate", __apply_cgroup_root_flags},
> +{CGRP_ROOT_FAVOR_DYNMODS, "favordynmods", apply_cgroup_favor_flags},
> +{CGRP_ROOT_MEMORY_LOCAL_EVENTS, "memory_localevents", __apply_cgroup_roo=
t_flags},
> +{CGRP_ROOT_MEMORY_RECURSIVE_PROT, "memory_recursiveprot", __apply_cgroup=
_root_flags},
> +{CGRP_ROOT_MEMORY_HUGETLB_ACCOUNTING, "memory_hugetlb_accounting", __app=
ly_cgroup_root_flags},
> +{CGRP_ROOT_PIDS_LOCAL_EVENTS, "pids_localevents", __apply_cgroup_root_fl=
ags}
> +};

It seems indentation is missing here.
This is actually a specialization of the cgroup2_fs_parameters array...


--a6dlfxhmnufx3yae
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaS6wORsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhqWgEA9mlbpet+EEmemJ1uqZDH
081MKh4e2KDKGtFea4uhTN8A/jPD8Yn6lUO/KZ49u8BpvGov767r9EFIfJrrC18o
/dQG
=PyrG
-----END PGP SIGNATURE-----

--a6dlfxhmnufx3yae--

