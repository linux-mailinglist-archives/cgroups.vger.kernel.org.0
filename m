Return-Path: <cgroups+bounces-3456-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A20EC91C60C
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 20:48:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56AF01F24D87
	for <lists+cgroups@lfdr.de>; Fri, 28 Jun 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECFC4D8A4;
	Fri, 28 Jun 2024 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ev1KWy5x"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C779C2E633
	for <cgroups@vger.kernel.org>; Fri, 28 Jun 2024 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719600492; cv=none; b=soioTc0/lIAqvCniA14JNgX+uMHP8IfR6PWuQ0OBdvrgvJNfRCxoieKQdyySjDIW68X2QDu7TyTgcU1NDa5CuyrglFh1n/r6TsuuyM1lW3+dbHuzYbYvsixrR7FRRseQKWLGvCCkl+gpLvnQ2NkAz+L2OA9ABQiNj61vq6Q3uvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719600492; c=relaxed/simple;
	bh=7QRMtpyROH1I0Ue3wwqfR+H6npMHbd5QT1sp7Y7YZJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ce4vQ93y/44G15kKXKkr+asf+Bb0XvDS0llQTzHfmZu+ZefWl5vR51gY5hcnxXzEWhTEMccX2PGyjaJED3MDleyF/jmEFttzFmZYD0ND41jaogyUzEZaAZ3jVSFvDd3PYWA+jP9dzNMMwyjRWyjplC9EPYdWrHAv2WjtLlynV0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ev1KWy5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719600489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BPNBPdx6rKTE521JsYRdhS1BYG1MBCkTdE7R8C6b+Es=;
	b=ev1KWy5xyLPKgwTueFUsS+spW5V5KTAxRW4zQJvEL2qVyaZkvlDoRMDPCYkv+hEjzjwzge
	QQnMPcDkllyeWYyLuNCeo0iK41+x+03DUy8qrrKI2yvmDqbsts+sps8qLkKDxhCfn0hAPb
	3SVp2aCVMv+XcxC789AIiDueZao7Z9k=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-210-ev6LzQVgNKmG0zzlGO3LLA-1; Fri,
 28 Jun 2024 14:48:06 -0400
X-MC-Unique: ev6LzQVgNKmG0zzlGO3LLA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4F6E419560AA;
	Fri, 28 Jun 2024 18:48:03 +0000 (UTC)
Received: from tpad.localdomain (unknown [10.96.133.3])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3EB9E1955BD4;
	Fri, 28 Jun 2024 18:48:01 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
	id E1B78400E5C3B; Fri, 28 Jun 2024 15:47:38 -0300 (-03)
Date: Fri, 28 Jun 2024 15:47:38 -0300
From: Marcelo Tosatti <mtosatti@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Vlastimil Babka <vbabka@suse.cz>,
	Johannes Weiner <hannes@cmpxchg.org>,
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
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 0/4] Introduce QPW for per-cpu operations
Message-ID: <Zn8FSqqoLIIB/LnG@tpad>
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
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

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
> 
> Do you have other suggestions to use as (micro-) benchmarking?
> 
> Thanks!
> Leo

One improvement which was noted when mm/page_alloc.c was converted to 
spinlock + remote drain was that, it can bypass waiting for kwork 
to be scheduled (on heavily loaded CPUs).

commit 443c2accd1b6679a1320167f8f56eed6536b806e
Author: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Date:   Fri Jun 24 13:54:22 2022 +0100

    mm/page_alloc: remotely drain per-cpu lists
    
    Some setups, notably NOHZ_FULL CPUs, are too busy to handle the per-cpu
    drain work queued by __drain_all_pages().  So introduce a new mechanism to
    remotely drain the per-cpu lists.  It is made possible by remotely locking
    'struct per_cpu_pages' new per-cpu spinlocks.  A benefit of this new
    scheme is that drain operations are now migration safe.
    
    There was no observed performance degradation vs.  the previous scheme.
    Both netperf and hackbench were run in parallel to triggering the
    __drain_all_pages(NULL, true) code path around ~100 times per second.  The
    new scheme performs a bit better (~5%), although the important point here
    is there are no performance regressions vs.  the previous mechanism.
    Per-cpu lists draining happens only in slow paths.
    
    Minchan Kim tested an earlier version and reported;
    
            My workload is not NOHZ CPUs but run apps under heavy memory
            pressure so they goes to direct reclaim and be stuck on
            drain_all_pages until work on workqueue run.
    
            unit: nanosecond
            max(dur)        avg(dur)                count(dur)
            166713013       487511.77786438033      1283
    
            From traces, system encountered the drain_all_pages 1283 times and
            worst case was 166ms and avg was 487us.
    
            The other problem was alloc_contig_range in CMA. The PCP draining
            takes several hundred millisecond sometimes though there is no
            memory pressure or a few of pages to be migrated out but CPU were
            fully booked.
    
            Your patch perfectly removed those wasted time.


