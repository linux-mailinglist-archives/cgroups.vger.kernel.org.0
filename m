Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6828E65426
	for <lists+cgroups@lfdr.de>; Thu, 11 Jul 2019 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfGKJvU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 11 Jul 2019 05:51:20 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54278 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfGKJvT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 11 Jul 2019 05:51:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=FJ+go1rWo5bup7lu7g/QrNgXQ3Vwzmjj/rkN/hAyR6E=; b=yIDvRQUUo6BD24ceByuSwi6A2
        Rww/Ym6ehYSo7ILp67PD0kmgu5Up17yvsyzeRmT9bEzCeOsfMkkDnSea8zZQUckUSrk1879m8lser
        uumLJudSXDSwA/2el/6kuoo28u0z7SpYZ0RaqG1E8wVOHeK+M9CTBgekZalc6hEHDRTeko/8soLPl
        Mrqzp6+7xwvG++u9/5uChEwbPki+iVEWFwnOiyb8okckM1Od0DOpbBObJHVhBBb3amC+PQ2vFpMC/
        JduHZ1uIG+mK7vQnZBBrUp2eyh+ohf0UMsRPPjGiXDWSTwyUpOACXX4y/wc4g3Y/AVjjT4QbAEpit
        b1TE/EmJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlVjF-0002rq-8I; Thu, 11 Jul 2019 09:51:05 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5443C20B2B4C4; Thu, 11 Jul 2019 11:51:02 +0200 (CEST)
Date:   Thu, 11 Jul 2019 11:51:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     bsegall@google.com
Cc:     Dave Chiluk <chiluk+linux@indeed.com>,
        Pqhil Auld <pauld@redhat.com>, Peter Oskolkov <posk@posk.io>,
        Ingo Molnar <mingo@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brendan Gregg <bgregg@netflix.com>,
        Kyle Anderson <kwa@yelp.com>,
        Gabriel Munos <gmunoz@netflix.com>,
        John Hammond <jhammond@indeed.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Paul Turner <pjt@google.com>
Subject: Re: [PATCH v5 1/1] sched/fair: Fix low cpu usage with high
 throttling by removing expiration of cpu-local slices
Message-ID: <20190711095102.GX3402@hirez.programming.kicks-ass.net>
References: <1558121424-2914-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-1-git-send-email-chiluk+linux@indeed.com>
 <1561664970-1555-2-git-send-email-chiluk+linux@indeed.com>
 <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26lfxhwlxr.fsf@bsegall-linux.svl.corp.google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org


FWIW, good to see progress, still waiting for you guys to agree :-)

On Mon, Jul 01, 2019 at 01:15:44PM -0700, bsegall@google.com wrote:

> - Taking up-to-every rq->lock is bad and expensive and 5ms may be too
>   short a delay for this. I haven't tried microbenchmarks on the cost of
>   this vs min_cfs_rq_runtime = 0 vs baseline.

Yes, that's tricky, SGI/HPE have definite ideas about that.

> @@ -4781,12 +4790,41 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq)
>   */
>  static void do_sched_cfs_slack_timer(struct cfs_bandwidth *cfs_b)
>  {
> -	u64 runtime = 0, slice = sched_cfs_bandwidth_slice();
> +	u64 runtime = 0;
>  	unsigned long flags;
>  	u64 expires;
> +	struct cfs_rq *cfs_rq, *temp;
> +	LIST_HEAD(temp_head);
> +
> +	local_irq_save(flags);
> +
> +	raw_spin_lock(&cfs_b->lock);
> +	cfs_b->slack_started = false;
> +	list_splice_init(&cfs_b->slack_cfs_rq, &temp_head);
> +	raw_spin_unlock(&cfs_b->lock);
> +
> +
> +	/* Gather all left over runtime from all rqs */
> +	list_for_each_entry_safe(cfs_rq, temp, &temp_head, slack_list) {
> +		struct rq *rq = rq_of(cfs_rq);
> +		struct rq_flags rf;
> +
> +		rq_lock(rq, &rf);
> +
> +		raw_spin_lock(&cfs_b->lock);
> +		list_del_init(&cfs_rq->slack_list);
> +		if (!cfs_rq->nr_running && cfs_rq->runtime_remaining > 0 &&
> +		    cfs_rq->runtime_expires == cfs_b->runtime_expires) {
> +			cfs_b->runtime += cfs_rq->runtime_remaining;
> +			cfs_rq->runtime_remaining = 0;
> +		}
> +		raw_spin_unlock(&cfs_b->lock);
> +
> +		rq_unlock(rq, &rf);
> +	}

But worse still, you take possibly every rq->lock without ever
re-enabling IRQs.

>  
>  	/* confirm we're still not at a refresh boundary */
> -	raw_spin_lock_irqsave(&cfs_b->lock, flags);
> +	raw_spin_lock(&cfs_b->lock);
>  	cfs_b->slack_started = false;
>  	if (cfs_b->distribute_running) {
>  		raw_spin_unlock_irqrestore(&cfs_b->lock, flags);
