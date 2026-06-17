Return-Path: <cgroups+bounces-17038-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0/5MK6UMmqp2QUAu9opvQ
	(envelope-from <cgroups+bounces-17038-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:35:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C33699C30
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 14:35:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=suse.com header.s=google header.b=TKZTu3iv;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17038-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17038-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=suse.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B8E9300CBD0
	for <lists+cgroups@lfdr.de>; Wed, 17 Jun 2026 12:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA27D3B71B4;
	Wed, 17 Jun 2026 12:27:13 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE9143BFAD7
	for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 12:27:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781699233; cv=none; b=o9ttnMS9wJHb1wrdN6xk6L1AyCHk8uAkrrymBswAvpcyWhA6BVCOiYTUv10dyZOxEq9XDHgIR59DQno1m3ybsQAwZZPB06+ZZj8jjlVNQvL/ZtlIzcCZ6L5IGIPTkaKFCDuc0l9F/740momRceSGqLcxZGj00VUdQdtkADgcGh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781699233; c=relaxed/simple;
	bh=4P57JPApK5Duv4SS9/YWY73JFxrYB4MbrvSBwzJXzxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EUGKt7ODikNmiRju6VJdCcSHpOCQISF87keGWW7YgDhXvWoJ3eomCIG64oYhGz7UI5vfXuNAGfZw4tzmHgDTx823vIZWwBY9VZ8/Y6/DGgmrme4/Hvl//0rtxjFKYvpmlVKLg3FzjKfmRmYxfK0WIzcAPdXImoRrVh65atrIpe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TKZTu3iv; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-462bb734793so456918f8f.1
        for <cgroups@vger.kernel.org>; Wed, 17 Jun 2026 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1781699228; x=1782304028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fIkFLHlBYwD2iiV0FJSSocLP/zlZq6rIN3ROwVp13XE=;
        b=TKZTu3ivuCjH0qCjoVkB/l1pXgWZ8BY+PBhzCSRh4hoaHBbwnjTl+vrtleJ4/8oTj8
         Uw2ViuEQTDi0qU5RyGCtlcWVfN0VS6fBQwnj3sUQCMXU2MrTWLlHcgnzSqweGOkz67Uc
         LeoTX82Hwf06xf6O8dt6dQQThaDdBxPlqqcbsmNqlsOJLs3rKyiBN9qVFAsMadtJau1G
         YeOmPpuuWQhczFABUXn00LuDMmyG5OEBfd9D4TIgUrDY5JcggM+7rUcs/CXa3rxt99XH
         /f33pcreFbyXE0ns+018rp86SJQ2qMiGtKhnQSLvFfBZwt5wx8arVi5DbIeAv1qkMNDN
         cMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781699228; x=1782304028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fIkFLHlBYwD2iiV0FJSSocLP/zlZq6rIN3ROwVp13XE=;
        b=AQUHPvW+iSBA90Kuuw96nqCHZ5sDGITnFMC1DWPWEMxye63iJKyUozAmxuNXXK+T9F
         1qB0cYc68PJ/JP9Xb1PqBVkObkw2hW4hBtcEmVBL6AGPYihJk6a6QSFgugragUzc25ir
         kl+cCG0aknP3kfA5eKSK2DnfDfuM+p9livR8BT3wx17FZJOOkqKRJRGueEhD9p4bFPig
         rHwy6A9dRqUn7LJrpCGlvXs9+TN0O4YvA7F1lpLjhCtYKg73krqD/4iT1YHxEDUwvwK/
         QZgKxFz1ojqmGG2nknt/2L34XQBMSc/pttlb6Li8u8G4Ie3GDp6R0cZvxRD1/WnftVq6
         A6eA==
X-Forwarded-Encrypted: i=1; AFNElJ//nR8HAOxdbxmL4R37n5YLkPEoxWJ204SyqRUAtrw740X9g5857ROl5uxrTu4Dvpe04sq77179@vger.kernel.org
X-Gm-Message-State: AOJu0YzQc4on12neNDBzcsV6f7oIXMIjlRBa4VXWlr01ZuQXDkxwtsPJ
	18g/h0pifwtLCwlJr07lSkIgZHBPqD0sgWVWkH9CkWTolC/VeED3/MmKLQReHf/uidA=
X-Gm-Gg: Acq92OGDUfkrFtFnJ/ALJ9rTPaRWm42nRjl1O/Qk/8dVopTIQ5sXOkHu91ytlMkolt5
	DRMLPegnQThH3sv0UCB7oYIqJ5NfRyWuegq+gRMpB11APXiOnnPG6LSjFgPO/yst3GTmGxudUhT
	kCagFzWDmDGJYGb+e88KX3tos1ebclCiTvpNar4jFW5QyJZTWtxGfrNHGOQsa1WyypyL1125/nd
	qveVD/YZ8tX6sxtNyAux6CSRWpJFMcHUQZf4dQFCm6AAQP4jdivOSxhWPw5U8Mo2f8BSwIK68oG
	GvUdN9y+PQYBMy4wGTPc2V5l6zzyumIGofDoBJwg2GTHk1eSmZmeN7WxlCdmwMpqrPNxkrl5R2T
	ePltk86RanVWaqWNuuczP2WJWAVS000HJgWHD2+fmFadLPQ2SpPYwe470rwefML/KzQi1OIirNV
	O6nsrviQSAjoBp6ZvZ3w==
X-Received: by 2002:a05:600c:a30c:b0:490:be1e:6ce6 with SMTP id 5b1f17b1804b1-492333aead6mr55511115e9.9.1781699227889;
        Wed, 17 Jun 2026 05:27:07 -0700 (PDT)
Received: from localhost.localdomain ([62.77.90.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49230a9b45bsm130662975e9.15.2026.06.17.05.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 05:27:07 -0700 (PDT)
Date: Wed, 17 Jun 2026 14:27:05 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Li Wang <li.wang@linux.dev>
Cc: akpm@linux-foundation.org, tj@kernel.org, longman@redhat.com, 
	roman.gushchin@linux.dev, hannes@cmpxchg.org, yosry@kernel.org, jiayuan.chen@linux.dev, 
	nphamcs@gmail.com, chengming.zhou@linux.dev, shuah@kernel.org, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Michal Hocko <mhocko@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH v7 6/8] selftest/cgroup: fix zswap
 test_no_invasive_cgroup_shrink on large pagesize system
Message-ID: <ajKFzxIlwUd79pJY@localhost.localdomain>
References: <20260424040059.12940-1-li.wang@linux.dev>
 <20260424040059.12940-7-li.wang@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="npkgor3mtzc7eyn7"
Content-Disposition: inline
In-Reply-To: <20260424040059.12940-7-li.wang@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[suse.com,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[suse.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,redhat.com,linux.dev,cmpxchg.org,gmail.com,kvack.org,vger.kernel.org,google.com];
	TAGGED_FROM(0.00)[bounces-17038-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[mkoutny@suse.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:li.wang@linux.dev,m:akpm@linux-foundation.org,m:tj@kernel.org,m:longman@redhat.com,m:roman.gushchin@linux.dev,m:hannes@cmpxchg.org,m:yosry@kernel.org,m:jiayuan.chen@linux.dev,m:nphamcs@gmail.com,m:chengming.zhou@linux.dev,m:shuah@kernel.org,m:linux-mm@kvack.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:mhocko@kernel.org,m:muchun.song@linux.dev,m:shakeel.butt@linux.dev,m:yosryahmed@google.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[suse.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,localhost.localdomain:mid,suse.com:dkim,suse.com:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 25C33699C30


--npkgor3mtzc7eyn7
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v7 6/8] selftest/cgroup: fix zswap
 test_no_invasive_cgroup_shrink on large pagesize system
MIME-Version: 1.0

On Fri, Apr 24, 2026 at 12:00:57PM +0800, Li Wang <li.wang@linux.dev> wrote:
> test_no_invasive_cgroup_shrink sets up two cgroups: wb_group, which is
> expected to trigger zswap writeback, and a control group (renamed to
> zw_group),

Aha, it should stand for zswap writeback? Then zwb_group to avoid (my)
confusion with zsw_group :-)

Although the original names were already well descriptive (both groups
are expected to have some zswap).

> which should only have pages sitting in zswap without any
> writeback.
>=20
> There are two problems with the current test:
>=20
> 1) The data patterns are reversed. wb_group uses allocate_bytes(), which
>    writes only a single byte per page =E2=80=94 trivially compressible,
>    especially by zstd =E2=80=94 so compressed pages fit within zswap.max =
and
>    writeback is never triggered. Meanwhile, the control group uses
>    getrandom() to produce hard-to-compress data, but it is the group
>    that does *not* need writeback.
>=20
> 2) The test uses fixed sizes (10K zswap.max, 10MB allocation) that are
>    too small on systems with large PAGE_SIZE (e.g. 64K), failing to
>    build enough memory pressure to trigger writeback reliably.
>=20
> Fix both issues by:
>   - Swapping the data patterns: fill wb_group pages with partially
>     random data (getrandom for page_size/4 bytes) to resist compression
>     and trigger writeback, and fill zw_group pages with simple repeated
>     data to stay compressed in zswap.

I'd have expected that having both equal (i.e. both random to fill up
more easily) is what tests the effect zswap.max upon writeback most
precisely.

>   - Making all size parameters PAGE_SIZE-aware: set allocation size to
>     PAGE_SIZE * 1024, memory.zswap.max to PAGE_SIZE, and memory.max to
>     allocation_size / 2 for both cgroups.

Makes sense.

>   - Allocating memory inline instead of via cg_run() so the pages
>     remain resident throughout the test.

What is the residency good for? (It doesn't matter AFAICS, so the change
seems gratuitous and code diverges from test_zswap_usage().)


--npkgor3mtzc7eyn7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCajKSlRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+AjrLAD9GBYJlDuakfCppd9zM7AV
pVNB8ypWNBY5Zblvu5XqtjwBAP+ZAbviWaThkRKtDNFKUvOG/ItMxC0RjON1YZma
WNkB
=KrLy
-----END PGP SIGNATURE-----

--npkgor3mtzc7eyn7--

