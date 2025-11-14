Return-Path: <cgroups+bounces-11964-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FBC5EBBB
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 19:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82273B6390
	for <lists+cgroups@lfdr.de>; Fri, 14 Nov 2025 17:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6035934678D;
	Fri, 14 Nov 2025 17:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WmsyEZw9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F6325714
	for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 17:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763142991; cv=none; b=CCCoHrbi7ovuJHAEmqOUIfaR4NiollFuGXPK1ksNOcablEd33y9BXc+vW3VlncqKOgfVc+HrRl4pBGqq0KzN86qHGH73tGkz0E6cJPef6Vt9A90zHrDjhotA+4XpHA0QgqyqGuxOjXy2oMVHV9lYtr0TofPAeV241F+smjgP8iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763142991; c=relaxed/simple;
	bh=J3toUTWYN73Bt/9RnHiRASlZ4bD6PeyeukPBqA+0mHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qcmRL1eTXLzs8xIYJXezQ6IJySfouqidgbqzIhRPGlPKuVnoCIiSV4+SgBMwQAX6cRWyqUvNjT77MNVXb/FtEz+W5qdM76uaYF0cJe0KYGTDsCoK+5ZnR5XOWnKj9vclXQW1uGg86f6HQ9e7cPziqTBfKhjndAiGpHia7DRx1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WmsyEZw9; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4775ae77516so25194505e9.1
        for <cgroups@vger.kernel.org>; Fri, 14 Nov 2025 09:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763142987; x=1763747787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/zWQAU6Ma3m+wki4R+pps61nPK17IsTuakpJuoqTYH0=;
        b=WmsyEZw9vgLLkA7sPmmRujaRvALg1jKkTyLtdRZeVXMKqT/b7APyv/GSzJiCrRlYLk
         gTazOzPf7HLCT0vQwv3hBlDjfHnh8pMPbj53jKtT4mBInx8u1hp/W1aeMyEPPhJHgfKk
         dALcVXsKLENL39D4b7uBTy3iAAFrAftkC7jrbkcutJEH1qt46OJuEs/TCnzD1U0cN6fY
         XmVj8S7S/pwQ2+RvyTAcEhDCYECpUf5pWWESmigE/B/EeENxUZNKGJUTGZDXjuP6uIOs
         iwBctOmeYCFxTdC7cDXm1wlIVFpEatKZ0j47A/SlJ3ZqmJPgmtzdFO9mYQXjxq3bbCS1
         q34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763142987; x=1763747787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/zWQAU6Ma3m+wki4R+pps61nPK17IsTuakpJuoqTYH0=;
        b=lm10xo/N3klAO7XX/TLjwU1pPFm/I4N1Z9zor8V4XNZyC/JSdSXFaRgrxwdPRnd5eh
         CSYbL1fx6pOveRRwq8FA4SntbojOCeopZEeiEWg9ScIJX/YP2dKHBpWpr3/aTrudqw9n
         gEy+R7bCX7PCzUp09YviHBD5qLcryfro3g11iH76d5XZNrqezFFR/w1QGHLin930vhzX
         +JBp7d1hiONiE3EnBlwizwxHWdmhQrbIhpvwIOq8XutXolRM/3gmji+dIv9T7CHRNuJu
         hLUZmeavJegAhEbB4OjwBGp8+yPtxwTW9bIMHhBjuTzyoVTkR1ikxoh0jiks0j9DUc1g
         S3ew==
X-Forwarded-Encrypted: i=1; AJvYcCW6XuH13sMqo4ZmucSptQahH77+BHi9cod5EhnLo3yt3S/fGhXha6lRCFNGBqlGB09CYeZV+Tfj@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq5eAMfH7axvYhO2onzFKnc51g/WFtkjuXgk7PB+ypmdhpO2rM
	fISFlGzHeXokn3QFoDKv3Daamj+o/alpAUoUgF6zJfxYGSwvSOkDdDDyN3qd0/90Cq4=
X-Gm-Gg: ASbGnctGZ+1HZ3YamrM7Y7gqjzHFCkGsNDGl5F9QaYoYypXg8Ctoe5dyBgZg0uJRajv
	uEWZAy0r7BTL/mGHZWXT/e7Qsr+gbqHYezHFJ7EPXfzY5GuPicprs4aSRNTWrvihY5pCbm8q2UV
	l0gGr5ZSF9+upUVvBhg8L6IDuztcwBzniMgBLOT8DKC1ohtszBq/GeWJ+WJrpZlTfChroKNF3kp
	o9HgLgIywmhX7HVBwH/9sl8wM+ZFMHzPkxzA+WU8lv9En2PdliV2+issRyHV7DGc5wwBaqWAugz
	6jQe+5dTCNPMDN1rikDKn6duYFX2GQk36u/b7BtR9j/1igNocN5NW1ZHBCcJpxxQuCepMwzrEBC
	n2sIryhTwL2kEnAxOJdgoKTodof4hS2wcCe4Vgmto1rtxGKlbavxzUC4UrxrDaevadSRAplflb7
	E37JA3j1zl/rNhYpUgh+mibcBCM+GZdcg=
X-Google-Smtp-Source: AGHT+IGvkm59trgyj5Gf5HwmmxSfxtaMfLKDTGvS69c4IEPfzONsRFIZ9Nawmf9x3L5Mg+WhWkKDyg==
X-Received: by 2002:a05:600c:4f51:b0:46e:37fe:f0e6 with SMTP id 5b1f17b1804b1-4778fea749fmr45845015e9.30.1763142987125;
        Fri, 14 Nov 2025 09:56:27 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f206e2sm11201352f8f.41.2025.11.14.09.56.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 09:56:26 -0800 (PST)
Date: Fri, 14 Nov 2025 18:56:24 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Qi Zheng <qi.zheng@linux.dev>, muchun.song@linux.dev
Cc: hannes@cmpxchg.org, hughd@google.com, mhocko@suse.com, 
	roman.gushchin@linux.dev, shakeel.butt@linux.dev, david@redhat.com, 
	lorenzo.stoakes@oracle.com, ziy@nvidia.com, harry.yoo@oracle.com, imran.f.khan@oracle.com, 
	kamalesh.babulal@oracle.com, axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	akpm@linux-foundation.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Muchun Song <songmuchun@bytedance.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
Message-ID: <v22vajeyu2cj43euhuomfng27o5c6pvxcohijqmoefovbo6hx3@5yursykhzmxk>
References: <cover.1761658310.git.zhengqi.arch@bytedance.com>
 <44fd54721dfa74941e65a82e03c23d9c0bff9feb.1761658311.git.zhengqi.arch@bytedance.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vp7kuhwwo5mfi7fv"
Content-Disposition: inline
In-Reply-To: <44fd54721dfa74941e65a82e03c23d9c0bff9feb.1761658311.git.zhengqi.arch@bytedance.com>


--vp7kuhwwo5mfi7fv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v1 25/26] mm: memcontrol: eliminate the problem of dying
 memory cgroup for LRU folios
MIME-Version: 1.0

On Tue, Oct 28, 2025 at 09:58:38PM +0800, Qi Zheng <qi.zheng@linux.dev> wro=
te:
> From: Muchun Song <songmuchun@bytedance.com>
>=20
> Pagecache pages are charged at allocation time and hold a reference
> to the original memory cgroup until reclaimed. Depending on memory
> pressure, page sharing patterns between different cgroups and cgroup
> creation/destruction rates, many dying memory cgroups can be pinned
> by pagecache pages, reducing page reclaim efficiency and wasting
> memory. Converting LRU folios and most other raw memory cgroup pins
> to the object cgroup direction can fix this long-living problem.
>=20
> Finally, folio->memcg_data of LRU folios and kmem folios will always
> point to an object cgroup pointer. The folio->memcg_data of slab
> folios will point to an vector of object cgroups.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  include/linux/memcontrol.h |  77 +++++----------
>  mm/memcontrol-v1.c         |  15 +--
>  mm/memcontrol.c            | 189 +++++++++++++++++++++++--------------
>  3 files changed, 150 insertions(+), 131 deletions(-)

(I know it's not only this patch but all the preceding ones, still)
thanks!

Michal

--vp7kuhwwo5mfi7fv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaRdtRRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiOvgEA8/WdRJNOUmjpb/24RVIl
GID3YBbL9hqwcUzr7MBnIckBALfq9W2BMaoRuT47OYa+jpLmvbum3XNZT6HvES04
UQIL
=fGfQ
-----END PGP SIGNATURE-----

--vp7kuhwwo5mfi7fv--

