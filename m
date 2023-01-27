Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840AC67DCDF
	for <lists+cgroups@lfdr.de>; Fri, 27 Jan 2023 05:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbjA0EjE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Jan 2023 23:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjA0EjD (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Jan 2023 23:39:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C707D39CD1
        for <cgroups@vger.kernel.org>; Thu, 26 Jan 2023 20:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674794293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8CP3YQJy/1BqI0NOeozKEh6zQUilSGJ56jPhvOdxgCg=;
        b=WkUjKQ0TOKG6Ayu8Csy4oLzrPAc76BS3zy8eIJBaab7Ffx7FVFmBRdnkJT/nPEmVwubue/
        OtNZVftjzSYyWUL3Oep5OODYzNFbldAi4EKxIQiNcy+d0FKAyPJfseolxJ925k2vsxB5nO
        ANBBEJym0EV5cnGWvcHsKbmBBmLhHSY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-5yczKWEpPFuzhKGqukOaPg-1; Thu, 26 Jan 2023 23:38:06 -0500
X-MC-Unique: 5yczKWEpPFuzhKGqukOaPg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2981C80D0E6;
        Fri, 27 Jan 2023 04:38:06 +0000 (UTC)
Received: from tpad.localdomain (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B27824014CE2;
        Fri, 27 Jan 2023 04:38:05 +0000 (UTC)
Received: by tpad.localdomain (Postfix, from userid 1000)
        id 9D38042627607; Thu, 26 Jan 2023 21:32:18 -0300 (-03)
Date:   Thu, 26 Jan 2023 21:32:18 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y9MbkuBDI+08AtgN@tpad>
References: <20230125073502.743446-1-leobras@redhat.com>
 <Y9DpbVF+JR/G+5Or@dhcp22.suse.cz>
 <9e61ab53e1419a144f774b95230b789244895424.camel@redhat.com>
 <Y9FzSBw10MGXm2TK@tpad>
 <Y9G36AiqPPFDlax3@P9FQF9L96D.corp.robot.car>
 <Y9Iurktut9B9T+Tl@dhcp22.suse.cz>
 <Y9LAf4pRyClZ1vfx@tpad>
 <Y9LSjnNEEUiF/70R@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9LSjnNEEUiF/70R@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jan 26, 2023 at 08:20:46PM +0100, Michal Hocko wrote:
> On Thu 26-01-23 15:03:43, Marcelo Tosatti wrote:
> > On Thu, Jan 26, 2023 at 08:41:34AM +0100, Michal Hocko wrote:
> > > On Wed 25-01-23 15:14:48, Roman Gushchin wrote:
> > > > On Wed, Jan 25, 2023 at 03:22:00PM -0300, Marcelo Tosatti wrote:
> > > > > On Wed, Jan 25, 2023 at 08:06:46AM -0300, Leonardo Brás wrote:
> > > > > > On Wed, 2023-01-25 at 09:33 +0100, Michal Hocko wrote:
> > > > > > > On Wed 25-01-23 04:34:57, Leonardo Bras wrote:
> > > > > > > > Disclaimer:
> > > > > > > > a - The cover letter got bigger than expected, so I had to split it in
> > > > > > > >     sections to better organize myself. I am not very confortable with it.
> > > > > > > > b - Performance numbers below did not include patch 5/5 (Remove flags
> > > > > > > >     from memcg_stock_pcp), which could further improve performance for
> > > > > > > >     drain_all_stock(), but I could only notice the optimization at the
> > > > > > > >     last minute.
> > > > > > > > 
> > > > > > > > 
> > > > > > > > 0 - Motivation:
> > > > > > > > On current codebase, when drain_all_stock() is ran, it will schedule a
> > > > > > > > drain_local_stock() for each cpu that has a percpu stock associated with a
> > > > > > > > descendant of a given root_memcg.
> > > > 
> > > > Do you know what caused those drain_all_stock() calls? I wonder if we should look
> > > > into why we have many of them and whether we really need them?
> > > > 
> > > > It's either some user's actions (e.g. reducing memory.max), either some memcg
> > > > is entering pre-oom conditions. In the latter case a lot of drain calls can be
> > > > scheduled without a good reason (assuming the cgroup contain multiple tasks running
> > > > on multiple cpus).
> > > 
> > > I believe I've never got a specific answer to that. We
> > > have discussed that in the previous version submission
> > > (20221102020243.522358-1-leobras@redhat.com and specifically
> > > Y2TQLavnLVd4qHMT@dhcp22.suse.cz). Leonardo has mentioned a mix of RT and
> > > isolcpus. I was wondering about using memcgs in RT workloads because
> > > that just sounds weird but let's say this is the case indeed. 
> > 
> > This could be the case. You can consider an "edge device" where it is
> > necessary to run a RT workload. It might also be useful to run 
> > non realtime applications on the same system.
> > 
> > > Then an RT task or whatever task that is running on an isolated
> > > cpu can have pcp charges.
> > 
> > Usually the RT task (or more specifically the realtime sensitive loop
> > of the application) runs entirely on userspace. But i suppose there
> > could be charges on application startup.
> 
> What is the role of memcg then? If the memory limit is in place and the
> workload doesn't fit in then it will get reclaimed during start up and
> memory would need to be refaulted if not mlocked. If it is mlocked then
> the limit cannot be enforced and the start up would likely fail as a
> result of the memcg oom killer.

1) Application which is not time sensitive executes on isolated CPU,
with memcg control enabled. Per-CPU stock is created.

2) App with memcg control enabled exits, per-CPU stock is not drained.

3) Latency sensitive application starts, isolated per-CPU has stock to
be drained, and:

/*
 * Drains all per-CPU charge caches for given root_memcg resp. subtree
 * of the hierarchy under it.
 */
static void drain_all_stock(struct mem_cgroup *root_memcg)
{
        int cpu, curcpu;

        /* If someone's already draining, avoid adding running more workers. */
        if (!mutex_trylock(&percpu_charge_mutex))
                return;
        /*
         * Notify other cpus that system-wide "drain" is running
         * We do not care about races with the cpu hotplug because cpu down
         * as well as workers from this path always operate on the local
         * per-cpu data. CPU up doesn't touch memcg_stock at all.
         */
        migrate_disable();
        curcpu = smp_processor_id();
        for_each_online_cpu(cpu) {
                struct memcg_stock_pcp *stock = &per_cpu(memcg_stock, cpu);
                struct mem_cgroup *memcg;
                bool flush = false;

                rcu_read_lock();
                memcg = stock->cached;
                if (memcg && stock->nr_pages &&
                    mem_cgroup_is_descendant(memcg, root_memcg))
                        flush = true;
                else if (obj_stock_flush_required(stock, root_memcg))
                        flush = true;
                rcu_read_unlock();

                if (flush &&
                    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
                        if (cpu == curcpu)
                                drain_local_stock(&stock->work);
                        else
                                schedule_work_on(cpu, &stock->work);
                }
        }
        migrate_enable();
        mutex_unlock(&percpu_charge_mutex);
}

> [...]
> > > > Overall I'm somewhat resistant to an idea of making generic allocation & free paths slower
> > > > for an improvement of stock draining. It's not a strong objection, but IMO we should avoid
> > > > doing this without a really strong reason.
> > > 
> > > Are you OK with a simple opt out on isolated CPUs? That would make
> > > charges slightly slower (atomic on the hierarchy counters vs. a single
> > > pcp adjustment) but it would guarantee that the isolated workload is
> > > predictable which is the primary objective AFAICS.
> > 
> > This would make isolated CPUs "second class citizens": it would be nice
> > to be able to execute non realtime apps on isolated CPUs as well
> > (think of different periods of time during a day, one where 
> > more realtime apps are required, another where less 
> > realtime apps are required).
> 
> An alternative requires to make the current implementation that is
> lockless to use locks and introduce potential lock contention. This
> could be harmful to regular workloads. Not using pcp caching would make
> a fast path using few atomics rather than local pcp update. That is not
> a terrible cost to pay for special cased workloads which use isolcpus.
> Really we are not talking about a massive cost to be payed. At least
> nobody has shown that in any numbers.
> 
> > Concrete example: think of a computer handling vRAN traffic near a 
> > cell tower. The traffic (therefore amount of processing required
> > by realtime applications) might vary during the day.
> > 
> > User might want to run containers that depend on good memcg charging
> > performance on isolated CPUs.
> 
> What kind of role would memcg play here? Do you want to memory constrain
> that workload?

See example above.

> -- 
> Michal Hocko
> SUSE Labs
> 
> 

