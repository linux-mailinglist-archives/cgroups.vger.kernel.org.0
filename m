Return-Path: <cgroups+bounces-17560-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7jGTBq3qTGovsAEAu9opvQ
	(envelope-from <cgroups+bounces-17560-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 14:01:49 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2471B2D1
	for <lists+cgroups@lfdr.de>; Tue, 07 Jul 2026 14:01:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=Ovf3ok1t;
	dmarc=pass (policy=quarantine) header.from=suse.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17560-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17560-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7876330005BB
	for <lists+cgroups@lfdr.de>; Tue,  7 Jul 2026 12:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7C83FB7C1;
	Tue,  7 Jul 2026 12:01:39 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70CB3FB07A
	for <cgroups@vger.kernel.org>; Tue,  7 Jul 2026 12:01:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783425699; cv=none; b=Lb/afIHxpuLVndRGpdKbmSoTBSSViaL/d6GXRTIsV2v+Htt6Xyscv3VxpuswlOWO/47W9HsSW17DW7f2RqUyAajY8t1lIIFwudaWa9EecNL2LYVSPyAxpuJNUzBlXINIUBfUCpP8VRjVYKcQ4mhdqeisXcUPW+p7mre1NrZe3eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783425699; c=relaxed/simple;
	bh=/8GUkb5deBcpAM3zS7bUZUXYwSqR4M6QK/IwDpzwj60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHoyqIehg7g5Lj9++/nSIkmPnT9uNw9XF86liXjsQfoJWooR13V4yRSdaYVMCuiA57VpWTQRMJjTZ9yUik6IPr2BywZfgtbFNmKFJwAnR2B+snl/I3KV7b4HEQCaE++wu8AsanSPCCKlhkYNISchsGRmbdY69zdGPz+RUr+PDWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ovf3ok1t; arc=none smtp.client-ip=209.85.128.41
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-493c00f74baso25747315e9.0
        for <cgroups@vger.kernel.org>; Tue, 07 Jul 2026 05:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783425696; x=1784030496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2foD8/m5jsx3KDxdM1AXAhJaa/uPNeOmtxQBIkqM8nk=;
        b=Ovf3ok1t7gVBe80wsLEjTuo3DgGqyi/DXr4UQhWI4DK2bkjClmH4+pm+2RmBOMk0ow
         KUl6UcVQAqd3d4IzcNbDM3VOek+jvB+maiS8e2q/RYmkXtypKIj5OdTVbIs+6AdHAStB
         huEIkoHs7/w42DD7qa/qSsKr2MfLsQjQFMWCjJxKWr+hTI7XXr6fwSYzwVM9sH0NKHHP
         D4HD29nh/PxwCAyiBEuLIMPWby8OzY1J3XY8s9djumhxmAFYcswmy30tFggRfHlZ+Xg7
         72D49KoSa7Pnwkqk1Fp7Mu5YqhAKixjqGs0WLLolGdNluGEaAmQ94lEFnMxwkJrRKQxp
         CIzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783425696; x=1784030496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2foD8/m5jsx3KDxdM1AXAhJaa/uPNeOmtxQBIkqM8nk=;
        b=RT+AMw7Ch9zZklxzBS4Zr43zN3sO1i/X77+OulWTrW80IEKlq3Ylw2asd3b/1nkUxm
         E0cAKH4tu54i1J0UB1ryl7iIkVpVYMje8xnAtUAX5CosjcRKOm71tok2Lo5+PPGnW3FG
         1bLbACG8e0t0vEKizakkiswYS97hqwigt7bdQ3PnIjRdSlzaCfVL7or8/Jr7P2KwlFS8
         XF5/zGqPNXp79BCImAfqncuFXaxh95RQmp3iuiZWRfAKzbUPLGjB64TazMETge6uPFcp
         xJPlqdAVOQITCCy3/2W6ltvbjD9+uA2zr7Ud3cjJvQb1DiTllgWwnJ/ylbRLzGjXDLa1
         eOZg==
X-Forwarded-Encrypted: i=1; AHgh+RpsirK+BRn+KdsU6JXQmFgw0AqzxeLyDscxlni4v4saYRXHBxPIxM0jaH1ZIdLSMiCHY7xSr6Ad@vger.kernel.org
X-Gm-Message-State: AOJu0YwPFKZwN5P+DxalgqclqGQRJbTpP5JxQb9x/9wZlDeC9QhozPEO
	HvDS53HiIh3s3uMgsbNFbyaALgkJ6CXcvvVMYZU82n+Etxehc5u8dFcO0kPZ4FT5IahylhAHwYP
	nW93bAo4=
X-Gm-Gg: AfdE7cmkKAKDu84XFJmDluqvVcD9RHx+r1oif/gM7wq2NoEdScR2Uq/IifBmXPPqAAu
	mBGhg2D0r0X2nHatOqcx6FDJCyiwasegTt8SVHeu2ttgQ6Og5FqOa1trtHgk4Z/GssjjEKA0q7+
	vCXO1b23IWsYG6IZ6yD/lJimjALGC/bRkrlQn38weQSyeB7iOk6ig23Mj7DvwFV2n6p08HoRzbd
	Eu38vjsQSNlxOMt1WBYQA0Gp5huO3l3ld27bdV00jZYaHWTikkESc6YcxSM+iuy9/Zc7beqGkK/
	7ZINPspVBdmWsWUHkVrmZu4BvL9M5e09oiXAVwIVMafYQh4hrWIZqtCyASF1413Yg3NgRNzT1Em
	8hzQWKOss4McULv1m6pLhzsrjomhr2g3QQMhcqEyLma42nBd5nMEa7JB/ybWFKG1dtXSrMmxlRk
	A+oD8fmtemXcPXT/LC1v9yp8T8+wi/O1eKYOAyYQ==
X-Received: by 2002:a05:600c:3b01:b0:493:b91c:6bf with SMTP id 5b1f17b1804b1-493df0a74c1mr48992425e9.18.1783425696112;
        Tue, 07 Jul 2026 05:01:36 -0700 (PDT)
Received: from localhost.localdomain (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm32347941f8f.23.2026.07.07.05.01.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 05:01:35 -0700 (PDT)
Date: Tue, 7 Jul 2026 14:01:33 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Zenghui Yu <zenghui.yu@linux.dev>
Cc: linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, hannes@cmpxchg.org, 
	yosry@kernel.org, nphamcs@gmail.com, chengming.zhou@linux.dev, tj@kernel.org, 
	Shuah Khan <shuah@kernel.org>, mhocko@kernel.org, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Li Wang <li.wang@linux.dev>
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
Message-ID: <akzpi93tZry0cCCe@localhost.localdomain>
References: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="n32fxil2i3lu57lp"
Content-Disposition: inline
In-Reply-To: <c0970cee-42c2-4844-b88e-229853f08e90@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17560-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,cmpxchg.org,kernel.org,gmail.com,linux.dev,linux-foundation.org];
	FORGED_RECIPIENTS(0.00)[m:zenghui.yu@linux.dev,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:tj@kernel.org,m:shuah@kernel.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:akpm@linux-foundation.org,m:li.wang@linux.dev,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RSPAMD_URIBL_FAIL(0.00)[suse.com:query timed out,linux.dev:query timed out];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	MISSING_XM_UA(0.00)[];
	RSPAMD_EMAILBL_FAIL(0.00)[cgroups@vger.kernel.org:query timed out];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:from_mime,suse.com:dkim,localhost.localdomain:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52F2471B2D1


--n32fxil2i3lu57lp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: cgroup/test_zswap failed with "zswpout does not increase after
 test program"
MIME-Version: 1.0

Hello Zenghui.

On Tue, Jul 07, 2026 at 05:38:13PM +0800, Zenghui Yu <zenghui.yu@linux.dev>=
 wrote:
> Hi,
>=20
> Running cgroup/test_zswap on my arm64 box failed immediately with:
>=20
>   [root@localhost cgroup]# ./test_zswap=20
>   TAP version 13
>   1..8
>   # zswpout does not increase after test program
>   not ok 1 test_zswap_usage
>   [...]

What version of the tests do you run?
Namely, does it have the recent patches from Li [1]?

Thanks,
Michal

[1] 83476cc97bc63 ("Merge tag 'cgroup-for-7.2' of git://git.kernel.org/pub/=
scm/linux/kernel/git/tj/cgroup") v7.2-rc1~136

--n32fxil2i3lu57lp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCakzqcRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjPxQD/TSp3AgFunXblm/wv+t06
iUtOKzzPQFXPcFo4roUGy6UBAPI9Y58AN6NvZtotdqoeb85Dry7/rdwq9AfzhNfP
8pEH
=dE8U
-----END PGP SIGNATURE-----

--n32fxil2i3lu57lp--

