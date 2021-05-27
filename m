Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BF4392F17
	for <lists+cgroups@lfdr.de>; Thu, 27 May 2021 15:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236334AbhE0NIG (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 27 May 2021 09:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236336AbhE0NIC (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 27 May 2021 09:08:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C04BC061760;
        Thu, 27 May 2021 06:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ta5zzhet5s6C63/o89LSX98k9lWRcXUPZemLvb4KNvQ=; b=HfZz8BRqIZXWTWn2p5hFQrTao1
        iZJDgiZEi8Vmr//6oJzinMu3kuu4Ml+cC6TbN1ZUZbFoneVoVqYU6ToKxiVj+zmnsHgM0n9x/C6gi
        YskpjrBH3Iy4bfMKsgzjbw6nrOQZUsOq/w8OhTbVYCG1L22P8iKayEM1QBSpxKe7xfMmeKTwXKJaQ
        Y70SXnvSfe2Onl36lQFJPV7gs1cMho/hn+fSKLpy9EKVyHKktR0iNePLo7wbjftr+8ONOWeuQI/sJ
        JaL11rfLez3fAapFrYnmnCpl8yvk5haitSvJF4/24ddTToylmg0qN15ojjibz7eUrHp+UnwCNLCV1
        9om/d5IQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lmFhc-005YSv-1T; Thu, 27 May 2021 13:05:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 12A2B300268;
        Thu, 27 May 2021 15:05:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D2920202492E9; Thu, 27 May 2021 15:05:30 +0200 (CEST)
Date:   Thu, 27 May 2021 15:05:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org, odin@uged.al,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/fair: keep load_avg and load_sum synced
Message-ID: <YK+ZGlfPxK3JCySS@hirez.programming.kicks-ass.net>
References: <20210527122916.27683-1-vincent.guittot@linaro.org>
 <20210527122916.27683-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527122916.27683-2-vincent.guittot@linaro.org>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 27, 2021 at 02:29:15PM +0200, Vincent Guittot wrote:

> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3509,7 +3509,8 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
>  	se->avg.load_sum = runnable_sum;
>  	se->avg.load_avg = load_avg;
>  	add_positive(&cfs_rq->avg.load_avg, delta_avg);
> -	add_positive(&cfs_rq->avg.load_sum, delta_sum);
> +	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;

If I'm not mistaken, this makes delta_sum unused, so we can remove it
entirely, see below.

> +

This extra blank space, we really need that? :-)

>  }

---
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92aa1c79..2b99e687fe7a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3453,10 +3453,9 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cf
 static inline void
 update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
 {
-	long delta_avg, running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
+	long running_sum, runnable_sum = gcfs_rq->prop_runnable_sum;
 	unsigned long load_avg;
 	u64 load_sum = 0;
-	s64 delta_sum;
 	u32 divider;
 
 	if (!runnable_sum)
@@ -3503,13 +3502,11 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq
 	load_sum = (s64)se_weight(se) * runnable_sum;
 	load_avg = div_s64(load_sum, divider);
 
-	delta_sum = load_sum - (s64)se_weight(se) * se->avg.load_sum;
-	delta_avg = load_avg - se->avg.load_avg;
-
 	se->avg.load_sum = runnable_sum;
 	se->avg.load_avg = load_avg;
-	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
+
+	add_positive(&cfs_rq->avg.load_avg, (long)(load_avg - se->avg.load_avg));
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
 }
 
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum)
