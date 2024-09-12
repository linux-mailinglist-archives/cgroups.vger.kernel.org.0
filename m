Return-Path: <cgroups+bounces-4862-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D72C976ED4
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 18:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B96B1F22B00
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE2D18732B;
	Thu, 12 Sep 2024 16:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vhV80Pif"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5F6126BE2
	for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 16:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158936; cv=none; b=a8+/nFXhyQM/3OYsXDm8N7Fj4Uhsjn1/mu9wxTArLuRcWRA+9S6nkoTT3t9IFRO2hWBWE8/x0uvMOZrWc3UB6TYFX7e2ewaLJpEQLIAVJIMAIceX/lCkzH7utOoeE/UuDueR2BNHubKGXAJYp2EtBGsP5nU6MnJMPZujlQnvb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158936; c=relaxed/simple;
	bh=WYu+xq7+UmmQf6tUX7l9OJFcpWz8QtQPNxlo5qmQdXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbKrYpvlRy2JNgmMPg6TrjVOBexX+3yaKh/YSXjCoH/+0rM6i8qvcWkTy87hbgSLsGZvDvW2JIB5se/MF3dVCfPobdp6xquaZl+RBB0vR4MR6bOlu3msMvJy5tR0JDQ9NdrnDBzsDl8P4CpH5x5Zs9opmhPkoGmKTeVrwiaGJJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vhV80Pif; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c4146c7d5dso1353507a12.3
        for <cgroups@vger.kernel.org>; Thu, 12 Sep 2024 09:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726158933; x=1726763733; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEVUvvG1KmX1Ra9d8MhbpcG7EMxrmMhoef191BfBjSw=;
        b=vhV80PifMd3V6T5muWdMLI7qXGujWvNj/NCCkJ34Me+Yqv/8/BPsot68vvjmh9GFai
         WfaKcm90UN4TeohptAljsj4jI1chAlBzun+uX/vAUek6m2RnFJ1UKRqnC+hnEApy+5qv
         s/R6/5PLKVy0D9gFk4RsLHBc3lJKTdqw+w6tiOyKRbN5rxsfZBp27B89aa7Kiew0Hpqn
         JiorHjkM48olkqRo8O09Ef/NUxVrg6PmRnADsw6zQfQk4zY8qD4EJcHJseU9RB7eon2m
         2LAnwacLWY9gXhEYLExGwScVqC7rK3pr/jsGpQM+9NNqfglMeadAKmo8JyKytuidksd7
         cGgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726158933; x=1726763733;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEVUvvG1KmX1Ra9d8MhbpcG7EMxrmMhoef191BfBjSw=;
        b=le8EdyCEVm35HtS1gz+4M6eF5pOAaLs8ccMwJUUoiYCGrwDLS9SOIQuyGIzk+1xBpG
         97t9MAOz8goWC9DjAs1LHpXl3kNDknLnwAsuGdpYyRr0CKZc6NdGg1U/SbCeVtw9peCF
         Gxs96i1bWH2mpH4pRpA9f6ysrY73UcuFhDzUl3Gj1K6IslEoqSZvxmCJgljGHSW5U+lm
         eZuDMcfn/W3EtLtoUauDY8z/tzgGokw6F1uMsyvPJ8XpyhRJsdBDNqOkw4stEbzACrG+
         HZ17CWY6XHCt0j5aFO0wXx73itUDDGiYrGdh9uEghcTxh+7L3uHv1+5Vot2hDXrPx+9M
         xRDQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/LpPDf0KRs0eyuDwxNmwcJEnjee4UaHDeetGJrX6MuQebsQB6OuvIymXdQpp4WJUuLSzS5/FQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3nPRWhcPtz6f0sNYXuAO9CJNe7PcGb0dxrNmsYz2qYb4Dp0JS
	6U/F0Oc80fCZUOC9IkSEyyT0xUgrdOSV59LQWKvBOWpdD54F6vNr9DjxlTw8CQTu1UpSYP5WyUd
	QvO77XfxntzcszpzYVzw0HKJsy1fzlAEEof8u
X-Google-Smtp-Source: AGHT+IGI7m76/LA64GipDBeubzsm690oF6m54ARaFG68ADy3ndZrFU0qgn8wLThA9VxGlQ7C8CyVbCvFEHoiZts1nes=
X-Received: by 2002:a17:906:6a29:b0:a89:ffd0:352f with SMTP id
 a640c23a62f3a-a902960abcbmr347873766b.48.1726158931902; Thu, 12 Sep 2024
 09:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org>
In-Reply-To: <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 12 Sep 2024 09:34:54 -0700
Message-ID: <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	mfleming@cloudflare.com, Nhat Pham <nphamcs@gmail.com>
Content-Type: text/plain; charset="UTF-8"

>
> [..]
> >>
> >> My userspace readers (of /sys/fs/cgroup/*/*/memory.stat) are primarily
> >> cadvisor and systemd, which doesn't need this accuracy.
> >>
> >> Can you explain your userspace use-case that need this accuracy?
> >
> >
> > Please look at the commit log of this patch [1] that removed
> > stats_flush_ongoing (the one in Fixes).
> >
> > [1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/
> >
>
> I think I understand the inaccuracy concern now.  So, it is the 2 second
> periodic flush that is the concern.  That can cause up-to 2 seconds old
> data to be read by userspace, when read contend with ongoing root
> flusher (if it doesn't wait for the flush).  I agree, that 2 sec old
> data is too inaccurate.

Yeah and it's not just the delay, it's also the fact that you may read
the stats *after* an event (e.g. proactive reclaim or memory usage
spike), and get the stats from *before* the event. This leads to wrong
decisions being made by userspace.

>
>
> I'm coding V11 that will "wait_for_flush" in the userspace call paths.

I'd rather we keep the flushers consistent to avoid complexity if
possible (i.e. if Shakeel's patch works for you). But if that's the
only way going forward maybe that's what we need for now.. I will wait
to see the code.

[..]
>
>
> I like the idea of eliminate all in-kernel flushers.
> Until someone works on that I will use my patch in production as I need
> to fix the production issues ASAP.

I took a brief look at the ones in the reclaim path and I don't think
they are easy to remove tbh. Maybe MGLRU will become the default soon
and they naturally go away (MGLRU does not have these flushes).

[..]
>
> >
> > If it takes one kswapd thread 24 ms to flush the stats, then that's
> > the raw flush time. If all 12 kswapd threads started at different
> > times they would all spend 24 ms flushing anyway, so waiting for the
> > ongoing flusher is not a regression or a newly introduced delay. The
> > ongoing flusher mechanism rather tries to optimize this by avoiding
> > the lock contention and waiting for the ongoing flusher rather than
> > competing on the lock and redoing some of the work.
> >
>
> We are observing kswapd isn't running "fast-enough" in production (e.g.
> when packet process using GFP_ATOMIC alloc are starting to fail).  Thus,
> I really don't want to delay 11 other kswapd threads, by waiting on a
> flush, I really prefer to skip the flush, such that they can do the much
> needed memory reclaim work.

That's one more reason I think maybe this needs to be handled in the
reclaim path. I do not think other flushers relate to this situation.
It would be nice if we can just skip the flush in the reclaim path
under these circumstances.

>
> >>
> >>
> >> I need remind people that "completely skipping the flush" due to ongoing
> >> flusher have worked well for us before kernel v6.8 (before commit
> >> 7d7ef0a4686a). So, I really don't see skipping the flush, when there is
> >> an ongoing flusher is that controversial.
> >
> >
> > Skipping the flush was introduced in v5.15 as part of aa48e47e3906
> > ("memcg: infrastructure to flush memcg stats"). Before then, reading
> > the stats from userspace was as accurate as possible. When we moved to
> > a kernel with that commit we noticed the regression. So it wasn't
> > always the case that userspace reads were inaccurate or did not flush.
> >>
> >> I think it is controversial to *wait* for the ongoing flusher as that
> >> IMHO defeats the whole purpose of having an ongoing flusher...
> >
> >
> > The point of having an ongoing flusher is to avoid reacquiring the
> > lock after they are done, and checking all the percpu trees again for
> > updates, which would be a waste of work and unnecessary contention on
> > the lock. It's definitely an improvement over directly competing over
> > the lock, yet it doesn't sacrifice accuracy.
> >
> >>
> >> then we could just have a normal mutex lock if we want to wait.
> >
> >
> > I am not against using a mutex as I mentioned before. If there are
> > concerns about priority inversions we can add a timeout as we
> > discussed. The ongoing flusher mechanism is similar in principle to a
> > mutex, the advantage is that whoever holds the lock does not sleep, so
> > it gets the flush done faster and waiters wake up faster.
> >
>
> My plan is to lower contention on this rstat lock "enough" (e.g. with
> this patch), which should make it safer to switch to a mutex.

Do we know that switching to a mutex in the current state is
problematic? If the only concern is priority inversion then a timeout
should work.

Also, I don't think a mutex will help your case of kswapd not running
fast enough, right?

[..]
>
>
> >>
> >> It is not only the flush in the kswapd path that concerns me.
> >> My other concern is userspace cadvisor that periodically reads ALL the
> >> .stat files on the system and creates flush spikes (every minute).  When
> >> advisor collides with root-cgroup flush (either 2 sec periodic or
> >> kswapd) then bad interactions happens in prod.
> >
> >
> > I believe the problem here is the kswapd flushers competing with
> > cadvisor userspace read. I don't think the periodic flusher that runs
> > every 2s colliding with the cadvisor reader that runs every minute
> > would really cause a problem. Also both of these paths should not be
> > latency sensitive anyway. So again, Shakeel's patch should help here.
> >
> > Did you check if Shakeel's patch fixes your problem?
> >
>
> I will also try out Shakeel's patch. This will hide the specific
> contention issue until something starves the kthread that does the
> periodic 2 second flush (for 2 periods). In production we are seeing
> kthreads getting starved longer than 20 seconds.  This often happens in
> connection with OOM killer. This recreates the kswapd lock contention
> situation at a very unfortunate point in time.  Thus, it makes sense to
> have this ongoing flusher lock contention protection in place.

Yeah we may need to completely skip the flush under dire circumstances
in the reclaim path, as I mentioned above. This feels more like a
reclaim problem than an rstat problem at this point.

>
>
> BTW, there is still a mem_cgroup_flush_stats() remaining in
> zswap_shrinker_count(), that we might still hit, after Shakeel's patch.
> And a direct call to do_flush_stats() in obj_cgroup_may_zswap().

Yeah there is a plan to remove these.

Nhat, are you currently working on this? If not I can try to find a
few cycles to address this.

[..]
>
> >>>
> >>> I thought we agreed to wait for the ongoing flusher to complete, but
> >>> only allow root cgroups to become the ongoing flusher (at least
> >>> initially). Not sure what changed.
> >>>
> >>
> >> Practical implementation (with completions) and production experiments
> >> is what changed my mind. Thus, I no-longer agree that waiting for the
> >> ongoing flusher to complete is the right solution.
> >
> >
> > My understanding based on [1] was that the ongoing flusher mechanism
> > with only root flushers fixed the problem, but maybe you got more data
> > afterward.
> >
>
> [1] is V8 (that allowed ongoing flusher below level 2) which production
> experience from that shows that we need to confine ongoing flusher to
> being the root cgroup only.  (This already worked in V2).  The V9
> production experience shows that using 'completions' caused issues and
> implementing this race free is very hard.


So you observed production problems with completions even when only
root cgroups are allowed to be the ongoing flusher, after you thought
it fixed the problem initially. Did I get that right?

