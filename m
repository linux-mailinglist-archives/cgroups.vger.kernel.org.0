Return-Path: <cgroups+bounces-2628-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE2A8AB587
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 21:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22CED1F2218B
	for <lists+cgroups@lfdr.de>; Fri, 19 Apr 2024 19:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E2113C82D;
	Fri, 19 Apr 2024 19:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zIeHq+Th"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBD31386CC
	for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713554530; cv=none; b=DFbyz512DwJMGUXUhPLKwZRVC/jQcFcQK+JzpX+/SibwHYbkR1dSH6iJc2DV0N8xhhq5X6QD8W7Y6N7eAHMbqxzk6rfbS2JKbLyswLM4FmqmwmYAmghLIVLewvZSuVMcc9jg0dW8U02WFisdy8Xqdq85TkaAbf4fauX9HDT7fYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713554530; c=relaxed/simple;
	bh=0Yf1np1EiQRR1H+HojMtCteZkzQwyIMTFpovj1tcuSA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kun5Tl4SDTzcxYx0iyNJZOM/CR5O3k5D+ljlLbS7X/CdxnFJKYuvzQq7douQR8IN28KLxsO/x4GTDetvFi+VSppgkrIwhRnmg4Em07CaDh3XdE64sn3orcLiQ1qAcMtjmhi/S/vhUmnohvUUnU8VRLawq1/1cJeqkzK184rR4Ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zIeHq+Th; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a554afec54eso245751666b.1
        for <cgroups@vger.kernel.org>; Fri, 19 Apr 2024 12:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713554527; x=1714159327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=zIeHq+Thn7YTr3RpZM3b+1yEJ5ovU/PQYkZPXZhio6P7bZctZbZiLGj24cRFIg5oFw
         kHsShSdrttqbvrsThk6/whQjz0PlCcUfi9PAf4QKVU5oX7NvZzjZaBMMDyrPYI9GHora
         hI3hMxb4Xu1V3yVOfG25Gh/oSvOu8DBaJD58mNQty4nZZrLQpNnEVabb3PHEhYmbTzGA
         lgOgUcUOb23NYEb7jAsI7wlpy/mr3hoJP9nOjpr1l7996mNf12bdNAiZCMNj5bHB4ACG
         eqCJxOZKZ8nwG30IxCBu7PLmFtG7SkTk/KB2EkG/EC5tdC+3LWFoAcNftt/ysDAJgcOt
         TXiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713554527; x=1714159327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cgxiaek1OC/UQSjtnluTE8oS+OxORZPByii8n2kRyX4=;
        b=YN7QGPYkmR/4TvJmFU3xUICFcl0xbqNNdwdLqiil9LejK+NyrO/6WEOtKAV83L4l86
         ow8+JGM/hCIFqbseLx575fROcjUOnu0K737lL7thE6uirfEmCI5JuG4fDHqYxm06XWYt
         oO1Z2nBkuQyjTnQ20oOYwrF4XAhQOcQsI6uKu5WsvrcKO+sheij7SH76vM4ljO8MyPL3
         OZql3AnWd1u5TaJqgmOF5TjQM949uCEQ3gEXxWXkyC89RbNu5/66jdDXRim+TFljqbKo
         XjxkUbr9JgGljpTW0xP85xCQvFrBwHgrqiZinZoBI5cBvX6hGY7z9dgn8AU2hXPMInlG
         RVFw==
X-Forwarded-Encrypted: i=1; AJvYcCWkx0AzjQC1uHvusOb9eVBKVSl+znfKLHDzQp8q8O6Ovu/E1vZhm1Ov3Xqa42YQ/OAB7aBEtBvEGw74d+BV24nYYJ1DylFFeA==
X-Gm-Message-State: AOJu0YwIuFZGTmXedSIHu0gW0ejkUVMjzUJq7QbzUVHeg/o9g3U+5jSS
	UGkRwJniKVhnKCdw+dDy1ve/O1RciJeSn45fa4img7ZKBpnF8+Fi7dpBiWJHgpz790zUfTJK4HG
	r2E1XRrdNGr4iEyfk6El1fd4lhJr0YM0PhT3D
X-Google-Smtp-Source: AGHT+IEBjBNkvxdmuTE9VnI6C88nKhqq8KjzGCHHIFj/6VLY3xCFjTvSpOxoFw/tjaW8RUkr6IZWX3lHaV1KlXwC0BQ=
X-Received: by 2002:a17:906:f255:b0:a52:2284:d97f with SMTP id
 gy21-20020a170906f25500b00a522284d97fmr2030488ejb.25.1713554526552; Fri, 19
 Apr 2024 12:22:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171328983017.3930751.9484082608778623495.stgit@firesoul>
 <171328989335.3930751.3091577850420501533.stgit@firesoul> <CAJD7tkZFnQK9CFofp5rxa7Mv9wYH2vWF=Bb28Dchupm8LRt7Aw@mail.gmail.com>
 <651a52ac-b545-4b25-b82f-ad3a2a57bf69@kernel.org> <lxzi557wfbrkrj6phdlub4nmtulzbegykbmroextadvssdyfhe@qarxog72lheh>
 <CAJD7tkYJZgWOeFuTMYNoyH=9+uX2qaRdwc4cNuFN9wdhneuHfA@mail.gmail.com>
 <6392f7e8-d14c-40f4-8a19-110dfffb9707@kernel.org> <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
In-Reply-To: <gckdqiczjtyd5qdod6a7uyaxppbglg3fkgx2pideuscsyhdrmy@by6rlly6crmz>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Fri, 19 Apr 2024 12:21:30 -0700
Message-ID: <CAJD7tkbCzx1S9d0oK-wR7AY3O3ToBrEwKTaYTykE1WwczcYLBg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] cgroup/rstat: convert cgroup_rstat_lock back to mutex
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, hannes@cmpxchg.org, 
	lizefan.x@bytedance.com, cgroups@vger.kernel.org, longman@redhat.com, 
	netdev@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, mhocko@kernel.org
Content-Type: text/plain; charset="UTF-8"

[..]
> > > Perhaps we could experiment with always dropping the lock at CPU
> > > boundaries instead?
> > >
> >
> > I don't think this will be enough (always dropping the lock at CPU
> > boundaries).  My measured "lock-hold" times that is blocking IRQ (and
> > softirq) for too long.  When looking at prod with my new cgroup
> > tracepoint script[2]. When contention occurs, I see many Yields
> > happening and with same magnitude as Contended. But still see events
> > with long "lock-hold" times, even-though yields are high.
> >
> >  [2] https://github.com/xdp-project/xdp-project/blob/master/areas/latency/cgroup_rstat_tracepoint.bt
> >
> > Example output:
> >
> >  12:46:56 High Lock-contention: wait: 739 usec (0 ms) on CPU:56 comm:kswapd7
> >  12:46:56 Long lock-hold time: 6381 usec (6 ms) on CPU:27 comm:kswapd3
> >  12:46:56 Long lock-hold time: 18905 usec (18 ms) on CPU:100
> > comm:kworker/u261:12
> >
> >  12:46:56  time elapsed: 36 sec (interval = 1 sec)
> >   Flushes(2051) 15/interval (avg 56/sec)
> >   Locks(44464) 1340/interval (avg 1235/sec)
> >   Yields(42413) 1325/interval (avg 1178/sec)
> >   Contended(42112) 1322/interval (avg 1169/sec)
> >
> > There is reported 15 flushes/sec, but locks are yielded quickly.
> >
> > More problematically (for softirq latency) we see a Long lock-hold time
> > reaching 18 ms.  For network RX softirq I need lower than 0.5ms latency,
> > to avoid RX-ring HW queue overflows.

Here we are measuring yields against contention, but the main problem
here is IRQ serving latency, which doesn't have to correlate with
contention, right?

Perhaps contention is causing us to yield the lock every nth cpu
boundary, but apparently this is not enough for IRQ serving latency.
Dropping the lock on each boundary should improve IRQ serving latency,
regardless of the presence of contention.

Let's focus on one problem at a time ;)

> >
> >
> > --Jesper
> > p.s. I'm seeing a pattern with kswapdN contending on this lock.
> >
> > @stack[697, kswapd3]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[698, kswapd4]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
> > @stack[699, kswapd5]:
> >         __cgroup_rstat_lock+107
> >         __cgroup_rstat_lock+107
> >         cgroup_rstat_flush_locked+851
> >         cgroup_rstat_flush+35
> >         shrink_node+226
> >         balance_pgdat+807
> >         kswapd+521
> >         kthread+228
> >         ret_from_fork+48
> >         ret_from_fork_asm+27
> >
>
> Can you simply replace mem_cgroup_flush_stats() in
> prepare_scan_control() with the ratelimited version and see if the issue
> still persists for your production traffic?

With thresholding, the fact that we reach cgroup_rstat_flush() means
that there is a high magnitude of pending updates. I think Jesper
mentioned 128 CPUs before, that means 128 * 64 (MEMCG_CHARGE_BATCH)
page-sized updates. That could be over 33 MBs with 4K page size.

I am not sure if it's fine to ignore such updates in shrink_node(),
especially that it is called in a loop sometimes so I imagine we may
want to see what changed after the last iteration.

>
> Also were you able to get which specific stats are getting the most
> updates?

This, on the other hand, would be very interesting. I think it is very
possible that we don't actually have 33 MBs of updates, but rather we
keep adding and subtracting from the same stat until we reach the
threshold. This could especially be true for hot stats like slab
allocations.

