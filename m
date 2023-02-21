Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA5869E100
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 14:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233683AbjBUNF0 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 08:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233481AbjBUNFZ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 08:05:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C61A942;
        Tue, 21 Feb 2023 05:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KMz2u5YNJyb58TDhqNZ0GZQlDsGmXtQeWI7CV86ksic=; b=HU9hZUeUVYy4kyNrrHBVgHCYdQ
        WvVhnyzTEnM40u3E1huX5m3mMNtJYBuMj+etXdA72WJD1/TrbUlxPnF9VDU6DsUNq1P90evmuZOvg
        DAM0L26hCOmw3kOYoY1Fhp+sxEGLcXmbBSe4CXFGM1UYzLx44I8wwduqer+4zhdGuWmDo4zG4EMef
        6rCal2isiQT9VgJ1HeJNoqDcr0WMfHCBzwGRCXMRkEOg5vls+XbC2/7KzQeOxIs6fem+zvodxu2tI
        87DNmOYPhqwcnkgPsRhidulJZubK2EJrVKQe8tBMbPsBfaYUuDH/+PL7f8BS3uTgfkzbky0OsvTt4
        qeSgjWVQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUSKE-00Cd0W-CW; Tue, 21 Feb 2023 13:04:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 59B0F3003E1;
        Tue, 21 Feb 2023 14:04:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 403EC20B4D21B; Tue, 21 Feb 2023 14:04:52 +0100 (CET)
Date:   Tue, 21 Feb 2023 14:04:52 +0100
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
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority
 at wakeup
Message-ID: <Y/TBdB23akBbUjqd@hirez.programming.kicks-ass.net>
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113141234.260128-6-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
> @@ -6155,6 +6159,35 @@ static int sched_idle_cpu(int cpu)
>  }
>  #endif
>  
> +static void set_next_buddy(struct sched_entity *se);
> +
> +static void check_preempt_from_others(struct cfs_rq *cfs, struct sched_entity *se)
> +{
> +	struct sched_entity *next;
> +
> +	if (se->latency_offset >= 0)
> +		return;
> +
> +	if (cfs->nr_running <= 1)
> +		return;
> +	/*
> +	 * When waking from another class, we don't need to check to preempt at
> +	 * wakeup and don't set next buddy as a candidate for being picked in
> +	 * priority.
> +	 * In case of simultaneous wakeup when current is another class, the
> +	 * latency sensitive tasks lost opportunity to preempt non sensitive
> +	 * tasks which woke up simultaneously.
> +	 */
> +
> +	if (cfs->next)
> +		next = cfs->next;
> +	else
> +		next = __pick_first_entity(cfs);
> +
> +	if (next && wakeup_preempt_entity(next, se) == 1)
> +		set_next_buddy(se);
> +}
> +
>  /*
>   * The enqueue_task method is called before nr_running is
>   * increased. Here we update the fair scheduling stats and
> @@ -6241,14 +6274,15 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
>  	if (!task_new)
>  		update_overutilized_status(rq);
>  
> +	if (rq->curr->sched_class != &fair_sched_class)
> +		check_preempt_from_others(cfs_rq_of(&p->se), &p->se);
> +
>  enqueue_throttle:
>  	assert_list_leaf_cfs_rq(rq);
>  
>  	hrtick_update(rq);
>  }

Hmm.. This sets a next selection when the task gets enqueued while not
running a fair task -- and looses a wakeup preemption opportunity.

Should we perhaps also do this for latency_nice == 0?, in any case I
think this can be moved to its own patch to avoid doing too much in the
one patch. It seems fairly self contained.

