Return-Path: <cgroups+bounces-8870-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBD03B0E47B
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 21:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BCA16345A
	for <lists+cgroups@lfdr.de>; Tue, 22 Jul 2025 19:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9B9244679;
	Tue, 22 Jul 2025 19:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fB4uUC3C"
X-Original-To: cgroups@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AC327CB04
	for <cgroups@vger.kernel.org>; Tue, 22 Jul 2025 19:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753214193; cv=none; b=SXGXkubA9U6APwH2y4VPwUUdATmZwyU269g5KcCsOQM5u+y/iv62XWaKpQWGWIXLkUlhuwoFQ8Zvp24nljTylfWUUY92VyF7jIPhDwnjMdsagCC4G6hEsjthLbk6ZgWo9Dyu4DhQU/HwrKjN8Rgx5/0lN+xnkGNykKb6NlGUXr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753214193; c=relaxed/simple;
	bh=Wc1U5Vzh9lNoQtPH1Ue5Z8ymhPuP4KoTJS0D6fmZJ+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z8RPf6cCGUAZB5yKYNHiLSYQnsNLsefk9r8smdpyiYYcp0D0AtwYbg3ByDjiaymDw1261a05a/HnJC9WstDQAsGEvhEhIruUDkCpMf8xRDY9LLZ16GY1AauGGUphNKAIN4WG9N55x+abdEyMYEzX4R2hN6VH2WGnR/AJibBm3js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fB4uUC3C; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 22 Jul 2025 12:56:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753214185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AXWJpOE0ioSzjIOOhzGMWDhyF2zmDNKzi4GlW9Rwppo=;
	b=fB4uUC3C9EsMYzQAhmDN3jh97gz3KD0V5/k59Mrg+UJ45xI8+h/RkdiTDGu6YOzRovTJwm
	a1DiSXgOSPK+br4PQa6lD9H3NO2FpLWstorUhwEvlGYINWIUDpTVEwo0u3ICr045l4gbBH
	0FOePTuhlvWdYxqq2ct/NaVHUefVjIE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Matthieu Baerts <matttbe@kernel.org>, 
	Mat Martineau <martineau@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, Simon Horman <horms@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 net-next 13/13] net-memcg: Allow decoupling memcg from
 global protocol memory accounting.
Message-ID: <xjtbk6g2a3x26sqqrdxbm2vxgxmm3nfaryxlxwipwohsscg7qg@64ueif57zont>
References: <20250721203624.3807041-1-kuniyu@google.com>
 <20250721203624.3807041-14-kuniyu@google.com>
 <z7kkbenhkndwyghwenwk6c4egq3ky4zl36qh3gfiflfynzzojv@qpcazlpe3l7b>
 <CANn89iLg-VVWqbWvLg__Zz=HqHpQzk++61dbOyuazSah7kWcDg@mail.gmail.com>
 <jc6z5d7d26zunaf6b4qtwegdoljz665jjcigb4glkb6hdy6ap2@2gn6s52s6vfw>
 <CAAVpQUAJCLaOr7DnOH9op8ySFN_9Ky__easoV-6E=scpRaUiJQ@mail.gmail.com>
 <p4fcser5zrjm4ut6lw4ejdr7gn2gejrlhy2u2btmhajiiheoax@ptacajypnvlw>
 <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAVpQUAk4F__D7xdWpt0SEE4WEM_-6V1P7DUw9TGaV=pxZ+tgw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Jul 22, 2025 at 12:03:48PM -0700, Kuniyuki Iwashima wrote:
> On Tue, Jul 22, 2025 at 11:48 AM Shakeel Butt <shakeel.butt@linux.dev> wrote:
> >
> > On Tue, Jul 22, 2025 at 11:18:40AM -0700, Kuniyuki Iwashima wrote:
> > > >
> > > > I expect this state of jobs with different network accounting config
> > > > running concurrently is temporary while the migrationg from one to other
> > > > is happening. Please correct me if I am wrong.
> > >
> > > We need to migrate workload gradually and the system-wide config
> > > does not work at all.  AFAIU, there are already years of effort spent
> > > on the migration but it's not yet completed at Google.  So, I don't think
> > > the need is temporary.
> > >
> >
> > From what I remembered shared borg had completely moved to memcg
> > accounting of network memory (with sys container as an exception) years
> > ago. Did something change there?
> 
> AFAICS, there are some workloads that opted out from memcg and
> consumed too much tcp memory due to tcp_mem=UINT_MAX, triggering
> OOM and disrupting other workloads.
> 

What were the reasons behind opting out? We should fix those
instead of a permanent opt-out option.

> >
> > > >
> > > > My main concern with the memcg knob is that it is permanent and it
> > > > requires a hierarchical semantics. No need to add a permanent interface
> > > > for a temporary need and I don't see a clear hierarchical semantic for
> > > > this interface.
> > >
> > > I don't see merits of having hierarchical semantics for this knob.
> > > Regardless of this knob, hierarchical semantics is guaranteed
> > > by other knobs.  I think such semantics for this knob just complicates
> > > the code with no gain.
> > >
> >
> > Cgroup interfaces are hierarchical and we want to keep it that way.
> > Putting non-hierarchical interfaces just makes configuration and setup
> > hard to reason about.
> 
> Actually, I tried that way in the initial draft version, but even if the
> parent's knob is 1 and child one is 0, a harmful scenario didn't come
> to my mind.
> 

It is not just about harmful scenario but more about clear semantics.
Check memory.zswap.writeback semantics.

> 
> >
> > >
> > > >
> > > > I am wondering if alternative approches for per-workload settings are
> > > > explore starting with BPF.
> > > >
> >
> > Any response on the above? Any alternative approaches explored?
> 
> Do you mean flagging each socket by BPF at cgroup hook ?

Not sure. Will it not be very similar to your current approach? Each
socket is associated with a memcg and the at the place where you need to
check which accounting method to use, just check that memcg setting in
bpf and you can cache the result in socket as well.

> 
> I think it's overkill and we don't need such finer granularity.
> 
> Also it sounds way too hacky to use BPF to correct the weird
> behaviour from day0.

What weird behavior? Two accounting mechanisms. Yes I agree but memcgs
with different accounting mechanisms concurrently is also weird.

> We should have more generic way to
> control that.  I know this functionality is helpful for some workloads
> at Amazon as well.

The reason I am against this permanent opt-out interface is if we add
this interface then we will never fix the underlying issues blocking the
full conversion to memcg accounting of network memory. I am ok with some
temporary measures to allow opt-out impacted workload until the
underlying issue is fixed.




