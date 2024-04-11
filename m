Return-Path: <cgroups+bounces-2441-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CFD8A1DA8
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 20:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBB901F2581F
	for <lists+cgroups@lfdr.de>; Thu, 11 Apr 2024 18:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3094017BB6;
	Thu, 11 Apr 2024 17:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JyNuAK7j"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9238D534
	for <cgroups@vger.kernel.org>; Thu, 11 Apr 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712856221; cv=none; b=CSn2fqWDA8YhbOaaPQBXFH20zHkoeNVsJM6kga5lPxc6YxXEcoXXeVUMaRvk5LzIcxunEfSaoRiWjiVnxduygTWrs98L/ybPMnpDgKQ89wSzFLLTJPhsUSol+tIJde2ho9mKHdQyJpM5hf4HzF9Ujd418z9UJqHjWD7cN9kkE7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712856221; c=relaxed/simple;
	bh=w5VRS9mjXIEYevZiZWI0OqR4wsBPMQnp3pOFSyk+s8Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YnfEPL04VR6bdM2stLZDS6GMxr/a3AVowvWI7edZ4530Uib+qkayHxiPMKND3K9UE9ykTPzzZWZzlUMS5iP1odIu/4GapPSlEfun+YTX44TgWKHMQLzHROqQd4oJ09rcgjfmCDHGAIlAvLDZR2/BakTUdlXOxB8EkMNmSXX1TQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JyNuAK7j; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51b5633c9cso4472666b.2
        for <cgroups@vger.kernel.org>; Thu, 11 Apr 2024 10:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712856216; x=1713461016; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A4qS/f14n6VYsG/mTYuJLf9YDLKR3IKQGN3luAlgFA8=;
        b=JyNuAK7jEo3IsSbiWiP/qPKuZAK8E/1E4EoHl8B8iVOjaoC2bNqQbk+q8N6PEcZfSl
         Mbrg+mEtU1Zg4EhZXLRkYyhJC7pGyRbG7TameeGDWpEod1ZSwsz/jQej5bi34r34gLNq
         WwAB6T++8qiAkhzweNJ8Ruzr9/lTlZM2UdR/iZkW5OxbkBH81ZtabqeGQoxsujlx1+yu
         nUz8SQPTDaoZtTHhNsEjPDWqWP6yoFBspRBOsftHkmc2oj7nYc4M3mg0HH2FB7h2Hgh8
         oINYL6fMn9wTlSIMrvULfGyNgVVndukfnyPHr0Y+y7a2a0VBb7Dr6Zw1I5TDh8iGTUAe
         AZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712856216; x=1713461016;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A4qS/f14n6VYsG/mTYuJLf9YDLKR3IKQGN3luAlgFA8=;
        b=UX8TYYPt8l3sva3C3uhBP3ZxBZEjaaq4Qp7UlvuLGAscPFkLKOTvdGYFeeGECM9wEZ
         pfvZcvJl2dBE0iJ5rBRxzsPr6sUpsFSuGel71Yt9y5mmnHBUHfPlnFFUAR7JJYpphHuR
         ilJVby0BObZROHckCqgZxhutHwnZBpZ2upzwEXlHCAJ5mCc3RrBG8CMUg/y9e9v4chkA
         nKaujTcrugs9wWIQQr2uhcfj7164mFfVjh9U3xUQBzjaIwI5ONDk6PzTiI4vZ9W4Be6o
         u9gDC1kbkM39pF8p5sUgfFEjCBm9Wz2+FT5348s92CjBttMtYJM/edvZ7CjoNmAS09mC
         1b3A==
X-Forwarded-Encrypted: i=1; AJvYcCUuBD0gkfPQ1b6MdpPxssFbvl9NizhC7CG5Fw6SH0e05INrKb4+95j4k8tlV4z0rZ+Mbz6MX+hU2T0wHp8yK2YFCOOJ7a5ISQ==
X-Gm-Message-State: AOJu0YzbALVsroaZmATeDi7MqBj6FkPDCg92tn0wT4dGpOVw6eywA7UL
	Kwov+8CPVQLDadk7qUzmzsc6fxvGYzA9ou5wy//TLsednSgXtrGcv+vS5zEvMTf5W/xpR/twpXg
	YDwGkXFZHM+xkMqqetDTYKdgAUqTJq/6DUFZM
X-Google-Smtp-Source: AGHT+IEr3KDGRsJ/RmhpOTZqJmy4xdrhgzrBK3ek65s26q9i0M577XGNWIdOLEhYfncSNBc68UZ/N66EchXxkt1Cwo4=
X-Received: by 2002:a17:906:f6d5:b0:a51:d2cf:ddf6 with SMTP id
 jo21-20020a170906f6d500b00a51d2cfddf6mr240975ejb.3.1712856215807; Thu, 11 Apr
 2024 10:23:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7cd05fac-9d93-45ca-aa15-afd1a34329c6@kernel.org>
 <20240319154437.GA144716@cmpxchg.org> <56556042-5269-4c7e-99ed-1a1ab21ac27f@kernel.org>
 <CAJD7tkYbO7MdKUBsaOiSp6-qnDesdmVsTCiZApN_ncS3YkDqGQ@mail.gmail.com>
 <bf94f850-fab4-4171-8dfe-b19ada22f3be@kernel.org> <CAJD7tkbn-wFEbhnhGWTy0-UsFoosr=m7wiJ+P96XnDoFnSH7Zg@mail.gmail.com>
 <ac4cf07f-52dd-454f-b897-2a4b3796a4d9@kernel.org> <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
 <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
 <4fd9106c-40a6-415a-9409-c346d7ab91ce@redhat.com> <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
In-Reply-To: <f72ab971-989e-4a1c-9246-9b8e57201b60@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 11 Apr 2024 10:22:57 -0700
Message-ID: <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com>
Subject: Re: Advice on cgroup rstat lock
To: Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Waiman Long <longman@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jesper Dangaard Brouer <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeelb@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"

[..]
> >>>>
> >>>> How far can we go... could cgroup_rstat_lock be converted to a mutex?
>  >>>
> >>> The cgroup_rstat_lock was originally a mutex. It was converted to a
> >>> spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex with
> >>> a spinlock"). Irq was disabled to enable calling from atomic context.
> >>> Since commit 0a2dc6ac3329 ("cgroup: remove
> >>> cgroup_rstat_flush_atomic()"), the rstat API hadn't been called from
> >>> atomic context anymore. Theoretically, we could change it back to a
> >>> mutex or not disabling interrupt. That will require that the API cannot
> >>> be called from atomic context going forward.
>  >>>
> >> I think we should avoid flushing from atomic contexts going forward
> >> anyway tbh. It's just too much work to do with IRQs disabled, and we
> >> observed hard lockups before in worst case scenarios.
> >>
>
> Appreciate the historic commits as documentation for how the code
> evolved.  Sounds like we agree that the IRQ-disable can be lifted,
> at-least between the three of us.

It can be lifted, but whether it should be or not is a different
story. I tried keeping it as a spinlock without disabling IRQs before
and Tejun pointed out possible problems, see below.

>
> >> I think one problem that was discussed before is that flushing is
> >> exercised from multiple contexts and could have very high concurrency
> >> (e.g. from reclaim when the system is under memory pressure). With a
> >> mutex, the flusher could sleep with the mutex held and block other
> >> threads for a while.
> >>
>
> Fair point, so in first iteration we keep the spin_lock but don't do the
> IRQ disable.

I tried doing that before, and Tejun had some objections:
https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/

My read of that thread is that Tejun would prefer we look into
converting cgroup_rsat_lock into a mutex again, or more aggressively
drop the lock on CPU boundaries. Perhaps we can unconditionally drop
the lock on each CPU boundary, but I am worried that contending the
lock too often may be an issue, which is why I suggested dropping the
lock if there are pending IRQs instead -- but I am not sure how to do
that :)

> I already have a upstream devel kernel doing this in my
> testlab, but I need to test this in prod to see the effects.  Can you
> recommend a test I should run in my testlab?

I don't know of any existing test/benchmark. What I used to do is run
a synthetic test with a lot of concurrent reclaim activity (some in
the same cgroups, some in different ones) to stress in-kernel
flushers, and a synthetic test with a lot of concurrent userspace
reads.

I would mainly look into the time it took for concurrent reclaim
operations to complete and the userspace reads latency histograms. I
don't have the scripts I used now unfortunately, but I can help with
more details if needed.

>
> I'm also looking at adding some instrumentation, as my bpftrace
> script[2] need to be adjusted to every binary build.
> Still hoping ACME will give me an easier approach to measuring lock wait
> and hold time? (without having to instrument *all* lock in system).
>
>
>   [2]
> https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_latency_steroids.bt
>
>
> >> I vaguely recall experimenting locally with changing that lock into a
> >> mutex and not liking the results, but I can't remember much more. I
> >> could be misremembering though.
> >>
> >> Currently, the lock is dropped in cgroup_rstat_flush_locked() between
> >> CPU iterations if rescheduling is needed or the lock is being
> >> contended (i.e. spin_needbreak() returns true). I had always wondered
> >> if it's possible to introduce a similar primitive for IRQs? We could
> >> also drop the lock (and re-enable IRQs) if IRQs are pending then.
> >
> > I am not sure if there is a way to check if a hardirq is pending, but we
> > do have a local_softirq_pending() helper.
>
> The local_softirq_pending() might work well for me, as this is our prod
> problem, that CPU local pending softirq's are getting starved.

If my understanding is correct, softirqs are usually scheduled by
IRQs, which means that local_softirq_pending() may return false if
there are pending IRQs (that will schedule softirqs). Is this correct?

>
> In production another problematic (but rarely occurring issue) is when
> several CPUs contend on this lock.  Yosry's recent work/patches have
> already reduced the chances of this happening (thanks), BUT it still can
> and does happen.
> A simple solution to this, would be to do a spin_trylock() in
> cgroup_rstat_flush(), and exit if we cannot get the lock, because we
> know someone else will do the work.

I am not sure I understand what you mean specifically with the checks
below, but I generally don't like this (as you predicted :) ).

On the memcg side, we used to have similar logic when we used to
always flush the entire tree. This leaded to flushing being
indeterministic. You would occasionally get stale stats because of the
contention, which resulted in some inconsistencies (e.g. performing
proactive reclaim successfully then reading the stats that do not
reflect that).

Now that we dropped the logic to always flush the entire tree, it is
even more difficult because concurrent flushes could be in completely
irrelevant subtrees.

If we were to introduce some smart logic to figure out that the
subtree we are trying to flush is already being flushed, I think we
would need to wait for that ongoing flush to complete instead of just
returning (e.g. using completions). But I think such implementations
to find overlapping flushes and wait for them may be too compicated.

> I expect someone to complain here, as cgroup_rstat_flush() takes a
> cgroup argument, so I might starve updates on some other cgroup. I
> wonder if I can simply check if cgroup->rstat_flush_next is not NULL, to
> determine if this cgroup is the one currently being processed?

