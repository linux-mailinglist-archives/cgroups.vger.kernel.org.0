Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0123568629B
	for <lists+cgroups@lfdr.de>; Wed,  1 Feb 2023 10:14:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjBAJOX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 1 Feb 2023 04:14:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjBAJOW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 1 Feb 2023 04:14:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B9B3A84E;
        Wed,  1 Feb 2023 01:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1tLYxflxPSmAMG06qYmYTYHHUzBsNv1g6cb5uWR7Y7Y=; b=ZZ19OwLB4nKNX+PqIaL8kGijQx
        L3wytC4ExmF6f/6+g6NTTnSTbrVw7R37f+rwAYIBEWwIJGdFHDBH4yi/uHEyzYpxj+Nye+EbljqzM
        3vJ8qTSv7d+DT94pY7foEUvNxSrLh3gieRaGj8yYN/aQjwMZAhLae5t2FwGeJeZmCRLZ5XkKz1DMW
        Otudq5PYNqREom8fDOZgJBMi/Gxph6eERFCNw5V7jmskp1L31US6ARr5gsGXKG9dWX1tbouZ/KSy6
        iwGl6n0Yl4yMyLq9Hn7Ma63r1/OW6RHjFmEvNzLnoH+d5Aa0fusQvVcqmRxhLh8w/q+l+VAeCkbJU
        BJlZCblg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pN9BH-004i5B-1d;
        Wed, 01 Feb 2023 09:13:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5201E300472;
        Wed,  1 Feb 2023 10:14:01 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2D31123CDCE2E; Wed,  1 Feb 2023 10:14:01 +0100 (CET)
Date:   Wed, 1 Feb 2023 10:14:01 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Zefan Li <lizefan.x@bytedance.com>,
        Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuset: Fix cpuset_cpus_allowed() to not filter
 offline CPUs
Message-ID: <Y9otWX+MGOLDKU6t@hirez.programming.kicks-ass.net>
References: <20230131221719.3176-1-will@kernel.org>
 <20230131221719.3176-2-will@kernel.org>
 <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b068916-5e1b-a943-1aad-554964d8b746@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Jan 31, 2023 at 11:14:27PM -0500, Waiman Long wrote:
> On 1/31/23 17:17, Will Deacon wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > There is a difference in behaviour between CPUSET={y,n} that is now
> > wrecking havoc with {relax,force}_compatible_cpus_allowed_ptr().
> > 
> > Specifically, since commit 8f9ea86fdf99 ("sched: Always preserve the
> > user requested cpumask")  relax_compatible_cpus_allowed_ptr() is
> > calling __sched_setaffinity() unconditionally.
> > 
> > But the underlying problem goes back a lot further, possibly to
> > commit: ae1c802382f7 ("cpuset: apply cs->effective_{cpus,mems}") which
> > switched cpuset_cpus_allowed() from cs->cpus_allowed to
> > cs->effective_cpus.
> > 
> > The problem is that for CPUSET=y cpuset_cpus_allowed() will filter out
> > all offline CPUs. For tasks that are part of a (!root) cpuset this is
> > then later fixed up by the cpuset hotplug notifiers that re-evaluate
> > and re-apply cs->effective_cpus, but for (normal) tasks in the root
> > cpuset this does not happen and they will forever after be excluded
> > from CPUs onlined later.
> > 
> > As such, rewrite cpuset_cpus_allowed() to return a wider mask,
> > including the offline CPUs.
> > 
> > Fixes: 8f9ea86fdf99 ("sched: Always preserve the user requested cpumask")
> > Reported-by: Will Deacon <will@kernel.org>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Link: https://lkml.kernel.org/r/20230117160825.GA17756@willie-the-truck
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> Before cgroup v2, cpuset had only one cpumask - cpus_allowed. It only
> tracked online cpus and ignored the offline ones. It behaves more like
> effective_cpus in cpuset v2. With v2, we have 2 cpumasks - cpus_allowed and
> effective_cpus. When cpuset v1 is mounted, cpus_allowed and effective_cpus
> are effectively the same and track online cpus. With cpuset v2, cpus_allowed
> contains what the user has written into and it won't be changed until
> another write happen. However, what the user written may not be what the
> system can give it and effective_cpus is what the system decides a cpuset
> can use.
> 
> Cpuset v2 is able to handle hotplug correctly and update the task's cpumask
> accordingly. So missing previously offline cpus won't happen with v2.
> 
> Since v1 keeps the old behavior, previously offlined cpus are lost in the
> cpuset's cpus_allowed. However tasks in the root cpuset will still be fine
> with cpu hotplug as its cpus_allowed should track cpu_online_mask. IOW, only
> tasks in a non-root cpuset suffer this problem.
> 
> It was a known issue in v1 and I believe is one of the major reasons of the
> cpuset v2 redesign.
> 
> A major concern I have is the overhead of creating a poor man version of v2
> cpus_allowed. This issue can be worked around even for cpuset v1 if it is
> mounted with the cpuset_v2_mode option to behave more like v2 in its cpumask
> handling. Alternatively we may be able to provide a config option to make
> this the default for v1 without the special mount option, if necessary.

You're still not getting it -- even cpuset (be it v1 or v2) *MUST* *NOT*
mask offline cpus for root cgroup tasks, ever. (And the only reason it
gets away with masking offline for !root is that it re-applies the mask
every time it changes.)

Yes it did that for a fair while -- but it is wrong and broken and a
very big behavioural difference between CONFIG_CPUSET={y,n}. This must
not be.

Arguably cpuset-v2 is still wrong for masking offline cpus in it's
effective_cpus mask, but I really didn't want to go rewrite cpuset.c for
something that needs to go into /urgent *now*.

Hence this minimal patch that at least lets sched_setaffinity() work as
intended.


