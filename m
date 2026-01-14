Return-Path: <cgroups+bounces-13174-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 28771D1E346
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 11:47:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EFF6B30708F4
	for <lists+cgroups@lfdr.de>; Wed, 14 Jan 2026 10:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15ACC393DCE;
	Wed, 14 Jan 2026 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GzRKFDjN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688A838BDD4
	for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768387378; cv=none; b=EQa60TtMbjS0u6WPPNOVmvJfCy1s7FEYZHvDn+HrF454zLWKwNMJ1/41UtERZiu5tS2pwdmjTMPkkCNJeynvg7j6HDAVKwiF3qUEc1p69lvuuq6w0MCnKpt1IcUnCLL1yLlt7iEn3dOn4qXUY0pP8YyOBFmbt2amRgR7q77qdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768387378; c=relaxed/simple;
	bh=+vIwBrKzHnkSMHQdsPfaLF3TYnIAbQBfXAzgK5yUmb0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQl8q53qfJp3d0NkfpAQxGm2scVFTNU2N1OnQHvvFzWVtmfewIOGeIxviu1m9jitymev1zoTS4cy1ywUnHzracegmhI5Kfpg/Wx7+/iuWGNMT1XmSDXQU9RGwIgnzrO2jvwOi18ukdjikRPtJhLZSXOBizk/C1s1Y9UnaCuWHZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GzRKFDjN; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42fbc305552so6362360f8f.0
        for <cgroups@vger.kernel.org>; Wed, 14 Jan 2026 02:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1768387376; x=1768992176; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zwfgtP9/g/A15dl8mmuQig8NwUMLjVDzDDzXGmLWXwY=;
        b=GzRKFDjN35wlyA9iD8pEQhxfdRyu1rZnqqNzhs/JXN7Aj4UpmM0VfBVXt+ef0b+W0s
         t2ya8Q3PXXoOM/MfP/y36EZiMoPEVeELPvlUB/PxEpBcJvtvWXFGv/4D3hLEv/9iVevN
         qofbCZVv4AzvwP9cngQW6K4k6GtQ34XPwUo+wnsnCVATknuWrYvsgyL+lttGsXZhO+A9
         mcSUk+nyhsHM5F0deFWwRFGxzgBBRqqw6Elu0uIYiKiXBCJXyj8HN8L/VBPXLm5EiPM6
         P+vhDGOgBV5rNyNgrlOw858P5l0Xsw43V6woh+9R80Mcu4aOz2H7B38vLVU4dO43Pu2Z
         HpwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768387376; x=1768992176;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwfgtP9/g/A15dl8mmuQig8NwUMLjVDzDDzXGmLWXwY=;
        b=U6Hgec1XEx9Eyl8ZhSd/lM/DD9STvxgM1aXxzKmzC+ZfOkxu6OIzpJCoaDRAsgcYLt
         HGh3bSMipoNEJEi90DuFC7M3mdFkCIgT5QJFS4S6W65YkqmWS/lOtqduQDG+PMyLhJsF
         GwRU2u2oHj9XK5uBKaTVYCXhVu+gRykI30xI77HpVh8hDKiSCDLcDeAoqTmJdcoKzhfX
         R5QCC3eGENAzoFQJU1jJcSPoYd1IbygNE4UK3pvpdITBgGmRS1SWqswHjmttY04maRu9
         luZhkKKGMJQ7C0zDJ1Exb3xJW4csNEDDKOjXk33FRl2Jrf5xVBUnaAT56nzSi6FY1fmu
         KVSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZOCNBAOdm46zPSsf2Ka6GCD3QzlLswMHfZ1Bjk3gwgC7WiWI3Kym/seeC8srVfb+zs3p/7iUO@vger.kernel.org
X-Gm-Message-State: AOJu0YxM4VwvDM4X3s8DjySPfJnCA82jlLTqtAyGW8HyeF/T5WkaZRn8
	nLPq0mRl/UeK/Rz0755OVJDPfqtkUh/LUPJeYBK1gAbDZ7FV+ZyjaFO12oCxD4QtQ9s=
X-Gm-Gg: AY/fxX5wpL/liH1Bu/O8sLMxWi2EhlbAor9YkLs2fzOQ2x4IcbwcTBlHoZG0VYuNPJ9
	o66m3Y80zScS1vHn1xO14WjQb+vwIibv2PkE4eSA1c2eJjBoKVKHbfWrsdOvgCid1fjM47i+LZe
	nDFw/lErwq5MWpDMVmS6U8paWIeGi99YjY8NFHOTvMJ0cVEFUb8wuvc0+o6NvM49Jq1Y9aqM8gw
	0+ZaqNo4vUBa5NjYeagVCCS1JpS3P9VzeSoOGn8tmik1eYxkNtcMkMxJOAx3DfTVPw5wedVjNmy
	FgCFc744A6xJU4DT8EeAF0ZtPwrEgSJEAetRIRoGauOkE7T4wfSjHvlujxaGjSP45KRQZn8XK4t
	NnYyzkkOyjVqnjB81mt2p5+yN6hFc9IeXPw4gYBjdQCA4Fv1fgzMYYtmrwI3vweezKsGDNjS82B
	d/W81olQVvEwy8tRerMXQWliwGftuSLbk=
X-Received: by 2002:a05:6000:2c02:b0:432:5bac:391c with SMTP id ffacd0b85a97d-4342c557730mr2244061f8f.52.1768387375721;
        Wed, 14 Jan 2026 02:42:55 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm48998983f8f.18.2026.01.14.02.42.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 02:42:55 -0800 (PST)
Date: Wed, 14 Jan 2026 11:42:53 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zheng Qixing <zhengqixing@huaweicloud.com>
Cc: tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk, 
	yukuai3@huawei.com, hch@infradead.org, cgroups@vger.kernel.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, houtao1@huawei.com, zhengqixing@huawei.com
Subject: Re: [PATCH v2 2/3] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
Message-ID: <mjftw7q6ho6rvxwf3pg2rhu4ivqiys23uaaxfzj5aejx2m7raz@sxbrihmy2waq>
References: <20260113061035.1902522-1-zhengqixing@huaweicloud.com>
 <20260113061035.1902522-3-zhengqixing@huaweicloud.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="do7flgpxj3gdayty"
Content-Disposition: inline
In-Reply-To: <20260113061035.1902522-3-zhengqixing@huaweicloud.com>


--do7flgpxj3gdayty
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/3] blk-cgroup: skip dying blkg in
 blkcg_activate_policy()
MIME-Version: 1.0

On Tue, Jan 13, 2026 at 02:10:34PM +0800, Zheng Qixing <zhengqixing@huaweic=
loud.com> wrote:
> From: Zheng Qixing <zhengqixing@huawei.com>
>=20
> When switching IO schedulers on a block device, blkcg_activate_policy()
> can race with concurrent blkcg deletion, leading to a use-after-free in
> rcu_accelerate_cbs.
>=20
> T1:                               T2:
> 		                  blkg_destroy
>                  		  kill(&blkg->refcnt) // blkg->refcnt=3D1->0
> 				  blkg_release // call_rcu(__blkg_release)
>                                   ...
> 				  blkg_free_workfn
>                                   ->pd_free_fn(pd)
> elv_iosched_store
> elevator_switch
> ...
> iterate blkg list
> blkg_get(blkg) // blkg->refcnt=3D0->1
>                                   list_del_init(&blkg->q_node)
> blkg_put(pinned_blkg) // blkg->refcnt=3D1->0
> blkg_release // call_rcu again
> rcu_accelerate_cbs // uaf
>=20
> Fix this by replacing blkg_get() with blkg_tryget(), which fails if
> the blkg's refcount has already reached zero. If blkg_tryget() fails,
> skip processing this blkg since it's already being destroyed.
>=20
> Link: https://lore.kernel.org/all/20260108014416.3656493-4-zhengqixing@hu=
aweicloud.com/
> Fixes: f1c006f1c685 ("blk-cgroup: synchronize pd_free_fn() from blkg_free=
_workfn() and blkcg_deactivate_policy()")
> Signed-off-by: Zheng Qixing <zhengqixing@huawei.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  block/blk-cgroup.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Michal Koutn=FD <mkoutny@suse.com>

--do7flgpxj3gdayty
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaWdzKxsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AhfAQD/cTBKiAQVDh35CKPtO4Em
OtUUjEzwjwL9m71Op4J5pk0A/0z5/yXz9h8uHXr3hqLQjtCsADUG9ndqsheU7xuN
o9YD
=SA3L
-----END PGP SIGNATURE-----

--do7flgpxj3gdayty--

