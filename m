Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC7F592C7F
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiHOI5b (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiHOI5a (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 04:57:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28AA1D310;
        Mon, 15 Aug 2022 01:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xGKSHpBSrA7bGy9HtaNlBZ6jRySHti4Z3/bSYrzElsk=; b=QfHLyNs2Gnm/SW58wQjhG43d4m
        YtpYmGgwiw73SbX4veuzmapH8DV7A/3SrrNvsYp3sGIWUlJb/GP8afoCxYTKA8DXbu7hVeQfKLnoj
        hBGXrJ+L7xHjybZuRnrduifHmMhYTDTmUPCKl/ByqVv5VVd9DQjBWn4HSMHudfi3VHRWBDun+CmdG
        YseHXJ4cDfrGck+Tz1Xv31Hzsoxozc4iUOksmCJ48lksoc5+64RuVPVOrKYbfT/5187aWI1iYF0h7
        rE6WodEhc+cSnV2XVz60fOqJXKONiC/HUZKoCktmpIMC0uNKek0Zqa3X8x+cyycjXHnt/oySgeHPC
        SRLQGj6A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNVuO-005Zg8-RC; Mon, 15 Aug 2022 08:57:17 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2455C980153; Mon, 15 Aug 2022 10:57:15 +0200 (CEST)
Date:   Mon, 15 Aug 2022 10:57:15 +0200
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
Message-ID: <YvoKa3tbOaszsp1y@worktop.programming.kicks-ass.net>
References: <20220812203929.364341-1-longman@redhat.com>
 <20220812203929.364341-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812203929.364341-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 12, 2022 at 04:39:27PM -0400, Waiman Long wrote:
> The user_cpus_ptr field is added by commit b90ca8badbd1 ("sched:
> Introduce task_struct::user_cpus_ptr to track requested affinity"). It
> is currently used only by arm64 arch due to possible asymmetric cpu
> setup. This patch extends its usage to save user provided cpumask when
> sched_setaffinity() is called for all arches.
> 
> To preserve the existing arm64 use case, a new cpus_affinity_set flag is
> added to differentiate if user_cpus_ptr is set up by sched_setaffinity()
> or by force_compatible_cpus_allowed_ptr(). user_cpus_ptr
> set by sched_setaffinity() has priority and won't be
> overwritten by force_compatible_cpus_allowed_ptr() or
> relax_compatible_cpus_allowed_ptr().

What why ?! The only possible case where
restrict_cpus_allowed_ptr() will now need that weird new state is when
the affinity has never been set before, in that case cpus_ptr should be
possible_mask.

Please just make a single consistent rule and don't make weird corner
cases like this.
