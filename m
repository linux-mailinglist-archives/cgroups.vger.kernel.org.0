Return-Path: <cgroups+bounces-2389-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D64F89E0B9
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 18:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126A6285267
	for <lists+cgroups@lfdr.de>; Tue,  9 Apr 2024 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B98153809;
	Tue,  9 Apr 2024 16:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZBAFjo8"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1238152DEB
	for <cgroups@vger.kernel.org>; Tue,  9 Apr 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712681163; cv=none; b=bYuHlgrH1BTJx4A/doNs9tVJH5G16qU9TCVa67bJLxY+C+vWUMqoZ3nMjZg67foMe3tvVgWGm1iBu4joPkxGRJlZyr5MK5nQsIet2WYmQqMk4cok+fJj+bv9IjBSJ4MYw4y4gEuqNnqxm7GWIdqpWmU+CvW6y5jeXGYlmsjbmtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712681163; c=relaxed/simple;
	bh=V7RrbkpWyu/aIYEhwOeEBFK0kd8UsWPtMudxgDSgPSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R6Jr/Lf8XuHqa/+ThScDZWKs/jpbZo0zeOa7v4xkOGqwy1wZmxcHvqjmnuOIRWTIVqsXNFRHaZkXqUrSwFA6UCA3FDwUC5ia6yRDwm3zpD3Qln0Snt8mJIXQ35/RdAZq+As3ESb02GKbdYxotMqPsC/Agg7dUDfKJLqFPjsBtKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZBAFjo8; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso5757080a12.2
        for <cgroups@vger.kernel.org>; Tue, 09 Apr 2024 09:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712681160; x=1713285960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VO0sU5Arn6X6D0Lm7h4afSioZzK6RHLZrYO4mvTd0q4=;
        b=dZBAFjo8iO3CPpZVxnQEA/DT3hIJ2vYeyqMJJ5G+xlXxKxbuIHPuT2dswntKD9CXTr
         3w1Uxh2lDyUF8iPSozeWzWbWpgqdO7dKW3c+CJWuMh4cyG6KEOrdQ8TBft4y4A3jQU7p
         N1hnfEWA1XH6eueeR6dC2uws75bpdxKf6OSVlRp/AvjbXRfr1/hxDb+KwU6wRXCbyx4u
         LTZK5uiVtPieLR1w66CGtoma6wdzj6P9LWfG9xUdujlb++6RjxVGlB8LpqM9FOOGBxiy
         qYjeHwDpQhscSF5AD2p6uHR09WGDV07/gPAItNCkQHthfnUoPbV5f1FKSbcNN0TWTyor
         PPeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712681160; x=1713285960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VO0sU5Arn6X6D0Lm7h4afSioZzK6RHLZrYO4mvTd0q4=;
        b=scSrQViarGfh7Kk/Q4zNMXJ+G9M03gJbstybOzoiw4zc3ksJlbVgRibePq+WGmgPR/
         cHF89M1YyqL8j/5L7FDIfGXmUPtUZBx4v6ZBMhttRZd3W3Fg0OP8YhzRPBtSFNHvdrR7
         r0nAKQGiA0kcMpVyh8XT0mFhMW/fMiM8yEB92alp3X9vyHvLz+HFi4o4SCUrvf6YWxzr
         h9kPxFlmpPsChG2b2vGaudmugw0j58rx/+XWDNhBWZuBnXrD3Y+5XswN2rQqUGZqi8/V
         TXiXranh+SVf5iLOro4wzqlliEzkl0G2CQVztpo58HN/hK5n1fr3RI4x14O8WmJfPJsO
         wdJg==
X-Forwarded-Encrypted: i=1; AJvYcCVL3iOvD7LmXP21QjoNh3gWdC32AK+XdCzfHPrex6dBYRMfD9Voa8osdnOHfMKglP5DC55cJt5a4wVXCc5U3lwGEwxKr0e2xw==
X-Gm-Message-State: AOJu0YwGkBo8ztR0OZl8RFF9minvmoW8eTJkPgrUAGH6ilRZIvmk3rMD
	o6ILSpi/E22rjJQusFADDIWTsGzyoKafeKQ40O7SATzx8tG8JTPx4MrukgSVHe4iB3SAfDw6JYw
	dsbaR7nkNKff2wwyKEmlqu9fAVFM5nY3vPnsH
X-Google-Smtp-Source: AGHT+IHbJIK6+gNvsrEEhA3aRLXLxWwMGZFgt2rB8VsNwxjaanEbTa+QMHBaWUOnv0UHfwCq83FRne/wbfIulHTT99c=
X-Received: by 2002:a17:906:248f:b0:a51:d5ce:b79e with SMTP id
 e15-20020a170906248f00b00a51d5ceb79emr8906ejb.47.1712681159869; Tue, 09 Apr
 2024 09:45:59 -0700 (PDT)
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
In-Reply-To: <96728c6d-3863-48c7-986b-b0b37689849e@redhat.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 9 Apr 2024 09:45:21 -0700
Message-ID: <CAJD7tkZrVjhe5PPUZQNoAZ5oOO4a+MZe283MVTtQHghGSxAUnA@mail.gmail.com>
Subject: Re: Advice on cgroup rstat lock
To: Waiman Long <longman@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>, 
	Jesper Dangaard Brouer <jesper@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Shakeel Butt <shakeelb@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, 
	kernel-team <kernel-team@cloudflare.com>, cgroups@vger.kernel.org, 
	Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Ivan Babrou <ivan@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 8:37=E2=80=AFAM Waiman Long <longman@redhat.com> wro=
te:
>
> On 4/9/24 07:08, Jesper Dangaard Brouer wrote:
> > Let move this discussion upstream.
> >
> > On 22/03/2024 19.32, Yosry Ahmed wrote:
> >> [..]
> >>>> There was a couple of series that made all calls to
> >>>> cgroup_rstat_flush() sleepable, which allows the lock to be dropped
> >>>> (and IRQs enabled) in between CPU iterations. This fixed a similar
> >>>> problem that we used to face (except in our case, we saw hard lockup=
s
> >>>> in extreme scenarios):
> >>>> https://lore.kernel.org/linux-mm/20230330191801.1967435-1-yosryahmed=
@google.com/
> >>>>
> >>>> https://lore.kernel.org/lkml/20230421174020.2994750-1-yosryahmed@goo=
gle.com/
> >>>>
> >>>
> >>> I've only done the 6.6 backport, and these were in 6.5/6.6.
> >
> > Given I have these in my 6.6 kernel. You are basically saying I should
> > be able to avoid IRQ-disable for the lock, right?
> >
> > My main problem with the global cgroup_rstat_lock[3] is it disables IRQ=
s
> > and (thereby also) BH/softirq (spin_lock_irq).  This cause production
> > issues elsewhere, e.g. we are seeing network softirq "not-able-to-run"
> > latency issues (debug via softirq_net_latency.bt [5]).
> >
> >   [3]
> > https://elixir.bootlin.com/linux/v6.9-rc3/source/kernel/cgroup/rstat.c#=
L10
> >   [5]
> > https://github.com/xdp-project/xdp-project/blob/master/areas/latency/so=
ftirq_net_latency.bt
> >
> >
> >>> And between 6.1 to 6.6 we did observe an improvement in this area.
> >>> (Maybe I don't have to do the 6.1 backport if the 6.6 release plan
> >>> progress)
> >>>
> >>> I've had a chance to get running in prod for 6.6 backport.
> >>> As you can see in attached grafana heatmap pictures, we do observe an
> >>> improved/reduced softirq wait time.
> >>> These softirq "not-able-to-run" outliers is *one* of the prod issues =
we
> >>> observed.  As you can see, I still have other areas to improve/fix.
> >>
> >> I am not very familiar with such heatmaps, but I am glad there is an
> >> improvement with 6.6 and the backports. Let me know if there is
> >> anything I could do to help with your effort.
> >
> > The heatmaps give me an overview, but I needed a debugging tool, so I
> > developed some bpftrace scripts [1][2] I'm running on production.
> > To measure how long time we hold the cgroup rstat lock (results below).
> > Adding ACME and Daniel as I hope there is an easier way to measure lock
> > hold time and congestion. Notice tricky release/yield in
> > cgroup_rstat_flush_locked[4].
> >
> > My production results on 6.6 with backported patches (below signature)
> > vs a our normal 6.6 kernel, with script [2]. The `@lock_time_hist_ns`
> > shows how long time the lock+IRQs were disabled (taking into account it
> > can be released in the loop [4]).
> >
> > Patched kernel:
> >
> > 21:49:02  time elapsed: 43200 sec
> > @lock_time_hist_ns:
> > [2K, 4K)              61 |      |
> > [4K, 8K)             734 |      |
> > [8K, 16K)         121500 |@@@@@@@@@@@@@@@@      |
> > [16K, 32K)        385714
> > |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [32K, 64K)        145600 |@@@@@@@@@@@@@@@@@@@      |
> > [64K, 128K)       156873 |@@@@@@@@@@@@@@@@@@@@@      |
> > [128K, 256K)      261027 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ |
> > [256K, 512K)      291986 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      =
|
> > [512K, 1M)        101859 |@@@@@@@@@@@@@      |
> > [1M, 2M)           19866 |@@      |
> > [2M, 4M)           10146 |@      |
> > [4M, 8M)           30633 |@@@@      |
> > [8M, 16M)          40365 |@@@@@      |
> > [16M, 32M)         21650 |@@      |
> > [32M, 64M)          5842 |      |
> > [64M, 128M)            8 |      |
> >
> > And normal 6.6 kernel:
> >
> > 21:48:32  time elapsed: 43200 sec
> > @lock_time_hist_ns:
> > [1K, 2K)              25 |      |
> > [2K, 4K)            1146 |      |
> > [4K, 8K)           59397 |@@@@      |
> > [8K, 16K)         571528 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      =
|
> > [16K, 32K)        542648 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> > [32K, 64K)        202810 |@@@@@@@@@@@@@      |
> > [64K, 128K)       134564 |@@@@@@@@@      |
> > [128K, 256K)       72870 |@@@@@      |
> > [256K, 512K)       56914 |@@@      |
> > [512K, 1M)         83140 |@@@@@      |
> > [1M, 2M)          170514 |@@@@@@@@@@@      |
> > [2M, 4M)          396304 |@@@@@@@@@@@@@@@@@@@@@@@@@@@      |
> > [4M, 8M)          755537
> > |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> > [8M, 16M)         231222 |@@@@@@@@@@@@@@@      |
> > [16M, 32M)         76370 |@@@@@      |
> > [32M, 64M)          1043 |      |
> > [64M, 128M)           12 |      |
> >
> >
> > For the unpatched kernel we see more events in 4ms to 8ms bucket than
> > any other bucket.
> > For patched kernel, we clearly see a significant reduction of events in
> > the 4 ms to 64 ms area, but we still have some events in this area.  I'=
m
> > very happy to see these patches improves the situation.  But for networ=
k
> > processing I'm not happy to see events in area 16ms to 128ms area.  If
> > we can just avoid disabling IRQs/softirq for the lock, I would be happy=
.
> >
> > How far can we go... could cgroup_rstat_lock be converted to a mutex?
>
> The cgroup_rstat_lock was originally a mutex. It was converted to a
> spinlock in commit 0fa294fb1985 ("group: Replace cgroup_rstat_mutex with
> a spinlock"). Irq was disabled to enable calling from atomic context.
> Since commit 0a2dc6ac3329 ("cgroup: remove
> cgroup_rstat_flush_atomic()"), the rstat API hadn't been called from
> atomic context anymore. Theoretically, we could change it back to a
> mutex or not disabling interrupt. That will require that the API cannot
> be called from atomic context going forward.

I think we should avoid flushing from atomic contexts going forward
anyway tbh. It's just too much work to do with IRQs disabled, and we
observed hard lockups before in worst case scenarios.

I think one problem that was discussed before is that flushing is
exercised from multiple contexts and could have very high concurrency
(e.g. from reclaim when the system is under memory pressure). With a
mutex, the flusher could sleep with the mutex held and block other
threads for a while.

I vaguely recall experimenting locally with changing that lock into a
mutex and not liking the results, but I can't remember much more. I
could be misremembering though.

Currently, the lock is dropped in cgroup_rstat_flush_locked() between
CPU iterations if rescheduling is needed or the lock is being
contended (i.e. spin_needbreak() returns true). I had always wondered
if it's possible to introduce a similar primitive for IRQs? We could
also drop the lock (and re-enable IRQs) if IRQs are pending then.

