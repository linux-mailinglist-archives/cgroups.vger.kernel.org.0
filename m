Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31F34BE80D
	for <lists+cgroups@lfdr.de>; Mon, 21 Feb 2022 19:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379434AbiBURSa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 21 Feb 2022 12:18:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381636AbiBURSJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 21 Feb 2022 12:18:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474C73B1
        for <cgroups@vger.kernel.org>; Mon, 21 Feb 2022 09:17:42 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BFE6121121;
        Mon, 21 Feb 2022 17:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645463860; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+7KYGytx3sPksKcMmFvof7rFmXeF2SkMG7FYcunC5P8=;
        b=dIABDJkQzMckrp5l6PQDAReBA7SrzSTO3wEN2+K6vZSdcjenF7wfKKpetyIehJcs5C3fs2
        wcXKQm/bf+xWIDtdZw/2AFeodvzTbiCQXroiQ6+UPgfwQvNYL45yJMD6d6OkuXu0Eqg2SH
        GBpZ8mnn4HJFl6AZBmzjD2tdwnTLNC0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 860F8A3B8A;
        Mon, 21 Feb 2022 17:17:40 +0000 (UTC)
Date:   Mon, 21 Feb 2022 18:17:39 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     cgroups@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Waiman Long <longman@redhat.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v3 5/5] mm/memcg: Protect memcg_stock with a local_lock_t
Message-ID: <YhPJM4RjqklanVLE@dhcp22.suse.cz>
References: <20220217094802.3644569-1-bigeasy@linutronix.de>
 <20220217094802.3644569-6-bigeasy@linutronix.de>
 <YhOlxsLOOU/OVSzu@dhcp22.suse.cz>
 <YhOtmPQUcqZCKodH@linutronix.de>
 <YhO8yQrdVX04T8/n@dhcp22.suse.cz>
 <YhPBXUmIIHeXI/Gz@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhPBXUmIIHeXI/Gz@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon 21-02-22 17:44:13, Sebastian Andrzej Siewior wrote:
> On 2022-02-21 17:24:41 [+0100], Michal Hocko wrote:
> > > > > @@ -2282,14 +2288,9 @@ static void drain_all_stock(struct mem_cgroup *root_memcg)
> > > > >  		rcu_read_unlock();
> > > > >  
> > > > >  		if (flush &&
> > > > > -		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags)) {
> > > > > -			if (cpu == curcpu)
> > > > > -				drain_local_stock(&stock->work);
> > > > > -			else
> > > > > -				schedule_work_on(cpu, &stock->work);
> > > > > -		}
> > > > > +		    !test_and_set_bit(FLUSHING_CACHED_CHARGE, &stock->flags))
> > > > > +			schedule_work_on(cpu, &stock->work);
> > > > 
> > > > Maybe I am missing but on !PREEMPT kernels there is nothing really
> > > > guaranteeing that the worker runs so there should be cond_resched after
> > > > the mutex is unlocked. I do not think we want to rely on callers to be
> > > > aware of this subtlety.
> > > 
> > > There is no guarantee on PREEMPT kernels, too. The worker will be made
> > > running and will be put on the CPU when the scheduler sees it fit and
> > > there could be other worker which take precedence (queued earlier).
> > > But I was not aware that the worker _needs_ to run before we return.
> > 
> > A lack of draining will not be a correctness problem (sorry I should
> > have made that clear). It is more about subtlety than anything. E.g. the
> > charging path could be forced to memory reclaim because of the cached
> > charges which are still waiting for their draining. Not really something
> > to lose sleep over from the runtime perspective. I was just wondering
> > that this makes things more complex than necessary.
> 
> So it is no strictly wrong but it would be better if we could do
> drain_local_stock() on the local CPU.
> 
> > > We
> > > might get migrated after put_cpu() so I wasn't aware that this is
> > > important. Should we attempt best effort and wait for the worker on the
> > > current CPU?
> > 
> > 
> > > > An alternative would be to split out __drain_local_stock which doesn't
> > > > do local_lock.
> > > 
> > > but isn't the section in drain_local_stock() unprotected then?
> > 
> > local_lock instead of {get,put}_cpu would handle that right?
> 
> It took a while, but it clicked :)
> If we acquire the lock_lock_t, that we would otherwise acquire in
> drain_local_stock(), before the for_each_cpu loop (as you say
> get,pu_cpu) then we would indeed need __drain_local_stock() and things
> would work. But it looks like an abuse of the lock to avoid CPU
> migration since there is no need to have it acquired at this point. Also
> the whole section would run with disabled interrupts and there is no
> need for it.
> 
> What about if replace get_cpu() with migrate_disable()? 

Yeah, that would be a better option. I am just not used to think in RT
so migrate_disable didn't really come to my mind.

-- 
Michal Hocko
SUSE Labs
