Return-Path: <cgroups+bounces-3364-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12739916FB0
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 20:01:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DC71C20C5D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 18:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24329158D84;
	Tue, 25 Jun 2024 18:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EY1S2un9"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447B07F6;
	Tue, 25 Jun 2024 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719338474; cv=none; b=Y5E6UELdVMtwieZGiykufrNyRBndt9cMfieV0gJ46qqUms93j90nb0bA13yH06zF9Z3N46ks+h1lR6Znkd8cXrAK6CqBnErsuhVUyyKA5ZQPE48X06UDDXfnrC4qnQRAvzDVoprLMMgt9E6bcSJYkgd9G/B/v4Gxo2MtWgKL8Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719338474; c=relaxed/simple;
	bh=ADBMDgEeiP/S8p4H1vHGK4c8rRaRkQy8qnEufMKe7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFL8KGnOXUM75bpIisb/cUOepsfxrpKei8S48wnu6vBuUx7W7GfCbPGQti6+dqq4DFi3GZX+sCcx2KT6kcSJI6PDhzFOgWtutHAQu0VwgLWM1STPdfmaTJ8PFaVxFUpJMvrwcSPEjdv2N1M4vP+Dahpxnr0RRCuk3+0/yqarvpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EY1S2un9; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6ad8243dba8so27079776d6.3;
        Tue, 25 Jun 2024 11:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719338472; x=1719943272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OKVfsRel0UqymJCjiuMDxyq3qMswL2LAXIuvmvAZXY=;
        b=EY1S2un9Dj8fpP8XV4wKh3HKTd9zv3vDrGPcuVcNiInGx2ajsgEXLctDkOT7FXty98
         TkMfXScxV8r6MYzuOZNzFoIbAja0sC2+2gRE8xxizSyNRSO4BdZrfK292z3TyvpHNdTP
         jUn/b813ifSu+scDaBspCW94H2hytJ0nIxue1fI8J1K4Nk0DY2VjqA8zQN3k3KaaMWeg
         lZeFgBbKEAUf17jm/WaeaqFAELw5kBXBjHQArG8rJwOB/4PCF8A7nvU3j5yVexJKY1V+
         7LTtfMVn9hYiYyZJrDVapA9ikJ9tA58o3cxRfoFATbCh4L8SeQD+cGbpz8ipBvjGxFFT
         Sgbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719338472; x=1719943272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OKVfsRel0UqymJCjiuMDxyq3qMswL2LAXIuvmvAZXY=;
        b=RSP3v4+pY1ocDMfzie4Trw4xLSD6bcuA6I0A4tXBM0C8aKa7uELHblmaPN60r1NZQC
         zyEPBivNEeRkU0iyvYmWaT+rJ/cklwA9TpiY28XOY+YTK9K8Nh9kCB12FXRhtz9wMucG
         k9lTUH41v60gsRRoaEeZUFBUJLpJR/DgW9Pv2wpIYrDvb+X5QFbtFTBfDBZNgS4RxnEJ
         z+w5wB5DCvuwHw8ks2L8E97GDXKm4v+/5tf9I670rA2cRl0sOxMWYD9LKrvUpp4zxRVa
         iyhEEcnYCVsp7q+seTmvVAJAPl0mF1jJeMi8ugDAzwkyRlxj5uGdHrmuTmKuHCL6PXV9
         765g==
X-Forwarded-Encrypted: i=1; AJvYcCUcZbO5IeXpRH+OGmZg6h/ttlNEiVqvraclB4aP2qFOxgRp0heNYfsNa4hyN6xMsQuS+f1Bj80G5HXpfrpyIgh6HooOXaiLzVh+QVbTfXExYdZ2WNPadHSo8VKf2Uxpyn8FcHljUA==
X-Gm-Message-State: AOJu0YzHRG1qiYtNWDNRW6yR4upDnwq0IWQu7aSyZPPzbhupZsVaaZFi
	O0Vq28EjxpYNBc0PEfH7eaT+S0NPfoHeTqz+tz1P/n1z/0GWFSHX
X-Google-Smtp-Source: AGHT+IGR+3VriOIsjusHT82XFZ5KRZyH2qjQ7pZ8fdSqQFUUebO3ZAvqqMxgzzuOQXGgbjUPnxYbJw==
X-Received: by 2002:ad4:5fc8:0:b0:6b5:42b7:122 with SMTP id 6a1803df08f44-6b542b733c8mr124174736d6.60.1719338471993;
        Tue, 25 Jun 2024 11:01:11 -0700 (PDT)
Received: from fauth2-smtp.messagingengine.com (fauth2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b53df48dedsm29718736d6.67.2024.06.25.11.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 11:01:11 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 8218A1200071;
	Tue, 25 Jun 2024 13:51:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 25 Jun 2024 13:51:50 -0400
X-ME-Sender: <xms:tgN7ZkVtWlBwqIjFlFVKmf4bG8dEj-BpEbA0Vta09QwKVD2rRqWclA>
    <xme:tgN7ZomgPk63Aj5XQO-5z-W98EmgmCoCLusnWq9RFu88T9NhiLOZhygNADx9WbVJs
    GI-oHqQEk7TwsEmsA>
X-ME-Received: <xmr:tgN7ZobIkVheBs-NBGJjlujT8NTJ5AtH_WfpUCpS1X0GLbR1d0U6gSoXWoX9cw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrtddtgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephfetffevueehhfevfefghedvjeekfeeugfefgeevtdehgedvleeuvedvgeet
    ffeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdplhhptgdrvghvvghnthhsnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdo
    mhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejke
    ehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgr
    mhgv
X-ME-Proxy: <xmx:tgN7ZjUxpgR4hBOCITp68DKoGclY8mKupZI075XAsydtWAQhKpdyOg>
    <xmx:tgN7ZulVGNqmY-_sUmNYOvXHU2-rdIOUH_Gajc9Vty57KLBaGC8Ryg>
    <xmx:tgN7ZoeGPnuMK59-PkvP3jeCn02KXzfnPfp3uMVBmfGdKsEjEzW77Q>
    <xmx:tgN7ZgEjji-sjFfqehuG6IvN__R42FK2wMQDG77YaHoGzVuDE7evzg>
    <xmx:tgN7ZkmalB5Al0RCKs8yhCCdyZP2_BUNUzNzYPZf6--NtRfp3RCiKe5H>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jun 2024 13:51:49 -0400 (EDT)
Date: Tue, 25 Jun 2024 10:51:13 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <ZnsDkUySyN7wceXL@boqun-archlinux>
References: <20240622035815.569665-1-leobras@redhat.com>
 <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz>
 <Znn5FgqoCAUAfQhu@boqun-archlinux>
 <ZnoyNQLQdyAcMxjP@LeoBras>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnoyNQLQdyAcMxjP@LeoBras>

On Mon, Jun 24, 2024 at 11:57:57PM -0300, Leonardo Bras wrote:
> On Mon, Jun 24, 2024 at 03:54:14PM -0700, Boqun Feng wrote:
> > On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> > > Hi,
> > > 
> > > you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> > > section in MAINTAINERS so I've added folks from there in my reply.
> > 
> > Thanks!
> > 
> > > Link to full series:
> > > https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/
> > > 
> > 
> > And apologies to Leonardo... I think this is a follow-up of:
> > 
> > 	https://lpc.events/event/17/contributions/1484/
> > 
> > and I did remember we had a quick chat after that which I suggested it's
> > better to change to a different name, sorry that I never found time to
> > write a proper rely to your previous seriese [1] as promised.
> > 
> > [1]: https://lore.kernel.org/lkml/20230729083737.38699-2-leobras@redhat.com/
> 
> That's correct, I commented about this in the end of above presentation.
> Don't worry, and thanks for suggesting the per-cpu naming, it was very 
> helpful on designing this solution.
> 
> > 
> > > On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > > > The problem:
> > > > Some places in the kernel implement a parallel programming strategy
> > > > consisting on local_locks() for most of the work, and some rare remote
> > > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > > kernels, even though the very few remote operations will be expensive due
> > > > to scheduling overhead.
> > > > 
> > > > On the other hand, for RT workloads this can represent a problem: getting
> > > > an important workload scheduled out to deal with remote requests is
> > > > sure to introduce unexpected deadline misses.
> > > > 
> > > > The idea:
> > > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > > > In this case, instead of scheduling work on a remote cpu, it should
> > > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > > work locally. Tha major cost, which is un/locking in every local function,
> > > > already happens in PREEMPT_RT.
> > > 
> > > I've also noticed this a while ago (likely in the context of rewriting SLUB
> > > to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> > > the idea. But I forgot the details about why, so I'll let the the locking
> > > experts reply...
> > > 
> > 
> > I think it's a good idea, especially the new name is less confusing ;-)
> > So I wonder Thomas' thoughts as well.
> 
> Thanks!
> 
> > 
> > And I think a few (micro-)benchmark numbers will help.
> 
> Last year I got some numbers on how replacing local_locks with 
> spinlocks would impact memcontrol.c cache operations:
> 
> https://lore.kernel.org/all/20230125073502.743446-1-leobras@redhat.com/
> 
> tl;dr: It increased clocks spent in the most common this_cpu operations, 
> while reducing clocks spent in remote operations (drain_all_stock).
> 
> In RT case, since local locks are already spinlocks, this cost is 
> already paid, so we can get results like these:
> 
> drain_all_stock
> cpus	Upstream 	Patched		Diff (cycles)	Diff(%)
> 1	44331.10831	38978.03581	-5353.072507	-12.07520567
> 8	43992.96512	39026.76654	-4966.198572	-11.2886198
> 128	156274.6634	58053.87421	-98220.78915	-62.85138425
> 
> Upstream: Clocks to schedule work on remote CPU (performing not accounted)
> Patched:  Clocks to grab remote cpu's spinlock and perform the needed work 
> 	  locally.

This looks good as a micro-benchmark. And it answers why we need patch
#3 in this series. It'll be better if we have something similar for
patch #2 and #4.

Besides, micro-benchmarks are usually a bit artifical IMO, it's better
if we have the data to prove that your changes improve the performance
from a more global view. For example, could you find or create a use
case where flush_slab() becomes somewhat a hot path? And we can then
know the performance gain from your changes in that use case. Maybe
Vlastimil has something in his mind already? ;-)

Also keep in mind that your changes apply to RT, so a natural follow-up
question would be: will it hurt the system latency? I know litte about
this area, so I must defer this to experts.

The above concern brings another opportunity: would it make sense to use
real locks instead of queuing work on a remote CPU in the case when RT
is not needed, but CPU isolation is important? I.e. nohz_full
situations?

> 
> Do you have other suggestions to use as (micro-) benchmarking?
> 

My overall suggestion is that you do find a valuable pattern where
queuing remote work may not be the best option, but usually a real world
usage would make more sense for the extra complexity that we will pay.

Does this make sense?

Regards,
Boqun

> Thanks!
> Leo
> 
> 
> > 
> > Regards,
> > Boqun
> > 
> > > > Also, there is no need to worry about extra cache bouncing:
> > > > The cacheline invalidation already happens due to schedule_work_on().
> > > > 
> > > > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > > > RT workload. 
> > > > 
> > > > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > > > the function locally is much faster than just scheduling it on a
> > > > remote cpu.
> > > > 
> > > > Proposed solution:
> > > > A new interface called Queue PerCPU Work (QPW), which should replace
> > > > Work Queue in the above mentioned use case. 
> > > > 
> > > > If PREEMPT_RT=n, this interfaces just wraps the current 
> > > > local_locks + WorkQueue behavior, so no expected change in runtime.
> > > > 
> > > > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > > > per-cpu structure and perform work on it locally. This is possible
> > > > because on functions that can be used for performing remote work on
> > > > remote per-cpu structures, the local_lock (which is already
> > > > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > > > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > > > 
> > > > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > > > current local_lock + WorkQueue interface by the QPW interface in
> > > > swap, memcontrol & slub interface.
> > > > 
> > > > Please let me know what you think on that, and please suggest
> > > > improvements.
> > > > 
> > > > Thanks a lot!
> > > > Leo
> > > > 
> > > > Leonardo Bras (4):
> > > >   Introducing qpw_lock() and per-cpu queue & flush work
> > > >   swap: apply new queue_percpu_work_on() interface
> > > >   memcontrol: apply new queue_percpu_work_on() interface
> > > >   slub: apply new queue_percpu_work_on() interface
> > > > 
> > > >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> > > >  mm/memcontrol.c     | 20 ++++++-----
> > > >  mm/slub.c           | 26 ++++++++------
> > > >  mm/swap.c           | 26 +++++++-------
> > > >  4 files changed, 127 insertions(+), 33 deletions(-)
> > > >  create mode 100644 include/linux/qpw.h
> > > > 
> > > > 
> > > > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> > > 
> > 
> 

