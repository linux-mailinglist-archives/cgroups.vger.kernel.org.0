Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B53C592C8D
	for <lists+cgroups@lfdr.de>; Mon, 15 Aug 2022 12:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbiHOI7F (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 15 Aug 2022 04:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbiHOI7E (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 15 Aug 2022 04:59:04 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 882B820F52;
        Mon, 15 Aug 2022 01:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=X1Kk26FPg2jYHPvOS2s86o6tg2NoWayeOGSNjQIPE58=; b=rrsHTcvocEIu0njvXEnAoUncHw
        AS8nABWuqLfAfD9VJMaEUGdsPEJ6kYvuCMWpfsWtcOVdcgS0yDq2so/auNex1lo3b1l6EBiz2H7h5
        NRkFPzXHaXQvqlbKU5ttS02AFmeez9M8vGC1NNAV0wFw0S4T3yJdCPkBjDsW2KQfslXbjE/NEqssj
        f9cq4h6K4C70MeFyHRLsAX+QmnXpXTHZi7RP1qjvmoqokKDoIZbCmo/IK3DvgtjQ0IK5zuO60R3rS
        7U9oklNwG/wZSAIno6+HiHbYyQZ1M8VkmMjRq/p84b3nPW99Z97XtmaKhTucauSBDxImFJUpG0LrD
        VM5HOJpA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oNVvw-005Zjh-Lw; Mon, 15 Aug 2022 08:58:52 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id D8FEE980153; Mon, 15 Aug 2022 10:58:51 +0200 (CEST)
Date:   Mon, 15 Aug 2022 10:58:51 +0200
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
Subject: Re: [PATCH v3 2/3] sched: Provide copy_user_cpus_mask() to copy out
 user mask
Message-ID: <YvoKy6OdJIkNXbtq@worktop.programming.kicks-ass.net>
References: <20220812203929.364341-1-longman@redhat.com>
 <20220812203929.364341-3-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220812203929.364341-3-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Aug 12, 2022 at 04:39:28PM -0400, Waiman Long wrote:
> Since accessing the content of the user_cpus_ptr requires lock protection
> to ensure its validity, provide a helper function copy_user_cpus_mask()
> to facilitate its reading.

Sure, but this is atrocious.

> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2619,6 +2619,24 @@ void release_user_cpus_ptr(struct task_struct *p)
>  	kfree(clear_user_cpus_ptr(p));
>  }
>  
> +/*
> + * Return the copied mask pointer or NULL if user mask not available.
> + */
> +struct cpumask *copy_user_cpus_mask(struct task_struct *p,
> +				    struct cpumask *user_mask)
> +{
> +	struct rq_flags rf;
> +	struct rq *rq = task_rq_lock(p, &rf);
> +	struct cpumask *mask = NULL;
> +
> +	if (p->user_cpus_ptr) {
> +		cpumask_copy(user_mask, p->user_cpus_ptr);
> +		mask = user_mask;
> +	}
> +	task_rq_unlock(rq, p, &rf);
> +	return mask;
> +}

For reading the mask you only need one of those locks, and I would
suggest p->pi_lock is much less contended than rq->lock.
