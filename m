Return-Path: <cgroups+bounces-17039-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MHpRBveUMmq32QUAu9opvQ
	(envelope-from <cgroups+bounces-17039-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:37:11 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A55EE699C5A
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:37:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b="gUe/ai7P";
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17039-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17039-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D1C632385F2
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7756E3C1404;
	Wed, 17 Jun 2026 12:28:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD53D9049
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:28:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699315; cv=none; b=nZl7gDK1EGPHURK//SStbK0f7rRxpcEMG0lpEZk5MO5tiIV42ktHtOi0scZh0klyGMjYosoXU7MnI8xwIeDJBXJM/qcs4ajspHN3cnGqkAr7xmdwPexHpxz0e8kjg0t3szTLhewsupHzYhv3Ui/2sn8udGAJeiDvhaWwDuPZi8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699315; c=relaxed/simple;
	bh=KdBoKWDASaJZcB8nsJefnRNH1Bw/c7zkoLeSLSrghWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFdOp2V67no7oxi5FU8x4QkqcWzIIodV6OGM4xU/ENFS9ViL+6ccKLKhRvY/uqgUpGDmGd2Xp4moLTkPdZ4GypjZAcIeg3+hmzO8vMbDqwd5NVpzl9lEn460E3pwcDHgCiFGB87WKwlFihmGPOuRS0bJK30vw4QAN9IQ9b5Oq3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gUe/ai7P; arc=none smtp.client-ip=209.85.128.48
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4923139e940so10911495e9.3
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699312; x=1782304112; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM5qR7HnQsV8ihoP5sIjvhIawDKg/qrSVM0NHkgkEXQ=;
        b=gUe/ai7P3AYkIhI4hobkAJTpgSYK4m2N7PUpwlrdre2EwW+Yi4GKGUQutbOfGVBwBY
         nmxqSoalQ7nd40QMfjETk7qI4SP8d7YtSzR18Q9P280m2FrhDN8YoElCUsdpx77AfTq4
         HIIy5VoFDNNBUVRTDUfWNOilEwHZs7y9aSTJXNrs6myHx09Jx9RHJbfczQUIUSFMUgo/
         ThP5e9/+6Fb87VI0OdlEG6+xkP4g4Tj1PaHOFbwR6/vabp8+ma62bJqDtJmUd5/By5IO
         31BEQhIzpHilkJMZyEjibDOYqla4W0rPGiKDTzJh07Vhq0lY96hZ/m0vveK3OYjpcSdg
         hFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699312; x=1782304112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MM5qR7HnQsV8ihoP5sIjvhIawDKg/qrSVM0NHkgkEXQ=;
        b=s1QBQ2YtARDNU0tgFiyeCWplDrIGqaS2wBWOJLcjjCaBx9BMrkdDq/X6JQ1FjF7aa5
         5dXgjQ9xj6ebgpWYf4dIP8OLJTo5P0ZVXf9DACmYvHpxEbBkuAG0+PLsdCQM4dviu4Mi
         /qZjkflfUkNWncDkjcoIg6GSpDXVFtGYT7SAMiumNh5CfP5S+gyGg2KI3GkK03PYPfuG
         WlMiBC/AKF4E+3ncGKIG+xZzorxmJh+IVnDg2Fe71Eec8TQ+x7mo5ECyUmi7J7J5NXeW
         0uoXGU1g+0REzIOYTRhCjKYtQ2zShud7ERCPTvU6xlOUmCGW3mbwH717gHHbFsGManF8
         tJpg==
X-Forwarded-Encrypted: i=1; AFNElJ/jWTSEhjBIEI52dyK94jjVnP8up9d/xQ4L2HeFsA3kH64i8kM+ukZiZ17N4Ms2fphHruSRCJH2@vger.kernel.org
X-Gm-Message-State: AOJu0YwFuoY3Y5Sa3E4taJ4Gioz/6bVM8XomyYvmBzPHTiPmb0aqRMn8
	Cm2uKV1iEb6DFTDnvAdBUBEZrDYR7pzhJ25a185kIDe7c1fSfQ5VHBwq1Dy1b1qQwyo=
X-Gm-Gg: Acq92OHYqZKb/cFfPBEtL7fiIL6tPiXD4SZ4XygIbC9n9l5GVe11d3CcGzAaVNvryfN
	HoXmlsJK8t7or1zLXyuYSmqYGVByyQHai/8dUjhN1+ZpXKwLVWmasu839ifiCNghbX8ow4bqFzD
	hpKFVbI6vofiLj4bhrTbUSfE8QnqZqZ9AXn0ikpDol8VCq01EsDkHM9C1Gm+F8IXzAh714QG4BS
	+Rr+VrGVpawJ2Y6ZeH0ooORAAQltZjZF4WHRaVpknkjlYEiZuTrDqyF9ryug+E9fYHdy/7MzVt6
	bhoMPsrMzfoZZQhkTWFj2VG5/V2O9elu48NklX5FmA6AVjA6aYN+0u2kawYK2OsvWtDcMmSEflB
	n/sd10wsgBLSItpSPn+ualjKGcgHNn5QS+ZLKdYQP2uVfMLb8GLldPv3NswnXZqz1xmfpzhXahF
	aS81fWPuYO7piRvU0xyg==
X-Received: by 2002:a05:600c:4644:b0:490:9d1b:f06a with SMTP id 5b1f17b1804b1-4923410388dmr30618225e9.10.1781699311826;
        Wed, 17 Jun 2026 05:28:31 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa891acsm160948085e9.9.2026.06.17.05.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:28:31 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:28:29 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>, tj@kernel.org
Cc: akpm@linux-foundation.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] selftests/cgroup: improve zswap tests robustness
 and support large page sizes
Message-ID: <ajKSrZ5xBAj8lquy@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4yjtviewjv7h5rrp"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-1-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,redhat.com,linux.dev,cmpxchg.org,kernel.org,gmail.com,kvack.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-17039-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:tj@kernel.org,m:akpm@linux-foundation.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A55EE699C5A


--4yjtviewjv7h5rrp
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 0/8] selftests/cgroup: improve zswap tests robustness
 and support large page sizes
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:51PM +0800, Li Wang <li.wang@linux.dev> wrote:
> This patchset aims to fix various spurious failures and improve the overa=
ll
> robustness of the cgroup zswap selftests.
>=20
> The primary motivation is to make the tests compatible with architectures
> that use non-4K page sizes (such as 64K on ppc64le and arm64). Currently,
> the tests rely heavily on hardcoded 4K page sizes and fixed memory limits.
> On 64K page size systems, these hardcoded values lead to sub-page granula=
rity
> accesses, incorrect page count calculations, and insufficient memory pres=
sure
> to trigger zswap writeback, ultimately causing the tests to fail.
>=20
> Additionally, this series addresses OOM kills occurring in test_swapin_no=
zswap
> by dynamically scaling memory limits, and prevents spurious test failures
> when zswap is built into the kernel but globally disabled.
>=20
> Changes in v7:
>   Replace my work email by li.wang@linux.dev address.
>   Add Acked-by: Nhat Pham <nphamcs@gmail.com> to series.
>   Rebase to the latest branch (only one tiny conflict resolved).

I think the patches from the series where I had no special remarks can
be applied already (and base next (smaller) series on that).

Michal

--4yjtviewjv7h5rrp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKS6RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AiRWwD7B006DcY0x2F+2Sbw4j8K
IZEESihg3ZPEkA+MdYeum5cA/24UUIQFp9j85Oa50uzT0iUVL6FumNyKNhH7lGIv
0IkF
=0L1g
-----END PGP SIGNATURE-----

--4yjtviewjv7h5rrp--

