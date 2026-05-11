Return-Path: <cgroups+bounces-15757-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBzGFbHUAWryjwEAu9opvQ
	(envelope-from <cgroups+bounces-15757-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:08:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3776050E8FC
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 15:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D25DD30184E3
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 13:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A543DDDA9;
	Mon, 11 May 2026 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="cPqtpnCG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DA13DA7F0
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778504586; cv=none; b=RMwc/IHRI88NrOxVTaRlwNbLai3xqrA/l8zVYj/zTItNn1fs4a0SptZ+ZfJfC7glLmEzMFC40wC6em5Q6Rnc24udxC8V5tWEdOCQVouX9v1KA44WTECm14zaM1sYHTPowi7ZwREX/jjOXkd9krrYZ0DE56mxsy99Gztam6P0K2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778504586; c=relaxed/simple;
	bh=x4n+alJNf1wutc9hvHLxsSeg5QHkFtRN1PEGdBHElIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UXatFjE5SrU1xc+1q5zD/T1mKoTMy5PYBjiRqmP2VwM/bIrNq3YdDofs0WZgSdh53iPsjEkmVMxSytrAZmHuMN6hlx5AT6lAuVRXiugl4cYBS0kvsdZlRGrOTuIEOAEKHL3BtsAiNQ1A6VK6dh4u7JD7u5Mgc5Dew4OD6QQzUv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=cPqtpnCG; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44ccbd3290aso3395609f8f.2
        for <cgroups@vger.kernel.org>; Mon, 11 May 2026 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1778504583; x=1779109383; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cxhetvbt5aC7n/fJp1v/wYxNwfJm1Klb1mbxzE4ftzI=;
        b=cPqtpnCG94gRkRZQmjwfgkomSJKrQ4OfVZVzBIWjUdRcaR8VqLuTFT6/1Cm4UH/p4q
         koSGENlcPOoBwMKb4ZLaGMvMm7o7sXxlV0W1liDXkIPkz0jdXCBN4fxh27X3pwY5v9/z
         TuXy/pOUOGPb3UOZnbbNMgaH9Z/IHx9Y/iYF3IWgvO0zdlxs7qiIgsejQZwlwl5VxU4h
         Teafsdd06DQPrQpURARAj6Wswr7vqF4LDJhF6ArVI3Sh9l2wy7inzNktVUFx9wctvERe
         ZrWlzovGwxkrKxTMijXsEzlmrkJfhMTG06rBYt3mefD33t7Q0Uth30nxSIS6h26llqrS
         KHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778504583; x=1779109383;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cxhetvbt5aC7n/fJp1v/wYxNwfJm1Klb1mbxzE4ftzI=;
        b=GPz003e4Ri4wPjyNLs5K/Md84pU7F5nJN/tCmrEA9MeWaBRGoswbnUAhx/ZDhRbcb7
         ea+CF3GT0eB1hc00IK+5YpRudsdhaI3SLZknR0A31UHcc2JLvhl2wU+PRjDHUfJSP812
         zc1wqTwsguhVK6+HTPH0PXxa9TF54c/eTNaJpJYhwBY7JP/kfKLI6srBb9TGitrzjX1B
         ZUb/WKCSgcalpUgQQrOOK3lAr2fehAbLuNDhYGRvx5iqGNFUNteAOrKeUU7B4wsTHwxn
         KPsvFtJoIc1Miy7OYnzMmK9ZASqReb5DRAnQJk6ecoK+hSNPf62kh6jDyWrbATL2pwZc
         QbNA==
X-Forwarded-Encrypted: i=1; AFNElJ8W1KJMDj6Pvfx6tQ3L8s0KIoSM37sH7K4P0JXyHrwV/egSthu+FooX0XFjxRwe7UGcqc3GFg/w@vger.kernel.org
X-Gm-Message-State: AOJu0YzweHt444oCn2b9cqc6//pkWofL5m8TknymIQS+oWXKYEH2JjTg
	gYcgzDRcUaGRNK92GdBsQDx7+180sfppdaet5odhqGWsSupWF8zdCpcQr/KW5DLF43U=
X-Gm-Gg: Acq92OGO9l4H3K8Kq2eQPQzXOYOpowEcPTLPPNm/nbcqSAXgUloygqm1b8tlNTOJbxZ
	yhPufZFyTwQCv8ra+y49Vql9HCmNh6QqJ2kwavAfqj5PGF0IT5hE6lIk7mJ1Enx+a7vAYJGoYd+
	XfXHqoQhZxmHNRmPmJEhK6+siSvJmR5C8eGtNc/frwlxbWzrGI5jarM6NaGMTDwt/5NYilIO7Ew
	m69qHChk1H0rA/lCNZq6nACBhuB9Vf2nILZnpLqJ9HEXOkwI+r4+Cjf0vRsHs/8Eo29pQdj5veq
	lyhaI88Aq0/xHhLe6Kkqx9upfHBd/nD175tTMtse15C6W7LLb+yZ/8VHiEv2yVkhfItbxWYcFGf
	vcvdmMjTudjLSlV3iUhczDK7hoH0K5GsVXhSLnMYW7KCgGYYXrQwsXEQWqzPkgdacsL/6vDIi2X
	a88lSYQdn1d6XImAZUkxRk+Cje8lbJ7OUA11zzPloka6maC+oh
X-Received: by 2002:a05:6000:4203:b0:441:1fa5:457e with SMTP id ffacd0b85a97d-4515b61a4b9mr36482771f8f.13.1778504582762;
        Mon, 11 May 2026 06:03:02 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4549120eb95sm24633058f8f.20.2026.05.11.06.03.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 06:03:02 -0700 (PDT)
Date: Mon, 11 May 2026 15:03:00 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Maarten Lankhorst <dev@lankhorst.se>, 
	Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>, Tejun Heo <tj@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
Message-ID: <agHRj-idlMvSgB-O@localhost.localdomain>
References: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6uinpelgye7jcdhk"
Content-Disposition: inline
In-Reply-To: <20260511013150.7235-1-zhangguopeng@kylinos.cn>
X-Rspamd-Queue-Id: 3776050E8FC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[suse.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15757-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[lankhorst.se,kernel.org,gmx.de,cmpxchg.org,vger.kernel.org,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,kylinos.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.com:dkim]
X-Rspamd-Action: no action


--6uinpelgye7jcdhk
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] cgroup/dmem: return -ENOMEM on failed pool preallocation
MIME-Version: 1.0

On Mon, May 11, 2026 at 09:31:50AM +0800, Guopeng Zhang <zhangguopeng@kylin=
os.cn> wrote:
> get_cg_pool_unlocked() handles allocation failures under dmemcg_lock by
> dropping the lock, preallocating a pool with GFP_KERNEL, and retrying the
> locked lookup and creation path.
>=20
> If the fallback allocation fails too, pool remains NULL. Since the loop
> condition is while (!pool), the function can keep retrying instead of
> propagating the allocation failure to the caller.

This implies that it's OK when the function keeps retrying with
allocpool !=3D NULL (and repeated WARN_ON()s)?

> Set pool to ERR_PTR(-ENOMEM) when the fallback allocation fails so the
> loop exits through the existing common return path. The callers already
> handle ERR_PTR() from get_cg_pool_unlocked(), so this restores the
> expected error path.

If the callers can handle it, maybe there's no need to retry at all.
Perhpas dmem fellows can step in here.

>=20
> Fixes: b168ed458dde ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Signed-off-by: Guopeng Zhang <zhangguopeng@kylinos.cn>
> ---
>  kernel/cgroup/dmem.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f271..4753a67d0f0f 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -602,6 +602,7 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct =
dmem_cgroup_region *region)
>  				pool =3D NULL;

This 2nd pool zeroing seems pointless.

>  				continue;
>  			}
> +			pool =3D ERR_PTR(-ENOMEM);
>  		}
>  	}


HTH,
Michal

--6uinpelgye7jcdhk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCagHTgBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AgqmwEA5wxJxSP0xvsQWLhF6DF6
/dRYA2b3b0PxB8id+ffvCxABAJ76IV2uz63OS6i6C7A39HK9vC4KPqs7EQ8Gzz2K
YGwJ
=8kDw
-----END PGP SIGNATURE-----

--6uinpelgye7jcdhk--

