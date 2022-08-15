Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A58E5930AC
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243014AbiHOO0K (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243009AbiHOO0J (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 10:26:09 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2CA165B2;
        Mon, 15 Aug 2022 07:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1ak0A9KD/FjrZcz3FKKCRHXNxZoMyEi6sn1tq4sEH4A=; b=Dfu8yp2ZRYkQ/bfgOWouSCakGM
        FjtLjQvxl3pasiUTCcrmRFuGn2zFi7ovA1A2cC9loQ+tZTKkdcp3RUsnWYRsbTttHCmKFBpkzYWDi
        airkFO86qhar9Q3Q7Npcyw/40fMvrGbK60+ILK2kediue/BA8kN/iGVpgj0VgdK7htSUWb5GPwe3o
        tzV1BiMm4b3FA647u8t5sYg/YisnRLNMHqXUV3LORoLBMjefO+T8sOk9/TJ3VbjxAQlWzvaJuX+cb
        Ny2aRkCU0DV64v9NEIT4JiwK3fnN+idFW3Oq1Pbmj46oDAqrCUGeRRXvipGxj5KCN58KZecK+VVKv
        r61XLiGg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNb2O-002gii-NC; Mon, 15 Aug 2022 14:25:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7C972980153; Mon, 15 Aug 2022 16:25:50 +0200 (CEST)
Date:   Mon, 15 Aug 2022 16:25:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Will Deacon <will@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <YvpXbofPloXkHWdq@worktop.programming.kicks-ass.net>
References: <20220812203929.364341-1-longman@redhat.com>
 <20220812203929.364341-2-longman@redhat.com>
 <YvoKa3tbOaszsp1y@worktop.programming.kicks-ass.net>
 <401bae73-3063-e0ab-c288-2c6e3be75fc5@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401bae73-3063-e0ab-c288-2c6e3be75fc5@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 15, 2022 at 09:52:27AM -0400, Waiman Long wrote:
> 
> On 8/15/22 04:57, Peter Zijlstra wrote:
> > On Fri, Aug 12, 2022 at 04:39:27PM -0400, Waiman Long wrote:
> > > The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
> > > Introduce task_struct::user_cpus_ptr to track requested affinity"). It
> > > is currently used only by arm64 arch due to possible asymmetric cpu
> > > setup. This patch extends its usage to save user provided cpumask when
> > > sched_setaffinity() is called for all arches.
> > > 
> > > To preserve the existing arm64 use case, a new cpus_affinity_set flag is
> > > added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
> > > or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
> > > set by sched_setaffinity() has priority and won't be
> > > overwritten by force_compatible_cpus_allowed_ptr() or
> > > relax_compatible_cpus_allowed_ptr().
> > What why ?! The only possible case where
> > restrict_cpus_allowed_ptr() will now need that weird new state is when
> > the affinity has never been set before, in that case cpus_ptr should be
> > possible_mask.
> 
> Since I don't have a full history for this particular patch series that add
> user_cpus_ptr, I am hesitant to change the current behavior for arm64
> systems. However, given the statement that user_cpus_ptr is for tracking
> "requested affinity" which I assume is when user applications call
> sched_setaffinity(). It does make sense we may not really need this if
> sched_setaffinity() is never called.

So it comes from the asymmetric arm stuff, where only little cores can
still run arm32 code. This means that on those machines, 32bit code
needs to be contrained so a subset of CPUs.

A direct consequence of that was that if you have any 32bit program in
your process hierarchy, you loose the big cores from you affinity mask.

For some reason that wasn't popular..  Hence the save/restore of cpumasks.

> > Please just make a single consistent rule and don't make weird corner
> > cases like this.
> 
> I will take a closer look to try to simplify the rule here.

I think something like:

	mask = p->user_cpus_ptr;
	if (!mask)
		mask = &init_task.cpus_mask;

	// impose cpuset masks

should 'just-work'.

