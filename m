Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007466887AF
	for <lists+cgroups@lfdr.de>; Thu,  2 Feb 2023 20:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbjBBTmj (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 2 Feb 2023 14:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbjBBTmh (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 2 Feb 2023 14:42:37 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21B2280171;
        Thu,  2 Feb 2023 11:42:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eKs4vAUwEv0arCZAQ6y5NgakMpLZsicc4cD1nO/mnYw=; b=I2dAg18TWwn0J9HsHUU4oS/mwI
        ZIg0D78vzxqetQTkb+D+GnPnsU+n84veLlmahHdfkrLFyYyvAtBNwpAmIP2jSuGeZuJZlxs8yyvCI
        wzU+QRCsATbApLYTsE9fOUHlWPbYtiGA3vQl4tYW4tVqLLq9nN1Lqqr4ugR3TRTP1xUs7bk1VIUad
        o3fe+JORg8EF9KEtmOdw4YOx10+VeCTbdsJVmTnM/tFlFpHXdWnhaNaWTKIOcKuIAZvlicxrcejVn
        qMUMNBzbZt/GbcUmKToJBycax+vU24XD41FR+VRzgEXO3XX/13Tlu7d4IpuIjsTkRyx5YwtLL4TQF
        S5ItgR+w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pNfTB-00Dfix-Oc; Thu, 02 Feb 2023 19:42:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BEF9E30012F;
        Thu,  2 Feb 2023 20:42:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 979DA2136B3B2; Thu,  2 Feb 2023 20:42:03 +0100 (CET)
Date:   Thu, 2 Feb 2023 20:42:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9wSC1Wxlm8CKKlN@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
 <Y9t1sP/6nFht7RSN@hirez.programming.kicks-ass.net>
 <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d630ca53-71f0-c735-fbc3-e826479aa86b@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Feb 02, 2023 at 11:06:51AM -0500, Waiman Long wrote:

> After taking a close look at the patch, my understanding of what it is doing
> is as follows:
> 
> v2: cpus_allowed will not be affected by hotplug. So the new
> cpuset_cpus_allowed() will return effective_cpus + offline cpus that should
> have been part of effective_cpus if online before masking it with allowable
> cpus and then go up the cpuset hierarchy if necessary.
> 
> v1: cpus_allowed is equivalent to v2 effective_cpus. It starts at the
> current cpuset and move up the hierarchy if necessary to find a cpuset that
> have at least one allowable cpu.
> 
> First of all, it does not take into account of the v2 partition feature that
> may cause it to produce incorrect result if partition is enabled somewhere.

How so? For a partition the cpus_allowed mask should be the parition
CPUs. The only magical bit about partitions is that any one CPU cannot
belong to two partitions and load-balancing is split.

> Secondly, I don't see any benefit other than having some additional offline
> cpu available in a task's cpumask which the scheduler will ignore anyway.

Those CPUs can come online again -- you're *again* dismissing the true
bug :/

If you filter out the offline CPUs at sched_setaffinity() time, you
forever lose those CPUs, the task will never again move to those CPUs,
even if they do come online after.

It is really simple to reproduce this:

 - boot machine
 - offline all CPUs except one
 - taskset -p ffffffff $$
 - online all CPUs

and observe your shell (and all its decendants) being stuck to the one
CPU. Do the same thing on a CPUSET=n build and note the difference (you
retain the full mask).

> v2 is able to recover a previously offlined cpu. So we don't gain any
> net benefit other than the going up the cpuset hierarchy part.

Only for !root tasks. Not even v2 will re-set the affinity of root tasks
afaict.

> For v1, I agree we should go up the cpuset hierarchy to find a usable
> cpuset. Instead of introducing such a complexity in cpuset_cpus_allowed(),
> my current preference is to do the hierarchy climbing part in an enhanced
> cpuset_cpus_allowed_fallback() after an initial failure of
> cpuset_cpus_allowed(). That will be easier to understand than having such
> complexity and overhead in cpuset_cpus_allowed() alone.
> 
> I will work on a patchset to do that as a counter offer.

We will need a small and simple patch for /urgent, or I will need to
revert all your patches -- your call.

I also don't tihnk you fully appreciate the ramifications of
task_cpu_possible_mask(), cpuset currently gets that quite wrong.

