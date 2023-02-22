Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBDB69F239
	for <lists+cgroups@lfdr.de>; Wed, 22 Feb 2023 10:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbjBVJwh (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 22 Feb 2023 04:52:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjBVJwW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 22 Feb 2023 04:52:22 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D746BDE5;
        Wed, 22 Feb 2023 01:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CWnrS8yusi1BbXO3lj0HE+nO+dxFdr1sf7powIMllnY=; b=cAGdOrQ9sFBf37tCEgl6JuUGL3
        iK9sm/2HKSHxtzRUn8qnaECcfw8/wBTVlfDYtvVYXzhZLQLbDWglTmNSS/9RsLSBo+Ol/LMcHlAKj
        lSdAvSwVnmEJFv7b9SOayYsW7JkQsyuZODB38BOwRSbdM4HiHHO7QbkXARPLiixd2uAaeGRUSlk8X
        aXNfLIJfaa1H4u0VP813dp4RR+45ADixf8fthhiG4KfGONHheHKj207fiOv6VmNHPkRMv4ALJPzWm
        bI8h92yMiDD37+FPSKbRGhQHlvCZ+INjWW58m1dHCkWQdthArbbYa8E9Jr33A0uqZvvFd6P7OzFIb
        GQqF0KZQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pUllB-00CUYF-1u;
        Wed, 22 Feb 2023 09:50:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D64EF300446;
        Wed, 22 Feb 2023 10:49:59 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B4FD820EF499E; Wed, 22 Feb 2023 10:49:59 +0100 (CET)
Date:   Wed, 22 Feb 2023 10:49:59 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Subject: Re: [PATCH v10 8/9] sched/fair: Add latency list
Message-ID: <Y/XlR+wLtn54CkE4@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-9-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113141234.260128-9-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 13, 2023 at 03:12:33PM +0100, Vincent Guittot wrote:

> +static void __enqueue_latency(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
> +{
> +
> +	/* Only latency sensitive entity can be added to the list */
> +	if (se->latency_offset >= 0)
> +		return;
> +
> +	if (!RB_EMPTY_NODE(&se->latency_node))
> +		return;
> +
> +	/*
> +	 * An execution time less than sysctl_sched_min_granularity means that
> +	 * the entity has been preempted by a higher sched class or an entity
> +	 * with higher latency constraint.
> +	 * Put it back in the list so it gets a chance to run 1st during the
> +	 * next slice.
> +	 */
> +	if (!(flags & ENQUEUE_WAKEUP)) {
> +		u64 delta_exec = se->sum_exec_runtime - se->prev_sum_exec_runtime;
> +
> +		if (delta_exec >= sysctl_sched_min_granularity)
> +			return;
> +	}

I'm not a big fan of this dynamic enqueueing condition; it makes it
rather hard to interpret the below addition to pick_next_entity().

Let me think about this more... at the very least the comment with
__pick_first_latency() use below needs to be expanded upon if we keep it
like so.

> +
> +	rb_add_cached(&se->latency_node, &cfs_rq->latency_timeline, __latency_less);
> +}

> @@ -4966,7 +5040,7 @@ static struct sched_entity *
>  pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  {
>  	struct sched_entity *left = __pick_first_entity(cfs_rq);
> -	struct sched_entity *se;
> +	struct sched_entity *latency, *se;
>  
>  	/*
>  	 * If curr is set we have to see if its left of the leftmost entity
> @@ -5008,6 +5082,12 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
>  		se = cfs_rq->last;
>  	}
>  
> +	/* Check for latency sensitive entity waiting for running */
> +	latency = __pick_first_latency(cfs_rq);
> +	if (latency && (latency != se) &&
> +	    wakeup_preempt_entity(latency, se) < 1)
> +		se = latency;

I'm not quite sure why this condition isn't sufficient on it's own.
After all, if a task does a 'spurious' nanosleep it can get around the
'restriction' in __enqueue_latency() without any great penalty to it's
actual bandwidth consumption.
