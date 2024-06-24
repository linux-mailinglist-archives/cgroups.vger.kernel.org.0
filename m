Return-Path: <cgroups+bounces-3313-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF2915743
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 21:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E504A1F2181E
	for <lists+cgroups@lfdr.de>; Mon, 24 Jun 2024 19:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41E61A01C7;
	Mon, 24 Jun 2024 19:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FkyFmVNl"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB121A00D6
	for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257891; cv=none; b=cjo59vmgyP07N4JJzJffHXFERq63h8fp+RYfEl1zyaZ8kopqf9LdDfXMJJIBMPqlvz7kQiSk9/MA2eSAvJ/OMs2lUTa/9HNHsjMtBovV1BC4ktBOSBo/Qq3qWB43fygNjYV6YMmwIwCQ7J8/ehIIJUgrEK/S+5cmw6gFtgStnHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257891; c=relaxed/simple;
	bh=6KWvh6Ar08KHiNHQZJwXg90A0+PoCPg8pkzQX9pNfaU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X9RFVr78uwd/rWPlwfD8F8JICfdocn/8ofa8QwrQybGJ9NeNggCL5/mjI1eSgULrmPIaLz/c6yrKUubGzbNakvLRM4N7r9MxxeDgBx1oLeJNHq16InEHrDsQ8zEASzXAfD5heusLvLM7MKoeLsUS9CzleU+lcxAzYthFBEhY+GQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FkyFmVNl; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso521944166b.0
        for <cgroups@vger.kernel.org>; Mon, 24 Jun 2024 12:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719257888; x=1719862688; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KWvh6Ar08KHiNHQZJwXg90A0+PoCPg8pkzQX9pNfaU=;
        b=FkyFmVNl1exF5JZmxFgVT4wurR5qipZSjGMLhq5+NP2LAT1JTYUnUH6oWNyTfHnwTP
         ZBJDh9qs1SmuQWqBTJvHyeiq2Ls8VvrIb3828p7qeZUE+d92Tbf86J0jm9VHbGVNpxR4
         m5h+OSYpw5LIc0hNz1ONqvbIOYu5iFpiKMIcJRmZV1Zak+AYUmlWUqcvD0o+mtJ5J56P
         zFQhoewaIV5txIUQxEBhAhRwKzSeLHJxBwwZBKOXGx3bz8OPRRVPVOCgEPo8A5OmVBMc
         1A4RlRfzclcclGLxBkYnF/kSsIz9XdMe34O5zFmyMeXHaRO4A+S5OnizcBG2xbpJJ1CC
         Xcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719257888; x=1719862688;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KWvh6Ar08KHiNHQZJwXg90A0+PoCPg8pkzQX9pNfaU=;
        b=CslE6dEIgxUw0n1XD5G1VPfF/hVpGN+LGvUfY6p2RBltZmJWLktiuJTR/SVHzb190T
         NDfy5pUB7WQw55Nd85sBR4FwVCRNiJC1S/Ow4aQ+kXksqozQ1dWLvaG3nu1EiTy+MXgm
         uXFjdpIccDU7EM7Yynwk7Pu5//HzZHwP/R7YwB8gESjRw+Rvc4WBYrl/11ARkiJAY0Ta
         Z3SrIFKnr7VYLhjl0MedWeWqFkBt5UgoyvDS9g1vLS+/nmZ/bu+zFSLZlGOegYQ4u4Ix
         xEYofgEJgFGr68uqBlmPGJqvs8OHvmbuF5y6LALNR10pDzdB3X3Odug8tbFZ/TQtdIn6
         Us6A==
X-Forwarded-Encrypted: i=1; AJvYcCUJg+cGh11HUtJrEIM+IZpqVelL7Us6mTUM9/dPN+n8LN3QqLGFe6KQPttdLjKYsFQxm/z4Ruh6F3XtvPzOHVPDZuOFI757BQ==
X-Gm-Message-State: AOJu0YzlZh+kCvjjiYxrJ4qKKyBpwtTrpIfL24/To/WDkEQuFc6agues
	SQ6U7vM+JCpOX0QLvh8/csHGPGxgRauVmKDgO98y72SHFHs7RyNRiz0xkJCjtaatqQsdJJCKsqo
	A5meCWWOafg9sa24deQoMHPQEe8O+rOIq5R57
X-Google-Smtp-Source: AGHT+IHF9/TR2BFeoREtJbqL7iiT0kIQYsP8YmxY3YVgiJ8zGa3ADbSEdOf7eG4D9vf/IO0pHVLcINZCJQXlcXQDsV8=
X-Received: by 2002:a17:906:ced9:b0:a6f:8265:8f2 with SMTP id
 a640c23a62f3a-a7242cb716emr329469166b.37.1719257887818; Mon, 24 Jun 2024
 12:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171923011608.1500238.3591002573732683639.stgit@firesoul>
 <CAJD7tkbHNvQoPO=8Nubrd5an7_9kSWM=5Wh5H1ZV22WD=oFVMg@mail.gmail.com>
 <tl25itxuzvjxlzliqsvghaa3auzzze6ap26pjdxt6spvhf5oqz@fvc36ntdeg4r>
 <CAJD7tkaKDcG+W+C6Po=_j4HLOYN23rtVnM0jmC077_kkrrq9xA@mail.gmail.com> <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
In-Reply-To: <exnxkjyaslel2jlvvwxlmebtav4m7fszn2qouiciwhuxpomhky@ljkycu67efbx>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Mon, 24 Jun 2024 12:37:30 -0700
Message-ID: <CAJD7tkaJXNfWQtoURyf-YWS7WGPMGEc5qDmZrxhH2+RE-LeEEg@mail.gmail.com>
Subject: Re: [PATCH V2] cgroup/rstat: Avoid thundering herd problem by kswapd
 across NUMA nodes
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 12:29=E2=80=AFPM Shakeel Butt <shakeel.butt@linux.d=
ev> wrote:
>
> On Mon, Jun 24, 2024 at 10:40:48AM GMT, Yosry Ahmed wrote:
> > On Mon, Jun 24, 2024 at 10:32=E2=80=AFAM Shakeel Butt <shakeel.butt@lin=
ux.dev> wrote:
> > >
> > > On Mon, Jun 24, 2024 at 05:46:05AM GMT, Yosry Ahmed wrote:
> > > > On Mon, Jun 24, 2024 at 4:55=E2=80=AFAM Jesper Dangaard Brouer <haw=
k@kernel.org> wrote:
> > > >
> > > [...]
> > > > I am assuming this supersedes your other patch titled "[PATCH RFC]
> > > > cgroup/rstat: avoid thundering herd problem on root cgrp", so I wil=
l
> > > > only respond here.
> > > >
> > > > I have two comments:
> > > > - There is no reason why this should be limited to the root cgroup.=
 We
> > > > can keep track of the cgroup being flushed, and use
> > > > cgroup_is_descendant() to find out if the cgroup we want to flush i=
s a
> > > > descendant of it. We can use a pointer and cmpxchg primitives inste=
ad
> > > > of the atomic here IIUC.
> > > >
> > > > - More importantly, I am not a fan of skipping the flush if there i=
s
> > > > an ongoing one. For all we know, the ongoing flush could have just
> > > > started and the stats have not been flushed yet. This is another
> > > > example of non deterministic behavior that could be difficult to
> > > > debug.
> > >
> > > Even with the flush, there will almost always per-cpu updates which w=
ill
> > > be missed. This can not be fixed unless we block the stats updaters a=
s
> > > well (which is not going to happen). So, we are already ok with this
> > > level of non-determinism. Why skipping flushing would be worse? One m=
ay
> > > argue 'time window is smaller' but this still does not cap the amount=
 of
> > > updates. So, unless there is concrete data that this skipping flushin=
g
> > > is detrimental to the users of stats, I don't see an issue in the
> > > presense of periodic flusher.
> >
> > As you mentioned, the updates that happen during the flush are
> > unavoidable anyway, and the window is small. On the other hand, we
> > should be able to maintain the current behavior that at least all the
> > stat updates that happened *before* the call to cgroup_rstat_flush()
> > are flushed after the call.
> >
> > The main concern here is that the stats read *after* an event occurs
> > should reflect the system state at that time. For example, a proactive
> > reclaimer reading the stats after writing to memory.reclaim should
> > observe the system state after the reclaim operation happened.
>
> What about the in-kernel users like kswapd? I don't see any before or
> after events for the in-kernel users.

The example I can think of off the top of my head is the cache trim
mode scenario I mentioned when discussing your patch (i.e. not
realizing that file memory had already been reclaimed). There is also
a heuristic in zswap that may writeback more (or less) pages that it
should to the swap device if the stats are significantly stale.

I did not take a closer look to find more examples, but I think we
need to respect this condition at least for userspace readers.

