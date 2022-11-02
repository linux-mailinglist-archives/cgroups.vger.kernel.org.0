Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEE4615E66
	for <lists+cgroups@lfdr.de>; Wed,  2 Nov 2022 09:53:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiKBIxy (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 2 Nov 2022 04:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiKBIxx (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 2 Nov 2022 04:53:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52684E83;
        Wed,  2 Nov 2022 01:53:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B089A22339;
        Wed,  2 Nov 2022 08:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667379230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mAyd5hYheJHs7wZ412hApYrbs0qLQ48nSsf9XNgypBM=;
        b=RjV6dnJfhfmC76wKcoNRFCWemxydooK/VGDCWqPhiMz0F/TrV1ZdiW0XKhCBJ8Z7iR628t
        jbGI2t0D0qvdGIrFzIqSqDmp4SOjwQiT0zrCtyvHvOOiv4hyqm+5N/sArHJ9TZeIonaEa1
        LVNRrUQKlBz+NnQeVIaR9H9oNcggfrw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E748139D3;
        Wed,  2 Nov 2022 08:53:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ErMOIB4wYmPQGQAAMHmgww
        (envelope-from <mhocko@suse.com>); Wed, 02 Nov 2022 08:53:50 +0000
Date:   Wed, 2 Nov 2022 09:53:49 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Leonardo Bras <leobras@redhat.com>
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
Message-ID: <Y2IwHVdgAJ6wfOVH@dhcp22.suse.cz>
References: <20221102020243.522358-1-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102020243.522358-1-leobras@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue 01-11-22 23:02:40, Leonardo Bras wrote:
> Patch #1 expands housekeepíng_any_cpu() so we can find housekeeping cpus
> closer (NUMA) to any desired CPU, instead of only the current CPU.
> 
> ### Performance argument that motivated the change:
> There could be an argument of why would that be needed, since the current
> CPU is probably acessing the current cacheline, and so having a CPU closer
> to the current one is always the best choice since the cache invalidation
> will take less time. OTOH, there could be cases like this which uses
> perCPU variables, and we can have up to 3 different CPUs touching the
> cacheline:
> 
> C1 - Isolated CPU: The perCPU data 'belongs' to this one
> C2 - Scheduling CPU: Schedule some work to be done elsewhere, current cpu
> C3 - Housekeeping CPU: This one will do the work
> 
> Most of the times the cacheline is touched, it should be by C1. Some times
> a C2 will schedule work to run on C3, since C1 is isolated.
> 
> If C1 and C2 are in different NUMA nodes, we could have C3 either in
> C2 NUMA node (housekeeping_any_cpu()) or in C1 NUMA node 
> (housekeeping_any_cpu_from(C1). 
> 
> If C3 is in C2 NUMA node, there will be a faster invalidation when C3
> tries to get cacheline exclusivity, and then a slower invalidation when
> this happens in C1, when it's working in its data.
> 
> If C3 is in C1 NUMA node, there will be a slower invalidation when C3
> tries to get cacheline exclusivity, and then a faster invalidation when
> this happens in C1.
> 
> The thing is: it should be better to wait less when doing kernel work
> on an isolated CPU, even at the cost of some housekeeping CPU waiting
> a few more cycles.
> ###
> 
> Patch #2 changes the locking strategy of memcg_stock_pcp->stock_lock from
> local_lock to spinlocks, so it can be later used to do remote percpu
> cache draining on patch #3. Most performance concerns should be pointed
> in the commit log.
> 
> Patch #3 implements the remote per-CPU cache drain, making use of both 
> patches #2 and #3. Performance-wise, in non-isolated scenarios, it should
> introduce an extra function call and a single test to check if the CPU is
> isolated. 
> 
> On scenarios with isolation enabled on boot, it will also introduce an
> extra test to check in the cpumask if the CPU is isolated. If it is,
> there will also be an extra read of the cpumask to look for a
> housekeeping CPU.

This is a rather deep dive in the cache line usage but the most
important thing is really missing. Why do we want this change? From the
context it seems that this is an actual fix for isolcpu= setup when
remote (aka non isolated activity) interferes with isolated cpus by
scheduling pcp charge caches on those cpus.

Is this understanding correct?

If yes, how big of a problem that is? If you want a remote draining then
you need some sort of locking (currently we rely on local lock). How
come this locking is not going to cause a different form of disturbance?
-- 
Michal Hocko
SUSE Labs
