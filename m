Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A34A569E0D9
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233364AbjBUMyB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 07:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233396AbjBUMxw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 07:53:52 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF19423DB3;
        Tue, 21 Feb 2023 04:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=e9/aDKUyKuBkvQEPm0dRHwCaOcpHf48fdU5SrQYxTGU=; b=JzguKagadVRr3rixX4uXLHmau0
        TQB4/qsx/1x8zlkUZ96fpp4lrLhNALumwpcOgnjtABhSK+Kz8vm/BSPvrOr+/PeOXoXsqqig167wU
        vILS1G+iDltVxiZCQSG9QnXkFk9Xc1AcdDrNEVaDlEv8yzN7kjgY3GTwbxObgSiFULOVjbv3UIwSj
        Fz8NtAhQtoKW6bbaBj7H1LczrWALWyAC+tcT0qRn+rIJTjJS8UcsnOeCRlRH2OYliM3k18wYcROdp
        OT+rxrVI7PzhV6CXHz9NGhl6jkR2aPgNwPIILZMrUjZx5OUu2g5l2b9UU4t1+qjtqPpWHpOHpejT3
        s3RNwmwQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUS8j-00Ccd5-7q; Tue, 21 Feb 2023 12:53:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 712E530036B;
        Tue, 21 Feb 2023 13:52:58 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 467CD20243666; Tue, 21 Feb 2023 13:52:58 +0100 (CET)
Date:   Tue, 21 Feb 2023 13:52:58 +0100
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
Message-ID: <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
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

> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 6c61bde49152..38decae3e156 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -568,6 +568,8 @@ struct sched_entity {
>  	/* cached value of my_q->h_nr_running */
>  	unsigned long			runnable_weight;
>  #endif
> +	/* preemption offset in ns */
> +	long				latency_offset;

I wonder about the type here; does it make sense to have it depend on
the bitness; that is if s32 is big enough on 32bit then surely it is so
too on 64bit, and if not, then it should be unconditionally s64.


> +static void set_latency_offset(struct task_struct *p)
> +{
> +	long weight = sched_latency_to_weight[p->latency_prio];
> +	s64 offset;
> +
> +	offset = weight * get_sleep_latency(false);
> +	offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
> +	p->se.latency_offset = (long)offset;
> +}

> +/*
> + * latency weight for wakeup preemption
> + */
> +const int sched_latency_to_weight[40] = {
> + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> + /* -15 */      -768,     -717,     -666,      -614,      -563,
> + /* -10 */      -512,     -461,     -410,      -358,      -307,
> + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> + /*   0 */         0,       51,      102,       154,       205,
> + /*   5 */       256,      307,      358,       410,       461,
> + /*  10 */       512,      563,      614,       666,       717,
> + /*  15 */       768,      819,      870,       922,       973,
> +};

I'm slightly confused by this table, isn't that simply the linear
function?

Isn't all that the same as:

	se->se.latency_offset = get_sleep_latency * nice / (NICE_LATENCY_WIDTH/2);

? The reason we have prio_to_weight[] is because it's an exponential,
which is a bit more cumbersome to calculate, but surely we can do a
linear function at runtime.


