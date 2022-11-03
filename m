Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 704C26182EF
	for <lists+cgroups@lfdr.de>; Thu,  3 Nov 2022 16:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiKCPc2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Nov 2022 11:32:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbiKCPcI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Nov 2022 11:32:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670641A213;
        Thu,  3 Nov 2022 08:31:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 244D11F88C;
        Thu,  3 Nov 2022 15:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667489508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=StiAt3bag3QhUFoK3wiydM4LWZxj5b1y3vB2+S4EuH0=;
        b=EyTq5zPzhPkGEin16Z865rp96ZWIg3VmFiHEBIYJIJIFhBYzoYKnGEGUINLIyNyt4U7TWr
        JTgzynHcHLiZA9vrK6tguPCHjis/FsA0Au6qV7xNZxoLPKo8wXqfAQv3XW/RC+fq/n85qJ
        lz0G6QQqelu2ZZdew1IE6pFngvh7q5U=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3BBE13AAF;
        Thu,  3 Nov 2022 15:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9DkPOePeY2OGJAAAMHmgww
        (envelope-from <mhocko@suse.com>); Thu, 03 Nov 2022 15:31:47 +0000
Date:   Thu, 3 Nov 2022 16:31:47 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 0/3] Avoid scheduling cache draining to isolated cpus
Message-ID: <Y2Pe45LHANFxxD7B@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
 <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
 <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <07810c49ef326b26c971008fb03adf9dc533a178.camel@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu 03-11-22 11:59:20, Leonardo Brás wrote:
> On Wed, 2022-11-02 at 09:53 +0100, Michal Hocko wrote:
> > On Tue 01-11-22 23:02:40, Leonardo Bras wrote:
> > > Patch #1 expands housekeepíng_any_cpu() so we can find housekeeping cpus
> > > closer (NUMA) to any desired CPU, instead of only the current CPU.
> > > 
> > > ### Performance argument that motivated the change:
> > > There could be an argument of why would that be needed, since the current
> > > CPU is probably acessing the current cacheline, and so having a CPU closer
> > > to the current one is always the best choice since the cache invalidation
> > > will take less time. OTOH, there could be cases like this which uses
> > > perCPU variables, and we can have up to 3 different CPUs touching the
> > > cacheline:
> > > 
> > > C1 - Isolated CPU: The perCPU data 'belongs' to this one
> > > C2 - Scheduling CPU: Schedule some work to be done elsewhere, current cpu
> > > C3 - Housekeeping CPU: This one will do the work
> > > 
> > > Most of the times the cacheline is touched, it should be by C1. Some times
> > > a C2 will schedule work to run on C3, since C1 is isolated.
> > > 
> > > If C1 and C2 are in different NUMA nodes, we could have C3 either in
> > > C2 NUMA node (housekeeping_any_cpu()) or in C1 NUMA node 
> > > (housekeeping_any_cpu_from(C1). 
> > > 
> > > If C3 is in C2 NUMA node, there will be a faster invalidation when C3
> > > tries to get cacheline exclusivity, and then a slower invalidation when
> > > this happens in C1, when it's working in its data.
> > > 
> > > If C3 is in C1 NUMA node, there will be a slower invalidation when C3
> > > tries to get cacheline exclusivity, and then a faster invalidation when
> > > this happens in C1.
> > > 
> > > The thing is: it should be better to wait less when doing kernel work
> > > on an isolated CPU, even at the cost of some housekeeping CPU waiting
> > > a few more cycles.
> > > ###
> > > 
> > > Patch #2 changes the locking strategy of memcg_stock_pcp->stock_lock from
> > > local_lock to spinlocks, so it can be later used to do remote percpu
> > > cache draining on patch #3. Most performance concerns should be pointed
> > > in the commit log.
> > > 
> > > Patch #3 implements the remote per-CPU cache drain, making use of both 
> > > patches #2 and #3. Performance-wise, in non-isolated scenarios, it should
> > > introduce an extra function call and a single test to check if the CPU is
> > > isolated. 
> > > 
> > > On scenarios with isolation enabled on boot, it will also introduce an
> > > extra test to check in the cpumask if the CPU is isolated. If it is,
> > > there will also be an extra read of the cpumask to look for a
> > > housekeeping CPU.
> > 
> 
> Hello Michael, thanks for reviewing!
> 
> > This is a rather deep dive in the cache line usage but the most
> > important thing is really missing. Why do we want this change? From the
> > context it seems that this is an actual fix for isolcpu= setup when
> > remote (aka non isolated activity) interferes with isolated cpus by
> > scheduling pcp charge caches on those cpus.
> > 
> > Is this understanding correct?
> 
> That's correct! The idea is to avoid scheduling work to isolated CPUs.
> 
> > If yes, how big of a problem that is?
> 
> The use case I have been following requires both isolcpus= and PREEMPT_RT, since
> the isolated CPUs will be running a real-time workload. In this scenario,
> getting any work done instead of the real-time workload may cause the system to
> miss a deadline, which can be bad. 

OK, I see. But is memcg charging actually a RT friendly operation in the
first place? Please note that this path can trigger memory reclaim and
that is when any RT expectations are simply going down the drain.

> >  If you want a remote draining then
> > you need some sort of locking (currently we rely on local lock). How
> > come this locking is not going to cause a different form of disturbance?
> 
> If I did everything right, most of the extra work should be done either in non-
> isolated (housekeeping) CPUs, or during a syscall. I mean, the pcp charge caches
> will be happening on a housekeeping CPU, and the locking cost should be paid
> there as we want to avoid doing that in the isolated CPUs. 
> 
> I understand there will be a locking cost being paid in the isolated CPUs when:
> a) The isolated CPU is requesting the stock drain,
> b) When the isolated CPUs do a syscall and end up using the protected structure
> the first time after a remote drain.

And anytime the charging path (consume_stock resp. refill_stock)
contends with the remote draining which is out of control of the RT
task. It is true that the RT kernel will turn that spin lock into a
sleeping RT lock and that could help with potential priority inversions
but still quite costly thing I would expect.

> Both (a) and (b) should happen during a syscall, and IIUC the a rt workload
> should not expect the syscalls to be have a predictable time, so it should be
> fine.

Now I am not sure I understand. If you do not consider charging path to
be RT sensitive then why is this needed in the first place? What else
would be populating the pcp cache on the isolated cpu? IRQs?
-- 
Michal Hocko
SUSE Labs
