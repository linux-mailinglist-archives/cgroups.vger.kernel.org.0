Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951C569E326
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 16:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233849AbjBUPMZ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234204AbjBUPMY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 10:12:24 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BAC2A144;
        Tue, 21 Feb 2023 07:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aANriw9LXZj51WG6ahVVJ0TaMZ+z3iaUteIrENxaYmY=; b=NWvP0uylx8quy1DxJTGHiiDS7E
        qPPOrbMXMdN9swpO6tVdcuRXftSvwIA/eYexS6q8672AdB682Z5sC1yMUwoU/gXK2+IZBU3YDa8Cw
        AFkkdNlkucjXLYPSp6AgPViCZp/hdwdpWp++u/ZQSeUNcAf7gO6usbnH5sl1dqNtikdJ8mFoXpq/y
        ZDsdEZV7cW7vFQUFJOLNi05P5FQ5L4uLesWh1UWt70ebLpfGGRYzSWvFcUUO9ERXQs6cCwwO/3r3T
        Dbi/I3EFGUNwvf6Hg4M4WMlx5NA4WZYvXruUrIKjyOhl5dd+I3ltvsDQF+K0jwXcUyUMRRP9Evgln
        hQrFntvA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pUUJ5-00ChOd-IH; Tue, 21 Feb 2023 15:11:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 84A3E300193;
        Tue, 21 Feb 2023 16:11:51 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C1DB20B4D21B; Tue, 21 Feb 2023 16:11:51 +0100 (CET)
Date:   Tue, 21 Feb 2023 16:11:51 +0100
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
Message-ID: <Y/TfN1upxApdSERP@hirez.programming.kicks-ass.net>
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
> @@ -12552,8 +12634,15 @@ int sched_group_set_latency(struct task_group *tg, s64 latency)
>  
>  	for_each_possible_cpu(i) {
>  		struct sched_entity *se = tg->se[i];
> +		struct rq *rq = cpu_rq(i);
> +		struct rq_flags rf;
> +
> +		rq_lock_irqsave(rq, &rf);
>  
> +		__dequeue_latency(se->cfs_rq, se);
>  		WRITE_ONCE(se->latency_offset, latency);
> +
> +		rq_unlock_irqrestore(rq, &rf);
>  	}

This seems asymmetric; maybe something like:

	queued = __dequeue_latency(..);
	WRITE_ONCE(...);
	if (queued)
		__enqueue_latency(...);

?
