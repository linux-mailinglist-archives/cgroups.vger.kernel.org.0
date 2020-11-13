Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50D462B170B
	for <lists+cgroups@lfdr.de>; Fri, 13 Nov 2020 09:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgKMIQk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 13 Nov 2020 03:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgKMIQk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 13 Nov 2020 03:16:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D304EC0613D1;
        Fri, 13 Nov 2020 00:16:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5N5ehk3YooE5n4GR5V5uz/RJicpr7z7QnkGAwp8KO2A=; b=rGcsjmb6Ec1d59cbz4DPDP5avQ
        tBYlssuVPlOQRd7IQGAs6HvG3sBQcymPGh2EstQP0iJVQA7qHUMv2lueYRUgsHLhYJJHH4F5O5NlH
        bJVF8gHc9F/qQL//ML2j+l4L7AcGInQj8zHWPooYKv8D3l/Wcn6E2SgBowN48KqHYCMnGt0byuA09
        TbF6ry258EDdl1UDyn2Eqd5R2L3r5KK497XRKYohBRBhp3S+VeYclYdXCYfQvLZ9eahoZbzBOy+h1
        RYpc1K+MUYIQgP9SmOhiY/C6XP4rU6ycKy6GgC28UC3lGMTQwMryN5nU5h6PzOGdjiPUgrhewv4Pt
        Y0UzRtbQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kdUFr-00075R-AG; Fri, 13 Nov 2020 08:16:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 81E1D3050F0;
        Fri, 13 Nov 2020 09:16:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3AFEE2C084CAE; Fri, 13 Nov 2020 09:16:22 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:16:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>,
        Prateek Sood <prsood@codeaurora.org>,
        Waiman Long <longman@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpuset: fix race between hotplug work and later CPU
 offline
Message-ID: <20201113081622.GA2628@hirez.programming.kicks-ass.net>
References: <20201112171711.639541-1-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112171711.639541-1-daniel.m.jordan@oracle.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Nov 12, 2020 at 12:17:11PM -0500, Daniel Jordan wrote:
> One of our machines keeled over trying to rebuild the scheduler domains.
> Mainline produces the same splat:
> 
>   BUG: unable to handle page fault for address: 0000607f820054db
>   CPU: 2 PID: 149 Comm: kworker/1:1 Not tainted 5.10.0-rc1-master+ #6
>   Workqueue: events cpuset_hotplug_workfn
>   RIP: build_sched_domains
>   Call Trace:
>    partition_sched_domains_locked
>    rebuild_sched_domains_locked
>    cpuset_hotplug_workfn
> 
> It happens with cgroup2 and exclusive cpusets only.  This reproducer
> triggers it on an 8-cpu vm and works most effectively with no
> preexisting child cgroups:
> 
>   cd $UNIFIED_ROOT
>   mkdir cg1
>   echo 4-7 > cg1/cpuset.cpus
>   echo root > cg1/cpuset.cpus.partition
> 
>   # with smt/control reading 'on',
>   echo off > /sys/devices/system/cpu/smt/control
> 
> RIP maps to
> 
>   sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
> 
> from sd_init().  sd_id is calculated earlier in the same function:
> 
>   cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
>   sd_id = cpumask_first(sched_domain_span(sd));
> 
> tl->mask(cpu), which reads cpu_sibling_map on x86, returns an empty mask
> and so cpumask_first() returns >= nr_cpu_ids, which leads to the bogus
> value from per_cpu_ptr() above.
> 
> The problem is a race between cpuset_hotplug_workfn() and a later
> offline of CPU N.  cpuset_hotplug_workfn() updates the effective masks
> when N is still online, the offline clears N from cpu_sibling_map, and
> then the worker uses the stale effective masks that still have N to
> generate the scheduling domains, leading the worker to read
> N's empty cpu_sibling_map in sd_init().
> 
> rebuild_sched_domains_locked() prevented the race during the cgroup2
> cpuset series up until the Fixes commit changed its check.  Make the
> check more robust so that it can detect an offline CPU in any exclusive
> cpuset's effective mask, not just the top one.
> 
> Fixes: 0ccea8feb980 ("cpuset: Make generate_sched_domains() work with partition")
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Li Zefan <lizefan@huawei.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Prateek Sood <prsood@codeaurora.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Cc: cgroups@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: stable@vger.kernel.org

Works for me. TJ, do I take this or do you want it in the cgroup tree?

In that case:

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
