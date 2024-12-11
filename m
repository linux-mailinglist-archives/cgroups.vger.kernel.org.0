Return-Path: <cgroups+bounces-5817-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A299ED33D
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 18:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B68931887F0E
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67461DE4EF;
	Wed, 11 Dec 2024 17:20:38 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A2C24634B;
	Wed, 11 Dec 2024 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733937638; cv=none; b=D7Dm+klA5OZnRhWVq2vFPtcQGDYS7xdiTP5W4x8EzAA1hYAo+F/Y7VvfhieNHPwLBklODnEW/mSg9qfsMBNTyRt1uoe+IVOR1f2NZEYTihEuPuv1X1v6/dTzomkXvECTmTreyp9h7nSUiAAhvv6tLqii53s1IT+nme16z8PUn58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733937638; c=relaxed/simple;
	bh=GdZ1DHL5cHABEC8SeDbmRc7vM5/d+eorNKelweENk/c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LEr0aBRu9vFqBCmSD5b4MUGetxMhX5PasD8D9cXp05Ns34SKssowkCHR3al4Fr4MbXM4f8Tm3y1jQBj/4lLHAeoux9ynrTyoi7EE9SSpqgQTZVu6VljMkOwRVbwHDOPNdoqxCDymcf7VX/zf9bDfWKtbxdmU1utJyKI+/Gv9JYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLQNF-0000000015w-1wQM;
	Wed, 11 Dec 2024 12:19:45 -0500
Message-ID: <6bc895883abca3522c9efc0c56189741194581e5.camel@surriel.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Dec 2024 12:19:45 -0500
In-Reply-To: <CAJD7tkYpk4kZChj9f-2EMp0XET6OUNbHqfVBgdFTEMnN+iomww@mail.gmail.com>
References: <20241211105336.380cb545@fangorn>
	 <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
	 <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
	 <CAJD7tkYpk4kZChj9f-2EMp0XET6OUNbHqfVBgdFTEMnN+iomww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Sender: riel@surriel.com

On Wed, 2024-12-11 at 09:00 -0800, Yosry Ahmed wrote:
> On Wed, Dec 11, 2024 at 8:34=E2=80=AFAM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > On Wed, 2024-12-11 at 08:26 -0800, Yosry Ahmed wrote:
> > > On Wed, Dec 11, 2024 at 7:54=E2=80=AFAM Rik van Riel <riel@surriel.co=
m>
> > > wrote:
> > > >=20
> > > > +++ b/mm/memcontrol.c
> > > > @@ -5371,6 +5371,15 @@ bool
> > > > mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!zswap_is_enabled())
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return true;
> > > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Always allow exiting =
tasks to push data to swap. A
> > > > process in
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the middle of exit ca=
nnot get OOM killed, but may
> > > > need
> > > > to push
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressible data t=
o swap in order to get the
> > > > cgroup
> > > > memory
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use below the limit, =
and make progress with the
> > > > exit.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((current->flags & PF_EXIT=
ING) && memcg =3D=3D
> > > > mem_cgroup_from_task(current))
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 return true;
> > > > +
> > >=20
> > > I have a few questions:
> > > (a) If the task is being OOM killed it should be able to charge
> > > memory
> > > beyond memory.max, so why do we need to get the usage down below
> > > the
> > > limit?
> > >=20
> > If it is a kernel directed memcg OOM kill, that is
> > true.
> >=20
> > However, if the exit comes from somewhere else,
> > like a userspace oomd kill, we might not hit that
> > code path.
>=20
> Why do we treat dying tasks differently based on the source of the
> kill?
>=20
Are you saying we should fail allocations for
every dying task, and add a check for PF_EXITING
in here?


        if (unlikely(task_in_memcg_oom(current)))
                goto nomem;


> > However, we don't know until the attempted zswap write
> > whether the memory is compressible, and whether doing
> > a bunch of zswap writes will help us bring our memcg
> > down below its memory.max limit.
>=20
> If we are at memory.max (or memory.zswap.max), we can't compress
> pages
> into zswap anyway, regardless of their compressibility.
>=20
Wait, this is news to me.

This seems like something we should fix, rather
than live with, since compressing the data to
a smaller size could bring us below memory.max.

Is this "cannot compress when at memory.max"
behavior intentional, or just a side effect of
how things happen to be?

Won't the allocations made from zswap_store
ignore the memory.max limit because PF_MEMALLOC
is set?

> > >=20
> > > (b) Should we use mem_cgroup_is_descendant() or mm_match_memcg()
> > > in
> > > case we are reclaiming from an ancestor and we hit the limit of
> > > that
> > > ancestor?
> > >=20
> > I don't know if we need or want to reclaim from any
> > other memcgs than those of the exiting process itself.
> >=20
> > A small blast radius seems like it could be desirable,
> > but I'm open to other ideas :)
>=20
> The exiting process is part of all the ancestor cgroups by the
> hierarchy.
>=20
> If we have the following hierarchy:
> root
> =C2=A0=C2=A0 |
> =C2=A0 A
> =C2=A0=C2=A0 |
> =C2=A0 B
>=20
> Then a process in cgroup B could be getting OOM killed due to hitting
> the limit of A, not B. In which case, reclaiming from A helps us get
> below the limit. We can check if the cgroup is an ancestor and it hit
> its limit, but maybe that's an overkill.

Since we're dealing with a corner case anyway, I
suppose there's no harm using mm_match_cgroup,
which also happens to be cleaner than the code
I have right now.
--=20
All Rights Reversed.

