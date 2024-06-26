Return-Path: <cgroups+bounces-3379-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E069187AE
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 18:44:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EF46B26B49
	for <lists+cgroups@lfdr.de>; Wed, 26 Jun 2024 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E240E18FC65;
	Wed, 26 Jun 2024 16:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1s2rQSQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC47E18EFCA
	for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719420074; cv=none; b=YOcNowAA/I3of/nLGVLvicB2k0m1Y22y94WFuuVLHwLlMuEO11UYejCyx3lRojvuPQkOdaTHJGWAnKxu8rAAFf3tOcPbsa4ASSDX4Q+Y/hxqtoBMXiHrThZJuPGDBotWBcrrtXExZEb58st+V3ZVI3lcLkjb/ODYaZAucF+d/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719420074; c=relaxed/simple;
	bh=/WQ3OaztmHFfzBrD7l6U0dpSvqk8mC1x1hg9HWRC5j4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Disposition; b=n8T2ykHlcssxEMHp7M048VOToG2dbYtxTaV7wEr2ukJSehHUsMDJQWzjxkNw0oS9uXRH+rSUXzXVZbIdcHw0gYKd5xwd/IJHLuMzVvaZLVbslcOVg5EN3jCc/n5eWP8LX367NdaTUAJyXyf24Qhi6dgsfXnZJ5R2u68NX1a3YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1s2rQSQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719420072;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SXUwtxTbrBMkuEh7ZhTkYnknohnmSpVAbY4/OdO5pyQ=;
	b=h1s2rQSQc07ZXhITp5yjOpJ1K5teb1skNLRpsqjqdGrs5Ax4GlV34TyuG6s8P8Rm7ad7uy
	xLNGkKlGHmYiYQ3vXqYfRaAlTbP8qk1chZ2qLTd8SsX6eqyL2QJRnCIiUIYi8GVHaPbd1G
	PlpmEK8I0fn93MofkrmqsyBhy1wDrk0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-K6d1bOYHNlmcb_R9SZbHvg-1; Wed, 26 Jun 2024 12:41:07 -0400
X-MC-Unique: K6d1bOYHNlmcb_R9SZbHvg-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1f9cd1889f6so69170385ad.3
        for <cgroups@vger.kernel.org>; Wed, 26 Jun 2024 09:41:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719420066; x=1720024866;
        h=content-transfer-encoding:content-disposition:mime-version
         :references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SXUwtxTbrBMkuEh7ZhTkYnknohnmSpVAbY4/OdO5pyQ=;
        b=JcRUC0dtVRL4MeIEpTR0JbEZqJ1jMRCmmA85ljiniAIpCL3A/y51z6Nv4BFDvEhThW
         CPhUqey3Mf0x7mwYfi1/0cUVkOxKXcu+pO8Qa5bbHeNVXbVDwZ8v/+rmY4LOqMIcy6zX
         zK0bPaG+22UUyceG5d9+sI5s8T/1Hli4ucbToQssbDMqjj74am8RT2u9N3WqkDMhNmID
         BfsUewSUkpAxVkegE8CbN9rUM5q6ftzBIPb01ucQqh5gNiojpGNI1l42YZ2XXu/gKEMy
         jfWgx8JUFvcUVDmauUXnmX5/jNNPQFe0q1qvpplHJqixZ0Gy/q1+f60F3qyjbS7m4uBG
         WPtw==
X-Forwarded-Encrypted: i=1; AJvYcCUjrdnNuYTYIeSIVSrnp5kGQVPPSTFSFI8vLyAjFu6u7Ldqb1DKk1w5AG4y2MyTLzuI757zTbKjnlQP5Oc/4G0Eqb8IF1kvfw==
X-Gm-Message-State: AOJu0YzZxR4XOD9Hj6q50IYpUZf61/jowboKpDYmgRQ1MDVFw21rAFb+
	2bgL9s4SUzhrbklpPrczLWM+RgKpfw8v571GUlMW7bbLtAJnVmF2/irIqlw1Z6gq8jXENKnmgGF
	YkInG1NJ82pLZf1jnNGVxWpO+9++A7OoqzgAa3kxbzuN6bui2DLme2Zg=
X-Received: by 2002:a17:903:230e:b0:1f9:c3a1:4b65 with SMTP id d9443c01a7336-1fa23f1d44bmr138641615ad.47.1719420065845;
        Wed, 26 Jun 2024 09:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCaTYOKs2Ux/aqIZMlC+EQjqEMduaXKZxoJs8ugjE3ssWqOYadfj7QDv8/UQrNvRwhBEVSyw==
X-Received: by 2002:a17:903:230e:b0:1f9:c3a1:4b65 with SMTP id d9443c01a7336-1fa23f1d44bmr138641175ad.47.1719420065343;
        Wed, 26 Jun 2024 09:41:05 -0700 (PDT)
Received: from localhost.localdomain ([2804:1b3:a801:fda9:d11e:3755:61da:97fd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f9eb2f042dsm101829265ad.39.2024.06.26.09.40.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 09:41:04 -0700 (PDT)
From: Leonardo Bras <leobras@redhat.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Leonardo Bras <leobras@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Date: Wed, 26 Jun 2024 13:40:34 -0300
Message-ID: <ZnxEguTZCIniJRoi@LeoBras>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <ZnsDkUySyN7wceXL@boqun-archlinux>
References: <20240622035815.569665-1-leobras@redhat.com> <261612b9-e975-4c02-a493-7b83fa17c607@suse.cz> <Znn5FgqoCAUAfQhu@boqun-archlinux> <ZnoyNQLQdyAcMxjP@LeoBras> <ZnsDkUySyN7wceXL@boqun-archlinux>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Jun 25, 2024 at 10:51:13AM -0700, Boqun Feng wrote:
> On Mon, Jun 24, 2024 at 11:57:57PM -0300, Leonardo Bras wrote:
> > On Mon, Jun 24, 2024 at 03:54:14PM -0700, Boqun Feng wrote:
> > > On Mon, Jun 24, 2024 at 09:31:51AM +0200, Vlastimil Babka wrote:
> > > > Hi,
> > > > 
> > > > you've included tglx, which is great, but there's also LOCKING PRIMITIVES
> > > > section in MAINTAINERS so I've added folks from there in my reply.
> > > 
> > > Thanks!
> > > 
> > > > Link to full series:
> > > > https://lore.kernel.org/all/20240622035815.569665-1-leobras@redhat.com/
> > > > 
> > > 
> > > And apologies to Leonardo... I think this is a follow-up of:
> > > 
> > > 	https://lpc.events/event/17/contributions/1484/
> > > 
> > > and I did remember we had a quick chat after that which I suggested it's
> > > better to change to a different name, sorry that I never found time to
> > > write a proper rely to your previous seriese [1] as promised.
> > > 
> > > [1]: https://lore.kernel.org/lkml/20230729083737.38699-2-leobras@redhat.com/
> > 
> > That's correct, I commented about this in the end of above presentation.
> > Don't worry, and thanks for suggesting the per-cpu naming, it was very 
> > helpful on designing this solution.
> > 
> > > 
> > > > On 6/22/24 5:58 AM, Leonardo Bras wrote:
> > > > > The problem:
> > > > > Some places in the kernel implement a parallel programming strategy
> > > > > consisting on local_locks() for most of the work, and some rare remote
> > > > > operations are scheduled on target cpu. This keeps cache bouncing low since
> > > > > cacheline tends to be mostly local, and avoids the cost of locks in non-RT
> > > > > kernels, even though the very few remote operations will be expensive due
> > > > > to scheduling overhead.
> > > > > 
> > > > > On the other hand, for RT workloads this can represent a problem: getting
> > > > > an important workload scheduled out to deal with remote requests is
> > > > > sure to introduce unexpected deadline misses.
> > > > > 
> > > > > The idea:
> > > > > Currently with PREEMPT_RT=y, local_locks() become per-cpu spinlocks.
> > > > > In this case, instead of scheduling work on a remote cpu, it should
> > > > > be safe to grab that remote cpu's per-cpu spinlock and run the required
> > > > > work locally. Tha major cost, which is un/locking in every local function,
> > > > > already happens in PREEMPT_RT.
> > > > 
> > > > I've also noticed this a while ago (likely in the context of rewriting SLUB
> > > > to use local_lock) and asked about it on IRC, and IIRC tglx wasn't fond of
> > > > the idea. But I forgot the details about why, so I'll let the the locking
> > > > experts reply...
> > > > 
> > > 
> > > I think it's a good idea, especially the new name is less confusing ;-)
> > > So I wonder Thomas' thoughts as well.
> > 
> > Thanks!
> > 
> > > 
> > > And I think a few (micro-)benchmark numbers will help.
> > 
> > Last year I got some numbers on how replacing local_locks with 
> > spinlocks would impact memcontrol.c cache operations:
> > 
> > https://lore.kernel.org/all/20230125073502.743446-1-leobras@redhat.com/
> > 
> > tl;dr: It increased clocks spent in the most common this_cpu operations, 
> > while reducing clocks spent in remote operations (drain_all_stock).
> > 
> > In RT case, since local locks are already spinlocks, this cost is 
> > already paid, so we can get results like these:
> > 
> > drain_all_stock
> > cpus	Upstream 	Patched		Diff (cycles)	Diff(%)
> > 1	44331.10831	38978.03581	-5353.072507	-12.07520567
> > 8	43992.96512	39026.76654	-4966.198572	-11.2886198
> > 128	156274.6634	58053.87421	-98220.78915	-62.85138425
> > 
> > Upstream: Clocks to schedule work on remote CPU (performing not accounted)
> > Patched:  Clocks to grab remote cpu's spinlock and perform the needed work 
> > 	  locally.
> 
> This looks good as a micro-benchmark. And it answers why we need patch
> #3 in this series. It'll be better if we have something similar for
> patch #2 and #4.

I suppose that given the parallel programming scheme is the same, the 
results tend to be similar, but sure, I can provide such tests.

> 
> Besides, micro-benchmarks are usually a bit artifical IMO, it's better
> if we have the data to prove that your changes improve the performance
> from a more global view. For example, could you find or create a use
> case where flush_slab() becomes somewhat a hot path? And we can then
> know the performance gain from your changes in that use case. Maybe
> Vlastimil has something in his mind already? ;-)
> 
> Also keep in mind that your changes apply to RT, so a natural follow-up
> question would be: will it hurt the system latency? I know litte about
> this area, so I must defer this to experts.

While we notice some performance improvements, the whole deal of this 
patchset is not to gain performance, but to reduce latency:

When we call schedule_work_on() or queue_work_on(), we end up having a 
processor being interrupted (IPI) to deal with the required work. If this 
processor is running a RT task, it introduces latency. 

So by removing some of those IPIs we have a noticeable reduction in max 
latency, in tests such as cyclictest and oslat. Maybe it's a good idea to 
include those in this cover letter.
	
> 
> The above concern brings another opportunity: would it make sense to use
> real locks instead of queuing work on a remote CPU in the case when RT
> is not needed, but CPU isolation is important? I.e. nohz_full
> situations?

By having this qpw interface, that is easily achievable: 
We can add a kernel parameter that makes qpw_*locks use spinlocks if 
isolation is enabled. Even though this could be an static branch, this 
would cost some overhead in non-isolated + non-RT though.
But in any case, I am open on implementing this if there is an use-case.

> 
> > 
> > Do you have other suggestions to use as (micro-) benchmarking?
> > 
> 
> My overall suggestion is that you do find a valuable pattern where
> queuing remote work may not be the best option, but usually a real world
> usage would make more sense for the extra complexity that we will pay.
> 
> Does this make sense?

Yes, it does. There are scenarios which will cause a lot of queue_work_on, 
and this patchset would increase performance in RT. I think Marcelo showed 
me some example a while ago in mm/.

But my goal would be just to show that this change does not increase 
overhead, actually can have some improvements in RT, and achieves latency 
reduction which is the desired feature.


Thanks!
Leo

> 
> Regards,
> Boqun
> 
> > Thanks!
> > Leo
> > 
> > 
> > > 
> > > Regards,
> > > Boqun
> > > 
> > > > > Also, there is no need to worry about extra cache bouncing:
> > > > > The cacheline invalidation already happens due to schedule_work_on().
> > > > > 
> > > > > This will avoid schedule_work_on(), and thus avoid scheduling-out an 
> > > > > RT workload. 
> > > > > 
> > > > > For patches 2, 3 & 4, I noticed just grabing the lock and executing
> > > > > the function locally is much faster than just scheduling it on a
> > > > > remote cpu.
> > > > > 
> > > > > Proposed solution:
> > > > > A new interface called Queue PerCPU Work (QPW), which should replace
> > > > > Work Queue in the above mentioned use case. 
> > > > > 
> > > > > If PREEMPT_RT=n, this interfaces just wraps the current 
> > > > > local_locks + WorkQueue behavior, so no expected change in runtime.
> > > > > 
> > > > > If PREEMPT_RT=y, queue_percpu_work_on(cpu,...) will lock that cpu's
> > > > > per-cpu structure and perform work on it locally. This is possible
> > > > > because on functions that can be used for performing remote work on
> > > > > remote per-cpu structures, the local_lock (which is already
> > > > > a this_cpu spinlock()), will be replaced by a qpw_spinlock(), which
> > > > > is able to get the per_cpu spinlock() for the cpu passed as parameter.
> > > > > 
> > > > > Patch 1 implements QPW interface, and patches 2, 3 & 4 replaces the
> > > > > current local_lock + WorkQueue interface by the QPW interface in
> > > > > swap, memcontrol & slub interface.
> > > > > 
> > > > > Please let me know what you think on that, and please suggest
> > > > > improvements.
> > > > > 
> > > > > Thanks a lot!
> > > > > Leo
> > > > > 
> > > > > Leonardo Bras (4):
> > > > >   Introducing qpw_lock() and per-cpu queue & flush work
> > > > >   swap: apply new queue_percpu_work_on() interface
> > > > >   memcontrol: apply new queue_percpu_work_on() interface
> > > > >   slub: apply new queue_percpu_work_on() interface
> > > > > 
> > > > >  include/linux/qpw.h | 88 +++++++++++++++++++++++++++++++++++++++++++++
> > > > >  mm/memcontrol.c     | 20 ++++++-----
> > > > >  mm/slub.c           | 26 ++++++++------
> > > > >  mm/swap.c           | 26 +++++++-------
> > > > >  4 files changed, 127 insertions(+), 33 deletions(-)
> > > > >  create mode 100644 include/linux/qpw.h
> > > > > 
> > > > > 
> > > > > base-commit: 50736169ecc8387247fe6a00932852ce7b057083
> > > > 
> > > 
> > 
> 


