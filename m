Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68BDC596B8B
	for <lists+cgroups@lfdr.de>; Wed, 17 Aug 2022 10:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiHQIqm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 17 Aug 2022 04:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiHQIql (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 17 Aug 2022 04:46:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14DF74E0D;
        Wed, 17 Aug 2022 01:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CKeCiigKMtOdgr4YLuQq0s6tHiN60WT8O1gsyf1py6Y=; b=OYd1O3mEkB+wAABrc+5g7lt0dm
        S+0AdbaoEm8UtVjwn+dC5BXqtsgv3oynpOR8By0PJCSCNJvzHZ5h940eGMSrNDeKiEukda2HZhArL
        ze3zylI40u7KNiWAI161EbKzjOYT0kuCvfTd2aaVvxaqn91cFB5B9L4+bW7iNVxkAZ6pBlDDJG7I0
        WV2+66RpxVyfHz/+acnMp4WoS0kV8qnsyhZ9vmZ4GQW4Wr4OL+jvPu8pWPu7/h/67pKyamyymVBSq
        zvqfZCQIW6HxCFZQ3/Ma9XqACtBoXlNb43JuULRrCn6X3bXUU+6OTceIBiTR5FJQSz1Wl77gPBJi2
        vtQYWo9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOEh3-007wZq-28; Wed, 17 Aug 2022 08:46:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 25743980089; Wed, 17 Aug 2022 10:46:28 +0200 (CEST)
Date:   Wed, 17 Aug 2022 10:46:28 +0200
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
Subject: Re: [PATCH v5 1/3] sched: Use user_cpus_ptr for saving user provided
 cpumask in sched_setaffinity()
Message-ID: <Yvyq5GBtU+XxLSaP@worktop.programming.kicks-ass.net>
References: <20220816192734.67115-1-longman@redhat.com>
 <20220816192734.67115-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816192734.67115-2-longman@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Aug 16, 2022 at 03:27:32PM -0400, Waiman Long wrote:
> @@ -8079,10 +8056,11 @@ int dl_task_check_affinity(struct task_struct *p, const struct cpumask *mask)
>  #endif
>  
>  static int
> -__sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
> +__sched_setaffinity(struct task_struct *p, const struct cpumask *mask, bool save_mask)
>  {
>  	int retval;
>  	cpumask_var_t cpus_allowed, new_mask;
> +	struct cpumask *user_mask = NULL;
>  
>  	if (!alloc_cpumask_var(&cpus_allowed, GFP_KERNEL))
>  		return -ENOMEM;

Please move that retval down so the variable declarations are properly
ordered again.

> @@ -8098,8 +8076,33 @@ __sched_setaffinity(struct task_struct *p, const struct cpumask *mask)
>  	retval = dl_task_check_affinity(p, new_mask);
>  	if (retval)
>  		goto out_free_new_mask;
> +
> +	/*
> +	 * Save the user requested mask into user_cpus_ptr if save_mask set.
> +	 * pi_lock is used for protecting user_cpus_ptr.
> +	 */
> +	if (save_mask && !p->user_cpus_ptr) {
> +		user_mask = kmalloc(cpumask_size(), GFP_KERNEL);
> +
> +		if (!user_mask) {
> +			retval = -ENOMEM;
> +			goto out_free_new_mask;
> +		}
> +	}
> +	if (save_mask) {
> +		unsigned long flags;
> +
> +		raw_spin_lock_irqsave(&p->pi_lock, flags);
> +		if (!p->user_cpus_ptr) {
> +			p->user_cpus_ptr = user_mask;
> +			user_mask = NULL;
> +		}
> +
> +		cpumask_copy(p->user_cpus_ptr, mask);
> +		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +	}

How about:

	if (save_mask) {
		if (!p->user_cpus_ptr) {
			...
		}
		...
	}

?
