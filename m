Return-Path: <cgroups+bounces-5816-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 768209ED300
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 18:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82693188B2A5
	for <lists+cgroups@lfdr.de>; Wed, 11 Dec 2024 17:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBDFB1DDC11;
	Wed, 11 Dec 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paYsb7ic"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E743F17BEC6
	for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733936480; cv=none; b=bp5uRbyxlMMOmIvHonZsIJv+HxphqBJMI1Za7HtiZrq/NqGBXdofbjCny+L8bDE4Lyq3vlgo90wI/p9pjr+KDjXX/a66twlSmQ1EKMNQ/6l0lcZ4nraenytKV5tYTeU+63TAs1vzH03Shry0gOBwgBXVzLM2G8160GB+jdvu0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733936480; c=relaxed/simple;
	bh=/ZbyPvlmWHc3e07gfoe3MkLTRtGvzbwhy3G+ln2u+LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=db0V5CQbpNw4G7FP5hgK5f8qJl92vLfBMk0H0/WW4JegEXQ9vLFVbuZvRVdj44KnrRS/B6YK2jwLED/8dU4bCh+3sC0n5G6hhzxYpCiZjSI0TE1tb4W3jsrDs9dCUaG9K8O9cx1BaEPB7R078PIRjfJ+JvovYkWeoGm7cfyf7X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paYsb7ic; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7b6f19a6c04so18611485a.0
        for <cgroups@vger.kernel.org>; Wed, 11 Dec 2024 09:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733936478; x=1734541278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DWR8Jat9HqWQD4tgYwKhNycvduSOkRomQGq1rzYJLCw=;
        b=paYsb7ic3ZgFlwB5YtYMpxRFJmB/U/JRNzPti21jXHQ8JpkKVxL2mXiWaprmpweDsI
         ehbH9yEThqwTG8yz2iMYW5TBiLozRPM1aNrHZW2zltj3TLEgeyIoVbkCpKXmAVj1mqJV
         tjW1CbE71fJpqg/9WY2cGTCSCaMn1Ds5RZAdNulLUV8YcrseAxh3xnxs2mWFqnDrKroS
         uKKvgFph1dAmRrv5vaKm4Dlgf17O6vA6bhQwc4qllLeaHMH+DpOXaWr/BnZNV4xlKkUq
         RxkHqc18SZIwuLmINMKyLEAcmVP9tDkfkf8Hmkadp8KQjKntOxnJcONJbJOfjshtsB2x
         IZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733936478; x=1734541278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DWR8Jat9HqWQD4tgYwKhNycvduSOkRomQGq1rzYJLCw=;
        b=kpjxljX9vKc9MXOt+bjpUkkLsOmzihutZBbsD+CMtwi7JT3owFMNMKWWim93UGnyX1
         4z7VX6HsKvO5vs+3DHvwBf+nBs0hmfac6M1bfbHbhB95RtxVysEzSPkLZgfxnLX9y0GK
         oj125I5T9ryM/zXNCW0EWgkbFEE7UHuMpkchZlECanqLr8oC/Kb8lELHxeg6snAeIJoz
         hHu1K9GrP0wLEht7lZxxs+oYmfzg6dryASKY9gdnvOpMvfM3E4Lr0v/1M/XRO3/qPb84
         7/X0ob4woNxFuI+0Y7aRD1pJi73Am+yDYDfZC9HdG5o0MFyooKA8L5qw/PI5oFa466Cb
         VBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIptJedbi06/pC6Tz9reeiCGdBsyXLNb9AwwtzflXOr5J5tMqngUt+YljET0uIz1mhXLyzvXyt@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8M0lldFWRsVeCk1wjE3JVKh+ds2y98334zVgOl0p8zHZeceYp
	VDPuGLo1TOPgcKLYg2OLge8UuPxEr8UCnrKCNv2tkKHsQHlvD5zCC2DY0Mgc2HLecxzQSBMpJlw
	Pv8s5HDpKIwVd9anFyEl1W0fAzxZRnFbiCT+j
X-Gm-Gg: ASbGncvmeqY3kQyfRxLK+TpQidPnnXEDoOxqHp8XoMj4kNimmrV1KIPYme/bKV8If/O
	pgST3iAUMDtIw1O0yL3x6zPjxPKmUsB5w
X-Google-Smtp-Source: AGHT+IGpw/zsckT4h9+kIHBMmJKYloAZQjEK4AQAEQl8yxWUFUcCtydY97rkPoueLrkZMwCwaCVxH/io1qSKn8f+tas=
X-Received: by 2002:a05:6214:b6d:b0:6d8:b3a7:759e with SMTP id
 6a1803df08f44-6d934c10eb0mr49278136d6.46.1733936477556; Wed, 11 Dec 2024
 09:01:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241211105336.380cb545@fangorn> <CAJD7tkboc5a4MDHvF7K4zx5WP0DE4rsGW_24s16Hx+Vvy2RQLQ@mail.gmail.com>
 <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
In-Reply-To: <768a404c6f951e09c4bfc93c84ee1553aa139068.camel@surriel.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Wed, 11 Dec 2024 09:00:41 -0800
X-Gm-Features: AbW1kvYHmQoq0lrIhLl4tU96ViOyzQC6VHiYAXY8dGp-cFK14P1Q9i_02Qg3ru8
Message-ID: <CAJD7tkYpk4kZChj9f-2EMp0XET6OUNbHqfVBgdFTEMnN+iomww@mail.gmail.com>
Subject: Re: [PATCH] memcg: allow exiting tasks to write back data to swap
To: Rik van Riel <riel@surriel.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	cgroups@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 11, 2024 at 8:34=E2=80=AFAM Rik van Riel <riel@surriel.com> wro=
te:
>
> On Wed, 2024-12-11 at 08:26 -0800, Yosry Ahmed wrote:
> > On Wed, Dec 11, 2024 at 7:54=E2=80=AFAM Rik van Riel <riel@surriel.com>
> > wrote:
> > >
> > > +++ b/mm/memcontrol.c
> > > @@ -5371,6 +5371,15 @@ bool
> > > mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> > >         if (!zswap_is_enabled())
> > >                 return true;
> > >
> > > +       /*
> > > +        * Always allow exiting tasks to push data to swap. A
> > > process in
> > > +        * the middle of exit cannot get OOM killed, but may need
> > > to push
> > > +        * uncompressible data to swap in order to get the cgroup
> > > memory
> > > +        * use below the limit, and make progress with the exit.
> > > +        */
> > > +       if ((current->flags & PF_EXITING) && memcg =3D=3D
> > > mem_cgroup_from_task(current))
> > > +               return true;
> > > +
> >
> > I have a few questions:
> > (a) If the task is being OOM killed it should be able to charge
> > memory
> > beyond memory.max, so why do we need to get the usage down below the
> > limit?
> >
> If it is a kernel directed memcg OOM kill, that is
> true.
>
> However, if the exit comes from somewhere else,
> like a userspace oomd kill, we might not hit that
> code path.

Why do we treat dying tasks differently based on the source of the kill?

>
> > Looking at the other thread with Michal, it looks like it's because
> > we
> > have to go into reclaim first before we get to the point of force
> > charging for dying tasks, and we spend too much time in reclaim. Is
> > that correct?
> >
> > If that's the case, I am wondering if the real problem is that we
> > check  mem_cgroup_zswap_writeback_enabled() too late in the process.
> > Reclaim ages the LRUs, isolates pages, unmaps them, allocates swap
> > entries, only to realize it cannot swap in swap_writepage().
> >
> > Should we check for this in can_reclaim_anon_pages()? If zswap
> > writeback is disabled and we are already at the memcg limit (or zswap
> > limit for that matter), we should avoid scanning anon memory to begin
> > with. The problem is that if we race with memory being freed we may
> > have some extra OOM kills, but I am not sure how common this case
> > would be.
>
> However, we don't know until the attempted zswap write
> whether the memory is compressible, and whether doing
> a bunch of zswap writes will help us bring our memcg
> down below its memory.max limit.

If we are at memory.max (or memory.zswap.max), we can't compress pages
into zswap anyway, regardless of their compressibility.

So what I am saying is, if we are already at the limit (pages cannot
go into zswap), and writeback is disabled (pages cannot go into
swapfiles), then we should probably avoid scanning the anon LRUs and
spending all those wasted cycles trying to isolate, unmap, and reclaim
them only to fail at the last step.

>
> >
> > (b) Should we use mem_cgroup_is_descendant() or mm_match_memcg() in
> > case we are reclaiming from an ancestor and we hit the limit of that
> > ancestor?
> >
> I don't know if we need or want to reclaim from any
> other memcgs than those of the exiting process itself.
>
> A small blast radius seems like it could be desirable,
> but I'm open to other ideas :)

The exiting process is part of all the ancestor cgroups by the hierarchy.

If we have the following hierarchy:
root
   |
  A
   |
  B

Then a process in cgroup B could be getting OOM killed due to hitting
the limit of A, not B. In which case, reclaiming from A helps us get
below the limit. We can check if the cgroup is an ancestor and it hit
its limit, but maybe that's an overkill.

>
> > (c) mem_cgroup_from_task() should be called in an RCU read section
> > (or
> > we need something like rcu_access_point() if we are not dereferencing
> > the pointer).
> >
> I'll add this in v2.
>
> --
> All Rights Reversed.

