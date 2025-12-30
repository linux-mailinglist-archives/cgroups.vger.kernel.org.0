Return-Path: <cgroups+bounces-12819-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A20CE98E9
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 12:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9BC63300A2BD
	for <lists+cgroups@lfdr.de>; Tue, 30 Dec 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 672F82E22AB;
	Tue, 30 Dec 2025 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="A69EoqBG"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BFD41EDA2C
	for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767094676; cv=none; b=TO/XT24ZmCynXfG8VLJmRDoUgCXJPO3xFpQl8kebms+111MqL52Da/7w353qupkrJbcpN2vyZ5rCY4pb6E5XW68dGNhY5RcUCIFWbl8Y14rwyoOPHi4ZLHQfeMcceFSrP2c4SbIL3GYAQ4ygJ1xmMze9z/s0pnpiShrNZqevdFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767094676; c=relaxed/simple;
	bh=UJDUXFl2mVrnG3eZmeq94vuEqX37qoK1hJd2NkAyfOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WCkGNuYr9TmaS02HGuJT4NA0/Ucr84FrBHKuOIrIDENQu3ZHf/zuASxVJez2AnGX9UYFNHZRLAr+94XQ1FYTMgteRhnzf90JiLax1i2TYzqvGp2ijD0RABeX0HGULlnqxjV71CKPxjVIlquewxxLniqjB62SlSNjN7jcB43Anvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=A69EoqBG; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso79967095e9.3
        for <cgroups@vger.kernel.org>; Tue, 30 Dec 2025 03:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1767094672; x=1767699472; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Jq/YWcpAHyrHKvdGDEz/0WDZdNHmowQop97a+xcOpM=;
        b=A69EoqBGwS0+D4HRGWZwkiKbp3plqNg5aSi6Rp35uLvnVqBA5RK7sYWF0+Pg+cuJAH
         Pz54cfptGOzqJTEgi4biSn6c+QFb8yNtsLOWLwzsP7bMkW3hsK5DMm5k8fhfppVX0d2g
         EzTavl6gZaLwx0+S16ZcE7QBlx39PlFtB555zJ+xeKPvO0qsb5zR5HrabFn1I3c6uozC
         mt7GloqZJgjM3EJAsveXxnwL1qWcYOOrET0VH0jlGaYodz2nEmYzbiALha8swLl1K6Fu
         PPYt6oNy944mO3nAidXfBHgqroamzeMBhnlxO9lj1LzYqs1w1/NfIaFv4OslnNwG/5M1
         op3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767094672; x=1767699472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Jq/YWcpAHyrHKvdGDEz/0WDZdNHmowQop97a+xcOpM=;
        b=U2arCzkQOY+I6ixcir1wFOCcRB96R1ExXo9qtIO413dGwE9qqjOoW3v7DG3YnGE77q
         K6gB726o5xzFx9baD5r3tA22gZnPvH5uMpZtRUu5Cm9g4ZaY7VDlqrTRRinpMTCKMIIV
         00bUNjmpvthaa23l3CblFsS3EBrmBY/6EfjjMpSwa0aWITynb/ViO3/8Dn5JeS6wp1iG
         O+kNWvDV1ILKaSP9P9aDTvdT+H8UiSGP/4dSyZog0fR6nS4DvegJW7wn21FjV3OFoa9x
         d6gYgQHlyp3rYRWVMLKRuCnLuk7sBHxL6NnPdhXWo1oRB68Bvj79LwITBztKrZdmJbnO
         Bupg==
X-Forwarded-Encrypted: i=1; AJvYcCXBAZ8agwISFzOkzxQF/Mp9UGxDO1IMcr2jhDZL1KCrIxxoh00ax3B2LF653ij9V+u5OPfLi6+f@vger.kernel.org
X-Gm-Message-State: AOJu0YxoQ3NGVoIcoO9PW6MI87ZyMVJfkznkoUK6tx3ZskBN1Xj6rOGP
	ucOdwajCNxmnvE04G5f/jcUrD0f4Swr9wV3UyuOvrLL/iG7qhDAgBzEUO1uICPLcjJA=
X-Gm-Gg: AY/fxX6+pcVOAKF2uKx+XZUyZsYlDRDCI/QPQdRJgCVTWi1vFtnbA8twxM4hatkqOzv
	CYEMpZxTN8EK4ebLTtPBA/6W+FwBaq2gkx0MiLL7JwzhD7j4Iod5XpspvoxyE5olT0Jrye0wCwR
	HET0XTv+0GwGftfgc6mq9zdhCrH1fTZ5HSWzb2eaKOjNVpURWVcSHt1Ahq7JwiqZ4pOIoUgO6A7
	fF+/IM+te2iJi9ylhHfNDa7DXWT1DOn/b/jrF/xfSjRXJB3asMKufQLgQJEoXo6oG7Ms/bRJnRj
	yFktrJL+7vHXbJVKMFkbw77cygmqinnW9GvS3xuYvIDFYQSmoc7LzuzdmgwfQof7x4vnlRAqcyQ
	K4tByoTJDQ196A5FCWjVkhOixZcpoX2x76Vbbmjqxu8os12Dvico5SnI9H1XkuVQsfS22weFv+B
	rQRN+YIOeyb6+vb82WcyKc9O37QQy+w30=
X-Google-Smtp-Source: AGHT+IH/ALRIJgngfCVn447K6XVqJGY6ztCi6Hrq9Ox/xoemMijWPuk9J62Uy2/IxZdGfgS/5p3HdA==
X-Received: by 2002:a05:600c:3e18:b0:46e:1fb7:a1b3 with SMTP id 5b1f17b1804b1-47d4e6fc0f1mr156751285e9.23.1767094672378;
        Tue, 30 Dec 2025 03:37:52 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be26a81b6sm662176195e9.0.2025.12.30.03.37.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:37:51 -0800 (PST)
Date: Tue, 30 Dec 2025 12:37:50 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: linux-mm@kvack.org, Jiayuan Chen <jiayuan.chen@shopee.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/memcg: scale memory.high penalty based on refault
 recency
Message-ID: <4txrfjc5lqkmydmsesfq3l5drmzdio6pkmtfb64sk3ld6bwkhs@w4dkn76s4dbo>
References: <20251229033957.296257-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="uwgqa4sz6s6dsalx"
Content-Disposition: inline
In-Reply-To: <20251229033957.296257-1-jiayuan.chen@linux.dev>


--uwgqa4sz6s6dsalx
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2] mm/memcg: scale memory.high penalty based on refault
 recency
MIME-Version: 1.0

Hello Jiayuan.

On Mon, Dec 29, 2025 at 11:39:55AM +0800, Jiayuan Chen <jiayuan.chen@linux.=
dev> wrote:
<snip>
> Users are forced to combine memory.high with io.max as a workaround,
> but this is:
> - The wrong abstraction level (memory policy shouldn't require IO tuning)
> - Hard to configure correctly across different storage devices
> - Unintuitive for users who only want memory control

I'd say the need for IO control is as designed, not a workaround. When
you apply control on one type of resource it may manifest by increased
consumption of another like in communicating vessels. (Johannes may
explain in better.)

IIUC, the injection of extra refaul_penalty slows down the thrashing
task and in effect reduces the excessive IO.
Na=C3=AFvely thinking, wouldn't it have same effect if memory.high was
lowered (to start high throttling earlier)?

<snip>
> This happens because memory.high penalty is currently based solely on
> the overage amount, not the actual impact of that overage:
>=20
> 1. A memcg over memory.high reclaiming cold/unused pages
>    =E2=86=92 minimal system impact, light penalty is appropriate
>=20
> 2. A memcg over memory.high with hot pages being continuously
>    reclaimed and refaulted =E2=86=92 severe IO pressure, needs heavy pena=
lty
>=20
> Both cases receive identical penalties today.

(If you want to avoid IO control,) the latter case indicates the memcg's
memory.high is underprovisioned given its needs, so the solution would
be to increase the memory.high (this sounds more natural than the
opposite conjecture above). In theory (don't quote me on that), it
should be visible in PSI since the latter case would accumulate more
stalls than the former, so the cases could be treated accordingly.


> Solution
> --------
> Incorporate refault recency into the penalty calculation. If a refault
> occurred recently when memory.high is triggered, it indicates active
> thrashing and warrants additional throttling.

I find it little inconsistent that IO induced by memory.high would have
this refault scaling but IO by principially equal memory.max could still
grow unlimited :-/

>=20
> Why not use refault counters directly?
> - Refault statistics (WORKINGSET_REFAULT_*) are aggregated periodically,
>   not available in real-time for accurate delta calculation
> - Calling mem_cgroup_flush_stats() on every charge would be prohibitively
>   expensive in the hot path
> - Due to readahead, the same refault count can represent vastly different
>   IO loads, making counter-based estimation unreliable
>=20
> The timestamp-based approach is:
> - O(1) cost: single timestamp read and comparison
> - Self-calibrating: penalty scales naturally with refault frequency

Can you explain whether this would work universally?
IIUC, you measure frequency per memcg but the scaling is applied
per task, so I imagine there is discrepancy for multi task (process)
workloads.

Regards,
Michal

--uwgqa4sz6s6dsalx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaVO5ixsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AiyFQD/ei6EZorHB/tmtb+SAqVc
bnAhT9k9zviy0M2zfuXDRkMA/jd7o6cfA/S3bGwo7fO+QBFKf0X3xEhY4FL6v8xk
yIUD
=9lXp
-----END PGP SIGNATURE-----

--uwgqa4sz6s6dsalx--

