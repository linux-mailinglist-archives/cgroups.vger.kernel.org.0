Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58CFC68D644
	for <lists+cgroups@lfdr.de>; Tue,  7 Feb 2023 13:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjBGMQz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Feb 2023 07:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjBGMQy (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Feb 2023 07:16:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C19E8A7D;
        Tue,  7 Feb 2023 04:16:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86DEA61376;
        Tue,  7 Feb 2023 12:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F03FC433AA;
        Tue,  7 Feb 2023 12:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675772210;
        bh=2JXiT/NDBiJUjJkNFjkNT8IoqvYyB9wj9pr5FrsMNEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BNl1ztfy4YwyRJx/Nz+Yol0AJxjcjfDDMG2DxzVQoqNwGsBar8AZF6/RTi8x0IzRA
         Ae7c3GBPt5/qN0tVSJnsAyQdKrMP5/xXUnjSF56Y0zXteDiYcmc8ibaGwTKLI55leZ
         51P4LXuWGWv59+2n9H/jZYqDAm5KAMrKQy/O1/d6bf7ZP5lqUUNjTocb/hm/G6qxxL
         HSIlCvzdoi3SjdSq8LpeO4y9z+RN1Sa+52YrjIi+eOjRZFdIA879OYH103BVdMKleo
         rCpqVoHihTVP4ehCvUIYd8ibub1lgD4oU6TG1GjNBmOF2tlV/hrgSQfcF5BSMcX8Rx
         Z0FiDMsBm+JbA==
Date:   Tue, 7 Feb 2023 13:16:47 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Leonardo <leobras@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, cgroups@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 2/2] sched/isolation: Add cpu_is_isolated() API
Message-ID: <Y+JBL3HZ4ahRSEis@lothringen>
References: <20230203232409.163847-1-frederic@kernel.org>
 <20230203232409.163847-3-frederic@kernel.org>
 <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f388863-9498-e61e-e2dc-965654544489@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Feb 03, 2023 at 10:53:46PM -0500, Waiman Long wrote:
> On 2/3/23 18:24, Frederic Weisbecker wrote:
> > Provide this new API to check if a CPU has been isolated either through
> > isolcpus= or nohz_full= kernel parameter.
> > 
> > It aims at avoiding kernel load deemed to be safely spared on CPUs
> > running sensitive workload that can't bear any disturbance, such as
> > pcp cache draining.
> > 
> > Suggested-by: Michal Hocko <mhocko@suse.com>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >   include/linux/sched/isolation.h | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
> > index b645cc81fe01..088672f08469 100644
> > --- a/include/linux/sched/isolation.h
> > +++ b/include/linux/sched/isolation.h
> > @@ -53,4 +53,10 @@ static inline bool housekeeping_cpu(int cpu, enum hk_type type)
> >   	return true;
> >   }
> > +static inline bool cpu_is_isolated(int cpu)
> > +{
> > +	return !housekeeping_test_cpu(cpu, HK_TYPE_DOMAIN) ||
> > +		 !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE);
> > +}
> > +
> >   #endif /* _LINUX_SCHED_ISOLATION_H */
> 
> CPUs in an isolated cpuset partition is similar to HK_TYPE_DOMAIN CPUs as
> load balancing is disabled. I can add an API to access the cpumask and add
> to this API. However, that list is dynamic as it can be changed at run time.
> Will that be a problem? Or should that be used separately?

So that's what I intended first but the dynamic part of cpuset made me
postpone that to better days.

But yes ideally it should look like:

static inline bool cpu_is_isolated(int cpu)
{
    return !housekeeping_test_cpu(cpu, HK_TYPE_KERNEL_NOISE) ||
           on_null_domain(cpu_rq(cpu));
}

And there should be a hook in something like detach_destroy_domains()
to flush the pcp cache when a CPU is attached to a NULL domain.

All that with proper RCU synchronization:

       UPDATE                                          READER
       ------                                          ------
       rcu_assign_pointer(cpu_rq(cpu)->sd, NULL);      rcu_read_lock();
       synchronize_rcu();                              if (!cpu_is_isolated(cpu))
       stock = &per_cpu(memcg_stock, cpu);                 schedule_work_on(cpu, &stock->work);
       flush_work(&stock->work);                       rcu_read_unlock()

Thanks.
