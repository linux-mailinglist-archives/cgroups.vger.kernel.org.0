Return-Path: <cgroups+bounces-2453-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38CD28A3684
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 21:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57A2281C73
	for <lists+cgroups@lfdr.de>; Fri, 12 Apr 2024 19:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD9CF150993;
	Fri, 12 Apr 2024 19:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HTAVhnsp"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC19314F9F5
	for <cgroups@vger.kernel.org>; Fri, 12 Apr 2024 19:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712951511; cv=none; b=eGKfxGH/jllp11cLzvlH7JMEsKkXVcdMAM73KKPAVF6z4h/rTqiO0kSZDpegZknKRwUcgoDz51LukTiCs1EjO1nZYsjbus/YUuvOdZNyf1l6iBWxN515vN2Hjp8pw7B6q8Vzwtxb2vAtI7S4A32VzIywu60OKgdHyw78wis/dOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712951511; c=relaxed/simple;
	bh=q5wK8qWyu1ly6paxXG5Rsydht5XYRaIbkzHHnH6XDno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aok6twmFirQjRCABWp2K71hxPZuygE//8eJh1LahbAg+fMlNwF6Jo3yDWC2anVMcw521o51Dk/8lt+CkuXR0L+ygST0ZlwIcll/7kqIo8oyTQRkZbZBPXyqa4zagMLi/xyCnmwfrFKQVYMlXaDvzxXOj3TxMFcRqBNBa0Y9Xf4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HTAVhnsp; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-516d2b9cd69so1480361e87.2
        for <cgroups@vger.kernel.org>; Fri, 12 Apr 2024 12:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712951508; x=1713556308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jAsbWIWxDyCbTeCy6d/WiDDQ6YO4elX4E4lumQbhzs4=;
        b=HTAVhnspWzekDgpXNC3AAyPhJBYMzbvseLYzPJ7mqHtZkgo2s6rmODHjuzSwXk90Z+
         cUqy/Sr/CAI5zuXmO5+WfWTFpohfh3Q2VPu1vVT5CiE65klE8kiI+l6l2/oG/0E1Zt1X
         Ayu+ozVZzJc0DKOs3gyf70epTJBS4QdNczdt1tDsI9lSkvyO7ZexPpiHMkzwaoGJGeOQ
         UrU4Y56eYkVxvE9BrXwvDmaZ1UtIcg8Q4RILAE/JCf2LE80/k//bPB8giFbdmOJmYO9Y
         y7cZpq5e2x98lG/oCVvycbcAspdjEIOa475T/WGa0xH86kIm/f6oUEDRhqHwUq7r1XID
         T5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712951508; x=1713556308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jAsbWIWxDyCbTeCy6d/WiDDQ6YO4elX4E4lumQbhzs4=;
        b=Hct/1xa5PPJ9n2wgdvDVZf/jeANIHTF83fYzldMJQ3g/d3+wvBkcX+q0F5MUN1cyhQ
         86m4s7444qBprj+1JEa02RH9MmfDqUSG/yZH8IYtFjVksg0YN92HxoxjpxhJJWUwzzQS
         otFjRHSJDtbw4SeIcTicyWh0zW4p3pJB1BGw4pqGgXxN0f4RlEwYRMp7Rq1gNwxQK+dK
         pHWRtW4IpYGJh/gz2PdAHVsCs96KzXFn1DdUMYAhX3LT9smOryItr9A5OTde8yIEpBE+
         0X9BmaLJlDRIwn7ZiUiCKdUFzesI42R7uVaG08kTSTJunGFoa9QVswocECrC7Rxxcvsh
         njnw==
X-Forwarded-Encrypted: i=1; AJvYcCVX/w3qVYm6j255xnIUSEgnqRqzrd2mho8mfTgKK5vW1CusZ8Uv12uvUvAgc/7t2qQRHQGZrp/oDPKmth4JWKBOypy8dVoTHA==
X-Gm-Message-State: AOJu0YwkgKAhQE5p/d9bMO0z8AJ+osyhCKBPsJ72SmSmQPGfWXbGOsUI
	mrlrLa2SCzlaufCbczJ0GF8mLVnMXIWOcOSTQ/KUoDqSRNdxfKfMibfu1hXjo3qZUAnxXvcr3xz
	djiwepfiPzGahSbTSN/+gtJ21UcNK4lc7efS+
X-Google-Smtp-Source: AGHT+IFHmPijgWrApfizlTcY29Rrbg05HsjLi2+sFWc0+n5uAgIKka/EAL9+99DU+fWjHK2WtZAa8S/s1vI29shmIyY=
X-Received: by 2002:ac2:41c5:0:b0:516:cdfa:17f6 with SMTP id
 d5-20020ac241c5000000b00516cdfa17f6mr2105982lfi.67.1712951507911; Fri, 12 Apr
 2024 12:51:47 -0700 (PDT)
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
 <CAJD7tka=1AnBNFn=frp7AwfjGsZMGcDjw=xiWeqNygC5rPf6uQ@mail.gmail.com> <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org>
In-Reply-To: <75d837cc-4d33-44f6-bb0c-7558f0488d4e@kernel.org>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 12 Apr 2024 12:51:09 -0700
Message-ID: <CAJD7tka_ESbcK6cspyEfVqv1yTW0uhWSvvoO4bqMJExn-j-SEg@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 12:26=E2=80=AFPM Jesper Dangaard Brouer <hawk@kerne=
l.org> wrote:
>
>
>
> On 11/04/2024 19.22, Yosry Ahmed wrote:
> > [..]
> >>>>>>
> >>>>>> How far can we go... could cgroup_rstat_lock be converted to a mut=
ex?
> >>   >>>
> >>>>> The cgroup_rstat_lock was originally a mutex. It was converted to a
> >>>>> spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex=
 with
> >>>>> a spinlock"). Irq was disabled to enable calling from atomic contex=
t.
> >>>>> Since commit 0a2dc6ac3329 ("cgroup: remove
> >>>>> cgroup_rstat_flush_atomic()"), the rstat API hadn't been called fro=
m
> >>>>> atomic context anymore. Theoretically, we could change it back to a
> >>>>> mutex or not disabling interrupt. That will require that the API ca=
nnot
> >>>>> be called from atomic context going forward.
> >>   >>>
> >>>> I think we should avoid flushing from atomic contexts going forward
> >>>> anyway tbh. It's just too much work to do with IRQs disabled, and we
> >>>> observed hard lockups before in worst case scenarios.
> >>>>
> >>
> >> Appreciate the historic commits as documentation for how the code
> >> evolved.  Sounds like we agree that the IRQ-disable can be lifted,
> >> at-least between the three of us.
> >
> > It can be lifted, but whether it should be or not is a different
> > story. I tried keeping it as a spinlock without disabling IRQs before
> > and Tejun pointed out possible problems, see below.
> >
>
> IMHO it *MUST* be lifted, as disabling IRQs here is hurting other parts
> of the system and actual production systems.
>
> The "offending" IRQ-spin_lock commit (0fa294fb1985) is from 2018, and
> GitHub noticed in 2019 (via blog[1]) and at Red Hat I backported[2]
> patches (which I now understand) only mitigate the issues.  Our prod
> systems are on 6.1 and 6.6 where we still clearly see the issue
> occurring.  Also Daniel's "rtla timerlat" tool for catching systems
> latency issues have "cgroup_rstat_flush_locked" as the poster child [3][4=
].

We have been bitten by the IRQ-spinlock before, so I cannot disagree,
although for us removing atomic flushes and allowing the lock to be
dropped between CPU flushes seems to be good enough (for now).

>
>
>   [1] https://github.blog/2019-11-21-debugging-network-stalls-on-kubernet=
es/
>   [2] https://bugzilla.redhat.com/show_bug.cgi?id=3D1795049
>   [3] https://bristot.me/linux-scheduling-latency-debug-and-analysis/
>   [4] Documentation/tools/rtla/rtla-timerlat-top.rst
>
> >>
> >>>> I think one problem that was discussed before is that flushing is
> >>>> exercised from multiple contexts and could have very high concurrenc=
y
> >>>> (e.g. from reclaim when the system is under memory pressure). With a
> >>>> mutex, the flusher could sleep with the mutex held and block other
> >>>> threads for a while.
> >>>>
> >>
> >> Fair point, so in first iteration we keep the spin_lock but don't do t=
he
> >> IRQ disable.
> >
> > I tried doing that before, and Tejun had some objections:
> > https://lore.kernel.org/lkml/ZBz%2FV5a7%2F6PZeM7S@slm.duckdns.org/
> >
> > My read of that thread is that Tejun would prefer we look into
> > converting cgroup_rsat_lock into a mutex again, or more aggressively
> > drop the lock on CPU boundaries. Perhaps we can unconditionally drop
> > the lock on each CPU boundary, but I am worried that contending the
> > lock too often may be an issue, which is why I suggested dropping the
> > lock if there are pending IRQs instead -- but I am not sure how to do
> > that :)
> >
>
> Like Tejun, I share the concern that keeping this a spinlock will
> can increase the chance of several CPUs contend on this lock (which is
> also a production issue we see).  This is why I suggested to "exit" if
> (1) we see the lock have been taken by somebody else, or if (2) stats
> were flushed recently.

When you say "exit", do you mean abort the whole thing, or just don't
spin for the lock but wait for the ongoing flush?

>
> For (2), memcg have a mem_cgroup_flush_stats_ratelimited() system
> combined with memcg_vmstats_needs_flush(), which limits the pressure on
> the global lock (cgroup_rstat_lock).
> *BUT* other users of cgroup_rstat_flush() like when reading io.stat
> (blk-cgroup.c) and cpu.stat, don't have such a system to limit pressure
> on global lock. Further more, userspace can easily trigger this via
> reading those stat files.  And normal userspace stats tools (like
> cadvisor, nomad, systemd) spawn threads reading io.stat, cpu.stat and
> memory.stat, likely without realizing that kernel side they share same
> global lock...
>
> I'm working on a code solution/proposal for "ratelimiting" global lock
> access when reading io.stat and cpu.stat.

I personally don't like mem_cgroup_flush_stats_ratelimited() very
much, because it is time-based (unlike memcg_vmstats_needs_flush()),
and a lot of changes can happen in a very short amount of time.
However, it seems like for some workloads it's a necessary evil :/

I briefly looked into a global scheme similar to
memcg_vmstats_needs_flush() in core cgroups code, but I gave up
quickly. Different subsystems have different incomparable stats, so we
cannot have a simple magnitude of pending updates on a cgroup-level
that represents all subsystems fairly.

I tried to have per-subsystem callbacks to update the pending stats
and check if flushing is required -- but it got complicated quickly
and performance was bad.

At some point, having different rstat trees for different subsystems
was brought up. I never looked into actually implementing it, but I
suppose if we do that we have a generic scheme similar to
memcg_vmstats_needs_flush() that can be customized by each subsystem
in a clean performant way? I am not sure.

[..]
> >>
> >>>> I vaguely recall experimenting locally with changing that lock into =
a
> >>>> mutex and not liking the results, but I can't remember much more. I
> >>>> could be misremembering though.
> >>>>
> >>>> Currently, the lock is dropped in cgroup_rstat_flush_locked() betwee=
n
> >>>> CPU iterations if rescheduling is needed or the lock is being
> >>>> contended (i.e. spin_needbreak() returns true). I had always wondere=
d
> >>>> if it's possible to introduce a similar primitive for IRQs? We could
> >>>> also drop the lock (and re-enable IRQs) if IRQs are pending then.
> >>>
> >>> I am not sure if there is a way to check if a hardirq is pending, but=
 we
> >>> do have a local_softirq_pending() helper.
> >>
> >> The local_softirq_pending() might work well for me, as this is our pro=
d
> >> problem, that CPU local pending softirq's are getting starved.
> >
> > If my understanding is correct, softirqs are usually scheduled by
> > IRQs, which means that local_softirq_pending() may return false if
> > there are pending IRQs (that will schedule softirqs). Is this correct?
> >
>
> Yes, networking hard IRQ will raise softirq, but software often also
> raise softirq.
> I see where you are going with this... the cgroup_rstat_flush_locked()
> loop "play nice" check happens with IRQ lock held, so you speculate that
> IRQ handler will not be able to raise softirq, thus
> local_softirq_pending() will not work inside IRQ lock.

Exactly.

I wonder if it would be okay to just unconditionally drop the lock at
each CPU boundary. Would be interesting to experiment with this. One
disadvantage of the mutex in this case (imo) is that outside of the
percpu spinlock critical section, we don't really need to be holding
the global lock/mutex. So sleeping while holding it is not needed and
only introduces problems. Dropping the spinlock at each boundary seems
like a way to circumvent that.

If the problems you are observing are mainly on CPUs that are holding
the lock and flushing, I suspect this should greatly. If the problems
are mainly on CPUs spinning for the lock, I suspect it will still help
redistribute the lock (and IRQs disablement) more often, but not as
much.

>
>
> >>
> >> In production another problematic (but rarely occurring issue) is when
> >> several CPUs contend on this lock.  Yosry's recent work/patches have
> >> already reduced the chances of this happening (thanks), BUT it still c=
an
> >> and does happen.
> >> A simple solution to this, would be to do a spin_trylock() in
> >> cgroup_rstat_flush(), and exit if we cannot get the lock, because we
> >> know someone else will do the work.
> >
> > I am not sure I understand what you mean specifically with the checks
> > below, but I generally don't like this (as you predicted :) ).
> >
> > On the memcg side, we used to have similar logic when we used to
> > always flush the entire tree. This leaded to flushing being
> > indeterministic. You would occasionally get stale stats because of the
> > contention, which resulted in some inconsistencies (e.g. performing
> > proactive reclaim successfully then reading the stats that do not
> > reflect that).
> >
> > Now that we dropped the logic to always flush the entire tree, it is
> > even more difficult because concurrent flushes could be in completely
> > irrelevant subtrees.
> >
> > If we were to introduce some smart logic to figure out that the
> > subtree we are trying to flush is already being flushed, I think we
> > would need to wait for that ongoing flush to complete instead of just
> > returning (e.g. using completions). But I think such implementations
> > to find overlapping flushes and wait for them may be too compicated.
> >
>
> We will see if you hate my current code approach ;-)

Just to be clear, if the spinlock was to be converted to a mutex, or
to be dropped at each CPU boundary, do you still think such
ratelimiting is still needed to mitigate lock contention -- even if
the IRQs latency problem is fixed?

