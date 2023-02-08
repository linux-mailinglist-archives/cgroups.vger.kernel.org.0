Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4611F68F7F9
	for <lists+cgroups@lfdr.de>; Wed,  8 Feb 2023 20:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbjBHTYX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 8 Feb 2023 14:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBHTYW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 8 Feb 2023 14:24:22 -0500
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387D15C91
        for <cgroups@vger.kernel.org>; Wed,  8 Feb 2023 11:24:19 -0800 (PST)
Date:   Wed, 8 Feb 2023 11:23:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675884258;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P/TREvcTU2ZKZKzZHmQjoKV0cBls9RA3p0pPuU4/Cfg=;
        b=dBHuAn91UmuMSd0dpLbfmhQmO74rioQZ9qO43NYOt/gaoWOf1GRawK2w6FVay9PPAa61eU
        dxkHEk2s1GDr66AjfQnDBwGLmkzTL8Hu6BrqxP6MCCIigV/hadn5L4CjnTwCg8urlcoYVa
        9usytnN742sp5xIxjPQIDIPFIm9NkTw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Leonardo =?iso-8859-1?Q?Br=E1s?= <leobras@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Introduce memcg_stock_pcp remote draining
Message-ID: <Y+P2xp5BfmGh5Fin@P9FQF9L96D.corp.robot.car>
References: <Y9FzSBw10MGXm2TK@tpad>
 <Y9IvoDJbLbFcitTc@dhcp22.suse.cz>
 <Y9LDAZmApLeffrT8@tpad>
 <Y9LQ615H13RmG7wL@dhcp22.suse.cz>
 <0122005439ffb7895efda7a1a67992cbe41392fe.camel@redhat.com>
 <Y9j9BnMwfm4TJks7@tpad>
 <Y9pd7AxAILUSHrpe@dhcp22.suse.cz>
 <28e08669302ad1e7a41bdf8b9988de6a352b5fe1.camel@redhat.com>
 <Y+AIOQy0HdVXCw8m@P9FQF9L96D>
 <4b232f47e038ab6fcaa0114f73c28d4bf8799f84.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b232f47e038ab6fcaa0114f73c28d4bf8799f84.camel@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Feb 07, 2023 at 12:18:01AM -0300, Leonardo Brás wrote:
> On Sun, 2023-02-05 at 11:49 -0800, Roman Gushchin wrote:
> > Hi Leonardo!
> 
> Hello Roman,
> Thanks a lot for replying!
> 
> > 
> > > Yes, but we are exchanging an "always schedule_work_on()", which is a kind of
> > > contention, for a "sometimes we hit spinlock contention".
> > > 
> > > For the spinlock proposal, on the local cpu side, the *worst case* contention
> > > is:
> > > 1 - wait the spin_unlock() for a complete <percpu cache drain process>,
> > > 2 - wait a cache hit for local per-cpu cacheline 
> > > 
> > > What is current implemented (schedule_work_on() approach), for the local
> > > cpu side there is *always* this contention:
> > > 1 - wait for a context switch,
> > > 2 - wait a cache hit from it's local per-cpu cacheline,
> > > 3 - wait a complete <percpu cache drain process>, 
> > > 4 - then for a new context switch to the current thread.
> > 
> > I think both Michal and me are thinking of a more generic case in which the cpu
> > is not exclusively consumed by 1 special process, so that the draining work can
> > be executed during an idle time. In this case the work is basically free.
> 
> Oh, it makes sense.
> But in such scenarios, wouldn't the same happens to spinlocks?
> 
> I mean, most of the contention with spinlocks only happens if the remote cpu is
> trying to drain the cache while the local cpu happens to be draining/charging,
> which is quite rare due to how fast the local cpu operations are.
> 
> Also, if the cpu has some idle time, using a little more on a possible spinlock
> contention should not be a problem. Right?
> 
> > 
> > And the introduction of a spin_lock() on the hot path is what we're are concerned
> > about. I agree, that on some hardware platforms it won't be that expensive, 
> > 
> 
> IIRC most hardware platforms with multicore supported by the kernel should have
> the same behavior, since it's better to rely on cache coherence than locking the
> memory bus.
> 
> For instance, the other popular architectures supported by Linux use the LR/SC
> strategy for atomic operations (tested on ARM, POWER, RISCV) and IIRC the
> LoadReserve slow part waits for the cacheline exclusivity, which is already
> already exclusive in this perCPU structure.
> 
> 
> > but in general not having any spinlocks is so much better.
> 
> I agree that spinlocks may bring contention, which is not ideal in many cases.
> In this case, though, it may not be a big issue, due to very rare remote access
> in the structure, for the usual case (non-pre-OOMCG)

Hi Leonardo!

I made a very simple test: replaced pcp local_lock with a spinlock and ran
a very simple kernel memory accounting benchmark (attached below) on
my desktop pc (Intel Core i9-7940X).

Original (3 attempts):
81341 us
80973 us
81258 us

Patched (3 attempts):
99918 us
100220 us
100291 us

This is without any contention and without CONFIG_LOCKDEP.

Thanks!

--

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 49f67176a1a2..bafd3cde4507 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6563,6 +6563,37 @@ static int memory_stat_show(struct seq_file *m, void *v)
        return 0;
 }

+static int memory_alloc_test(struct seq_file *m, void *v)
+{
+       unsigned long i, j;
+       void **ptrs;
+       ktime_t start, end;
+       s64 delta, min_delta = LLONG_MAX;
+
+       ptrs = kvmalloc(sizeof(void *) * 1024 * 1024, GFP_KERNEL);
+       if (!ptrs)
+               return -ENOMEM;
+
+       for (j = 0; j < 100; j++) {
+               start = ktime_get();
+               for (i = 0; i < 1024 * 1024; i++)
+                       ptrs[i] = kmalloc(8, GFP_KERNEL_ACCOUNT);
+               end = ktime_get();
+
+               delta = ktime_us_delta(end, start);
+               if (delta < min_delta)
+                       min_delta = delta;
+
+               for (i = 0; i < 1024 * 1024; i++)
+                       kfree(ptrs[i]);
+       }
+
+       kvfree(ptrs);
+       seq_printf(m, "%lld us\n", min_delta);
+
+       return 0;
+}
+
 #ifdef CONFIG_NUMA
 static inline unsigned long lruvec_page_state_output(struct lruvec *lruvec,
                                                     int item)
@@ -6758,6 +6789,10 @@ static struct cftype memory_files[] = {
                .name = "stat",
                .seq_show = memory_stat_show,
        },
+       {
+               .name = "test",
+               .seq_show = memory_alloc_test,
+       },
 #ifdef CONFIG_NUMA
        {
                .name = "numa_stat",
