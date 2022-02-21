Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810294BE981
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 19:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380939AbiBUQok (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 11:44:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380960AbiBUQok (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 11:44:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A915A220D5
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 08:44:16 -0800 (PST)
Date:   Mon, 21 Feb 2022 17:44:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645461854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FanYIpzuzO2OIQcmAbO6hr4IzLwYQWIb8ljFjp/SrAs=;
        b=nEVg+O/ZK98mEFQmhOseYs8lnNeH5TrEg8Jk3+iUr8PcEMutyi03fcN4iEX1GRo/t6b5kP
        M0/7n71mvbQcDqNA4E0EaAKsrrHsbFuXh/G1zUTGDUYIYTCjx7ieNkZMQCZe/ca9sPFUic
        FLWmNSrJanZEvxyyrbbSt4g9jc3EhbqYQXlbtdcjtwjIir3GCsRDkqJElKIK3LYp+LEhzz
        tSN+uyKedReEmpi29ETFV9cNizYc8UFGLtTSAIxgcqWf91lLoQKUFgmFiDozkQ9nBXptIb
        LjWHqYIUBuiCX7vEuXAZkGSfdVWuYdDm3o5kFLpF9QwOEvTDwBMRv4NSlpGluQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645461854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FanYIpzuzO2OIQcmAbO6hr4IzLwYQWIb8ljFjp/SrAs=;
        b=9tF2cGidY7GBkRFBiGZEcrVfwFXWtCNGIFcUkRa6oYaw4qWA9vVi5q3/DKgNjJtrllkuIh
        lu9RvHESpOVbA/BA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Michal Hocko <mhocko@suse.com>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YhPBXUmIIHeXI/Gz@linutronix.de>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-6-bigeasy@linutronix.de>
 <YhOlxsLOOU/OVSzu@dhcp22.suse.cz>
 <YhOtmPQUcqZCKodH@linutronix.de>
 <YhO8yQrdVX04T8/n@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YhO8yQrdVX04T8/n@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On 2022-02-21 17:24:41 [+0100], Michal Hocko wrote:
> > > > @@ -2282,14 +2288,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> > > >  		rcu_read_unlock();
> > > >  
> > > >  		if (flush &&
> > > > -		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> > > > -			if (cpu == curcpu)
> > > > -				drain_local_stock(&stock->work);
> > > > -			else
> > > > -				schedule_work_on(cpu, &stock->work);
> > > > -		}
> > > > +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
> > > > +			schedule_work_on(cpu, &stock->work);
> > > 
> > > Maybe I am missing but on !PREEMPT kernels there is nothing really
> > > guaranteeing that the worker runs so there should be cond_resched after
> > > the mutex is unlocked. I do not think we want to rely on callers to be
> > > aware of this subtlety.
> > 
> > There is no guarantee on PREEMPT kernels, too. The worker will be made
> > running and will be put on the CPU when the scheduler sees it fit and
> > there could be other worker which take precedence (queued earlier).
> > But I was not aware that the worker _needs_ to run before we return.
> 
> A lack of draining will not be a correctness problem (sorry I should
> have made that clear). It is more about subtlety than anything. E.g. the
> charging path could be forced to memory reclaim because of the cached
> charges which are still waiting for their draining. Not really something
> to lose sleep over from the runtime perspective. I was just wondering
> that this makes things more complex than necessary.

So it is no strictly wrong but it would be better if we could do
drain_local_stock() on the local CPU.

> > We
> > might get migrated after put_cpu() so I wasn't aware that this is
> > important. Should we attempt best effort and wait for the worker on the
> > current CPU?
> 
> 
> > > An alternative would be to split out __drain_local_stock which doesn't
> > > do local_lock.
> > 
> > but isn't the section in drain_local_stock() unprotected then?
> 
> local_lock instead of {get,put}_cpu would handle that right?

It took a while, but it clicked :)
If we acquire the lock_lock_t, that we would otherwise acquire in
drain_local_stock(), before the for_each_cpu loop (as you say
get,pu_cpu) then we would indeed need __drain_local_stock() and things
would work. But it looks like an abuse of the lock to avoid CPU
migration since there is no need to have it acquired at this point. Also
the whole section would run with disabled interrupts and there is no
need for it.

What about if replace get_cpu() with migrate_disable()? 

Sebastian
