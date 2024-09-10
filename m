Return-Path: <cgroups+bounces-4823-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D726A9742D4
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 20:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07C8F1C26785
	for <lists+cgroups@lfdr.de>; Tue, 10 Sep 2024 18:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 321571A7040;
	Tue, 10 Sep 2024 18:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sCxOl4R8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02371A4F16
	for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 18:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725994561; cv=none; b=rE1sHV88hqIPKdqCIv/pZsuKLE7m5C7pTT1rij3ZVe8N1Mvn1uXCNKIuLYEk+KbvRvThRZgbgdewqy3NdKeyWd6561OgHDN4g97RCXviULjjVB+UDWPs/5eepaz4ApGSqp2Q1fE32TXswU3E4JaqUbKatxN5qI8ks5yh4eIEqZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725994561; c=relaxed/simple;
	bh=8VGF50TMS6kba3bI9dZfv086gYyzJ0yvGVHhxmK056A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XSrgGphCuqWeR7meqlTEbcxUGqdKxF2yjw4abt5G/e9OXwdIB3HLMYYFjfB5vmFvTkT6IWkDsOQtgSF1DlXdC13NvESuD2XTLT5Va88r6GcGrT+6MdB4hNCV3xHnPlLAiNgeZxmGwiQT4PMG9RQMAINag0SR6XIIVwEUHqevLNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sCxOl4R8; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so1393875a12.2
        for <cgroups@vger.kernel.org>; Tue, 10 Sep 2024 11:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725994557; x=1726599357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FXR2kju3UEdCGGD2E4YqZAQO3VbWRTwOTNC3dPcvl+8=;
        b=sCxOl4R8Y6oGrsnk4dBhTgO3Wi0AyT694GKB+gp/e4nCNYryBaSiUJqs8J9g5Tfht1
         0NeTrYfOdcqeuSOqdXZJDw6oiiH+WXtkrFgXXHG4qCzcZTO+uIWR0Ub5AbhwnfvEh3Ol
         ndpj8XXCAq21iil0uIQDC6oL5HMAf+VihD45Hu2J8tSaymOqrMxb/kyL0CsZ0aCaBNwm
         xVZereeTjcNGgUgyMUlNdWwVS5aynnmUXBomESBd2sGCN9btk9fJqeK5g17NTqjUYP5u
         ArgMjzzsE4q5K7Fo2jquY14xPZ4K+2djGtkaqui0erad6HnjufS9UnxqLC57GT3j7W8t
         z8ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725994557; x=1726599357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FXR2kju3UEdCGGD2E4YqZAQO3VbWRTwOTNC3dPcvl+8=;
        b=fOHuac63aJA1MjBjt+Kdq/64nxMquNA5UM1tDf2u/L4hmjm1fViDTSxeaHHroJB6P9
         bWxdICwcU/HoOp9x0U2bIddt6+xMR20lXchLeu0ikktR+RGKaHWOQTK18c6Bc1n+I3Sl
         35RzBRyZdqeteEiBlyAHCvRsbYP9MU3x4ut7WCx3Kmzkl3aq2Km9OvlayofJ8NLyr6Rj
         ffDiWk9E80sFUmRT+ij4OOu2XBq+zHAwJMsCvXhiIW0x/A0IZMUiL8/oNc53F+j6lHYS
         0T0QCF03leW+9GhVDW0vz9MqkXrFNBxZt8ucVkHY2mFItMecAhQ24DBS8ChAwrPbRPhs
         leTA==
X-Forwarded-Encrypted: i=1; AJvYcCVhRFzY8LTgYmtYR5lsmJvQmDkaX3zJPzqW8027/MXHLmqLSLzqSedPkbfWbPLMsBjijiMKCDL7@vger.kernel.org
X-Gm-Message-State: AOJu0YxgNdxYTHczwz4e7GYF6Ooc18ZOeu85q6hbdhvFQGcMkpEqZ6+a
	/tNPCxVyOsbBB3TZSeRm76OuvoYZpTsNSh29k0F4UFO6OmaRCR+4kjQamAKL9Oqqjo8nyi8LjcM
	Pl4XKEFVcBsB1A6GchyGD4bpgef1cHU+m+aoK
X-Google-Smtp-Source: AGHT+IEgbpHsyDuBgsbwneGuULRFoC8klWZGxMO9rnuUITgbaVccfC/bSg2nf+v+jbTqFrgm/SSpqmqMwNnNalcnxis=
X-Received: by 2002:a17:907:efdc:b0:a8d:64af:dc4c with SMTP id
 a640c23a62f3a-a9004833ef8mr49898866b.25.1725994556644; Tue, 10 Sep 2024
 11:55:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org>
In-Reply-To: <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 10 Sep 2024 11:55:20 -0700
Message-ID: <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: tj@kernel.org, cgroups@vger.kernel.org, shakeel.butt@linux.dev, 
	hannes@cmpxchg.org, lizefan.x@bytedance.com, longman@redhat.com, 
	kernel-team@cloudflare.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	mfleming@cloudflare.com
Content-Type: text/plain; charset="UTF-8"

[..]
>
> >>>> +       /*
> >>>> +        * Check if ongoing flusher is already taking care of this.  Descendant
> >>>> +        * check is necessary due to cgroup v1 supporting multiple root's.
> >>>> +        */
> >>>> +       ongoing = READ_ONCE(cgrp_rstat_ongoing_flusher);
> >>>> +       if (ongoing && cgroup_is_descendant(cgrp, ongoing))
> >>>> +               return false;
> >>>
> >>> Why did we drop the agreed upon method of waiting until the flushers
> >>> are done? This is now a much more intrusive patch which makes all
> >>> flushers skip if a root is currently flushing. This causes
> >>> user-visible problems and is something that I worked hard to fix. I
> >>> thought we got good results with waiting for the ongoing flusher as
> >>> long as it is a root? What changed?
> >>>
> >>
> >> I disagree with the idea of waiting until the flusher is done.
> >> As Shakeel have pointed out before, we don't need accurate stats.
> >> This caused issues and 'completions' complicated the code too much.
> >
> > I think Shakeel was referring specifically to the flush in the reclaim
> > path. I don't think this statement holds for all cgroup flushers,
> > especially those exposed to userspace.
> >
>
> My userspace readers (of /sys/fs/cgroup/*/*/memory.stat) are primarily
> cadvisor and systemd, which doesn't need this accuracy.
>
> Can you explain your userspace use-case that need this accuracy?


Please look at the commit log of this patch [1] that removed
stats_flush_ongoing (the one in Fixes).

[1]https://lore.kernel.org/lkml/20231129032154.3710765-6-yosryahmed@google.com/

>
>
> I assume you are primarily focused on memory.stat?
> Can we slack on accuracy for io.stat and cpu.stat?


I feel like this will eventually also cause problems as it is a
user-visible change, but I can't tell for sure.

>
>
> Detail: reading cpu.stat already waits on the ongoing flusher by always
> taking the lock (as it use lock to protect other things).  This
> indirectly created what you are asking for... If your userspace program
> first reads cpu.stat, then it will serve as a barrier that waits for the
> ongoing flusher.


Making userspace programs read cpu.stat before memory.stat to get the
correct flushing behavior is certainly not the way to address this
imo.

>
>
> Could we have a sysctl that enabled "accurate" cgroup rstat reading?
> As most users don't need this high accuracy.


I did a lot of testing of flushing latency in the commit I referred to
above, you'll find numbers there. I think the problem for you mainly
comes from having 12 kswapd threads flushing the root, they compete
among one another as well as with userspace reads. Shakeel's patch
should address this, and honestly I think the longer-term approach
should be to eliminate all in-kernel flushers [2], rather than making
all flushers inaccurate.

[2]https://lore.kernel.org/lkml/CAJD7tkaBfWWS32VYAwkgyfzkD_WbUUbx+rrK-Cc6OT7UN27DYA@mail.gmail.com/

>
>
>
> >>
> >> When multiple (12) kswapd's are running, then waiting for ongoing
> >> flusher will cause us to delay all other kswapd threads, for on my
> >> production system approx 24 ms (see attached prod graph).
> >> Matt (Cc) is currently[1] looking into page alloc failures that are
> >> happening across the fleet, when NIC RX packets as those allocs are
> >> GFP_ATOMIC.  So, basically kswapd isn't reclaiming memory fast enough on
> >> our systems, which could be related to this flush latency.  (Quick calc,
> >> prod server RX 1,159,695 pps, thus in 24 ms period 27,832 packets are
> >> handled, that exceed RX ring size 1024).
> >>
> >>    [1]
> >> https://lore.kernel.org/all/CAGis_TWzSu=P7QJmjD58WWiu3zjMTVKSzdOwWE8ORaGytzWJwQ@mail.gmail.com/
> >>
> >> For this reason, I don't want to have code that waits for ongoing
> >> flushers to finish.  This is why I changed the code.
> >
> > My understanding was that the previous versions solved most of the
> > problem. However, if it's not enough and we need to completely skip
> > the flush, then I don't think this patch is the right way to go. This
> > affects all flushers, not just the reclaim path, and not even just the
> > memcg flushers. Waiting for ongoing flushers was a generic approach
> > that should work for all flushers, but completely skipping the flush
> > is not.
> >
>
> IMHO waiting for ongoing flushers was not a good idea, as it caused
> other issues. Letting 11 other kswapd wait 24 ms for a single kswapd
> thread was not good for our production systems.


If it takes one kswapd thread 24 ms to flush the stats, then that's
the raw flush time. If all 12 kswapd threads started at different
times they would all spend 24 ms flushing anyway, so waiting for the
ongoing flusher is not a regression or a newly introduced delay. The
ongoing flusher mechanism rather tries to optimize this by avoiding
the lock contention and waiting for the ongoing flusher rather than
competing on the lock and redoing some of the work.

>
>
> I need remind people that "completely skipping the flush" due to ongoing
> flusher have worked well for us before kernel v6.8 (before commit
> 7d7ef0a4686a). So, I really don't see skipping the flush, when there is
> an ongoing flusher is that controversial.


Skipping the flush was introduced in v5.15 as part of aa48e47e3906
("memcg: infrastructure to flush memcg stats"). Before then, reading
the stats from userspace was as accurate as possible. When we moved to
a kernel with that commit we noticed the regression. So it wasn't
always the case that userspace reads were inaccurate or did not flush.

>
>
> I think it is controversial to *wait* for the ongoing flusher as that
> IMHO defeats the whole purpose of having an ongoing flusher...


The point of having an ongoing flusher is to avoid reacquiring the
lock after they are done, and checking all the percpu trees again for
updates, which would be a waste of work and unnecessary contention on
the lock. It's definitely an improvement over directly competing over
the lock, yet it doesn't sacrifice accuracy.

>
> then we could just have a normal mutex lock if we want to wait.


I am not against using a mutex as I mentioned before. If there are
concerns about priority inversions we can add a timeout as we
discussed. The ongoing flusher mechanism is similar in principle to a
mutex, the advantage is that whoever holds the lock does not sleep, so
it gets the flush done faster and waiters wake up faster.

>
>
>
> > If your problem is specifically the flush in the reclaim path, then
> > Shakeel's patch to replace that flush with the ratelimited version
> > should fix your problem. It was already merged into mm-stable (so
> > headed toward v6.11 AFAICT).
> >
> >>
> >>
> >>> You also never addressed my concern here about 'ongoing' while we are
> >>> accessing it, and never responded to my question in v8 about expanding
> >>> this to support non-root cgroups once we shift to a mutex.
> >>>
> >>
> >> I don't think we should expand this to non-root cgroups.  My production
> >> data from this V10 shows we don't need this for non-root cgroups.
> >
> > Right, because you are concerned with the flush in the kswapd path
> > specifically. This patch touches affects much more than that.
> >
>
> It is not only the flush in the kswapd path that concerns me.
> My other concern is userspace cadvisor that periodically reads ALL the
> .stat files on the system and creates flush spikes (every minute).  When
> advisor collides with root-cgroup flush (either 2 sec periodic or
> kswapd) then bad interactions happens in prod.


I believe the problem here is the kswapd flushers competing with
cadvisor userspace read. I don't think the periodic flusher that runs
every 2s colliding with the cadvisor reader that runs every minute
would really cause a problem. Also both of these paths should not be
latency sensitive anyway. So again, Shakeel's patch should help here.

Did you check if Shakeel's patch fixes your problem?

>
>
> >>
> >>
> >>> I don't appreciate the silent yet drastic change made in this version
> >>> and without addressing concerns raised in previous versions. Please
> >>> let me know if I missed something.
> >>>
> >>
> >> IMHO we needed a drastic change, because patch was getting too
> >> complicated, and my production experiments showed that it was no-longer
> >> solving the contention issue (due to allowing non-root cgroups to become
> >> ongoing).
> >
> > I thought we agreed to wait for the ongoing flusher to complete, but
> > only allow root cgroups to become the ongoing flusher (at least
> > initially). Not sure what changed.
> >
>
> Practical implementation (with completions) and production experiments
> is what changed my mind. Thus, I no-longer agree that waiting for the
> ongoing flusher to complete is the right solution.


My understanding based on [1] was that the ongoing flusher mechanism
with only root flushers fixed the problem, but maybe you got more data
afterward.

[1]https://lore.kernel.org/lkml/ee0f7d29-1385-4799-ab4b-6080ca7fd74b@kernel.org/

>
>
>
> >>
> >> Production servers with this V10 patch applied shows HUGE improvements.
> >> Let me grab a graf showing level-0 contention events being reduced from
> >> 1360 event/sec to 0.277 events/sec.  I had to change to a log-scale graf
> >> to make improvement visible.  The wait-time is also basically gone.  The
> >> improvements are so convincing and highly needed, that we are going to
> >> deploy this improvement.  I usually have a very strong upstream first
> >> principle, but we simply cannot wait any-longer for a solution to this
> >> production issue.
> >
> > Of course there is a huge improvement, you are completely skipping the
> > flush :) You are gaining a lot of performance but you'll also lose
> > something, there is no free lunch here. This may be an acceptable
> > tradeoff for the reclaim path, but definitely not for all flushers.
> >
>
> To move forward, can you please list the flushers that cannot accept
> this trade off?
> Then I can exclude these in the next version.


I am not sure which flushers would be problematic, I have seen
problems with the memcg userspace readers, but this doesn't mean it's
the only source of problems. There is also a flush in the zswap path
for charging that may be affected, but we discussed moving that to a
completely different approach to avoid the flush.

I am against skipping the flush for all cases with exceptions. What
Shakeel did was the opposite and the less controversial approach, skip
the flush only for the reclaim path because it's the one we observed
causing problems.

>
>
> >>
> >>
> >>>> +
> >>>> +       /* Grab right to be ongoing flusher */
> >>>> +       if (!ongoing && cgroup_is_root(cgrp)) {
> >>>> +               struct cgroup *old;
> >>>> +
> >>>> +               old = cmpxchg(&cgrp_rstat_ongoing_flusher, NULL, cgrp);
> >>>> +               if (old) {
> >>>> +                       /* Lost race for being ongoing flusher */
> >>>> +                       if (cgroup_is_descendant(cgrp, old))
> >>>> +                               return false;
> >>>> +               }
> >>>> +               /* Due to lock yield combined with strict mode record ID */
> >>>> +               WRITE_ONCE(cgrp_rstat_ongoing_flusher_ID, current);
> >>>
> >>> I am not sure I understand why we need this, do you mind elaborating?
> >>
> >> Let me expand the comment. Due to lock yield an ongoing (root) flusher
> >> can yield the lock, which would allow a root flush in strict mode to
> >> obtain the lock, which then in the unlock call (see below) will clear
> >> cgrp_rstat_ongoing_flusher (as cgrp in both cases have "root" cgrp ptr),
> >> unless it have this flush_ID to tell them apart.
> >
> > The pointers should be different for different roots though, right?
> > Why do we need the ID to tell them apart? I am not sure I follow.
>
> It is not different roots, it is needed for "the-same" root.
>
> It is possible that while an ongoing flusher is working, another process
> can call the flush in "strict" mode (for same root cgroup), that will
> bypass the ongoing check, and it will be waiting for the lock.  The
> ongoing flusher chooses to yield the lock, letting in the strict-mode
> flusher that then clears the ongoing flusher, unless we add this ID
> check.  I hope it is more clear now.
>
> --Jesper

