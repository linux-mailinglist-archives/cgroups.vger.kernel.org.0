Return-Path: <cgroups+bounces-5814-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CAA9ED213
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 966AD166798
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 16:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13B11DD9AC;
	Wed, 11 Dec 2024 16:35:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5B038DE9;
	Wed, 11 Dec 2024 16:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.67.55.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733934904; cv=none; b=c/wVmq5FudZYJyb2v3wl5AppPTnMi2LKTnRrq27YOIPG80uQCk0++hpGk+T4DEzTRBGXZwjXTEwXI0uhqT4GjMAncSyK/GTvNDzJ47KJosF1lnFfrAgACEap4/i7g1zW2/T8gnbuzDtjIqNzr36LBUsDAOTG2T8VPkNcA0LYcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733934904; c=relaxed/simple;
	bh=lXK83SY2csqG5HRslsjcEkHsrb2CoOVYQDZ+nZAVIo8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b8XjNJVe0ATF/LXM05+hM9SYtiUoK3enbQcBTEp0ZyRUNT4iwvGgcZdiVpW9qf8bQTFyb0GArhcW95Sm78wFI1cV8DzlDNs3gFGUGiG05ZtCJm7B1//Rjtuh0/ZkmFSvYJW9OeG4VCLzmfkTkPsVWAZ4A3e5lcYkMFt4UOSZvU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com; spf=pass smtp.mailfrom=shelob.surriel.com; arc=none smtp.client-ip=96.67.55.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=surriel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shelob.surriel.com
Received: from fangorn.home.surriel.com ([10.0.13.7])
	by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <riel@shelob.surriel.com>)
	id 1tLPfa-000000000aJ-3MFM;
	Wed, 11 Dec 2024 11:34:38 -0500
Message-ID: <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
From: Rik van Riel <riel@surriel.com>
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt
 <shakeel.butt@linux.dev>, Muchun Song	 <muchun.song@linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, 	cgroups@vger.kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com,
 Nhat Pham <nphamcs@gmail.com>
Date: Wed, 11 Dec 2024 11:34:38 -0500
In-Reply-To: <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
References: <20241211105336.380cb545@fangorn>
	 <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
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

On Wed, 2024-12-11 at 08:26 -0800, Yosry Ahmed wrote:
> On Wed, Dec 11, 2024 at 7:54=E2=80=AFAM Rik van Riel <riel@surriel.com>
> wrote:
> >=20
> > +++ b/mm/memcontrol.c
> > @@ -5371,6 +5371,15 @@ bool
> > mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!zswap_is_enabled())
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 return true;
> >=20
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Always allow exiting task=
s to push data to swap. A
> > process in
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * the middle of exit cannot=
 get OOM killed, but may need
> > to push
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * uncompressible data to sw=
ap in order to get the cgroup
> > memory
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * use below the limit, and =
make progress with the exit.
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if ((current->flags & PF_EXITING)=
 && memcg =3D=3D
> > mem_cgroup_from_task(current))
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 return true;
> > +
>=20
> I have a few questions:
> (a) If the task is being OOM killed it should be able to charge
> memory
> beyond memory.max, so why do we need to get the usage down below the
> limit?
>=20
If it is a kernel directed memcg OOM kill, that is
true.

However, if the exit comes from somewhere else,
like a userspace oomd kill, we might not hit that
code path.

> Looking at the other thread with Michal, it looks like it's because
> we
> have to go into reclaim first before we get to the point of force
> charging for dying tasks, and we spend too much time in reclaim. Is
> that correct?
>=20
> If that's the case, I am wondering if the real problem is that we
> check=C2=A0 mem_cgroup_zswap_writeback_enabled() too late in the process.
> Reclaim ages the LRUs, isolates pages, unmaps them, allocates swap
> entries, only to realize it cannot swap in swap_writepage().
>=20
> Should we check for this in can_reclaim_anon_pages()? If zswap
> writeback is disabled and we are already at the memcg limit (or zswap
> limit for that matter), we should avoid scanning anon memory to begin
> with. The problem is that if we race with memory being freed we may
> have some extra OOM kills, but I am not sure how common this case
> would be.

However, we don't know until the attempted zswap write
whether the memory is compressible, and whether doing
a bunch of zswap writes will help us bring our memcg
down below its memory.max limit.

>=20
> (b) Should we use mem_cgroup_is_descendant() or mm_match_memcg() in
> case we are reclaiming from an ancestor and we hit the limit of that
> ancestor?
>=20
I don't know if we need or want to reclaim from any
other memcgs than those of the exiting process itself.

A small blast radius seems like it could be desirable,
but I'm open to other ideas :)

> (c) mem_cgroup_from_task() should be called in an RCU read section
> (or
> we need something like rcu_access_point() if we are not dereferencing
> the pointer).
>=20
I'll add this in v2.

--=20
All Rights Reversed.

