Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEE67CE48F
	for <lists+cgroups@lfdr.de>; Wed, 18 Oct 2023 19:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbjJRRaM (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 18 Oct 2023 13:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231222AbjJRR3s (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 18 Oct 2023 13:29:48 -0400
Received: from out-200.mta0.migadu.com (out-200.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909B3C03
        for <cgroups@vger.kernel.org>; Wed, 18 Oct 2023 10:22:40 -0700 (PDT)
Date:   Wed, 18 Oct 2023 10:22:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1697649756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+ZHjqgjJ0DJw5b20QDmJoc6vBigpsp2ZBEUURZnoLsI=;
        b=GaTsb0RAXezus1Vlp+8lGAEICHr1ef9aRz8NOtZuHWbQyJ/aZCBv92T34FHPtPUwZXDY/u
        w9iKSPUBX7e5vW9uGpTT0cLKiU+yCd07Pknzq0bCZdZ/qDG3KDpkKs2qgawTgbKrwuk2gq
        DOEP/2oNVLZm88rFvJQFv0J9V5YGklU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, shakeelb@google.com,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: Re: [PATCH v3 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <ZTAUTWO2UfI0VoPL@P9FQF9L96D.corp.robot.car>
References: <20231016221900.4031141-1-roman.gushchin@linux.dev>
 <20231016221900.4031141-3-roman.gushchin@linux.dev>
 <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d698b8d0-1697-e336-bccb-592e633e8b98@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 18, 2023 at 11:52:27AM +0200, Vlastimil Babka wrote:
> On 10/17/23 00:18, Roman Gushchin wrote:
> > To charge a freshly allocated kernel object to a memory cgroup, the
> > kernel needs to obtain an objcg pointer. Currently it does it
> > indirectly by obtaining the memcg pointer first and then calling to
> > __get_obj_cgroup_from_memcg().
> > 
> > Usually tasks spend their entire life belonging to the same object
> > cgroup. So it makes sense to save the objcg pointer on task_struct
> > directly, so it can be obtained faster. It requires some work on fork,
> > exit and cgroup migrate paths, but these paths are way colder.
> > 
> > To avoid any costly synchronization the following rules are applied:
> > 1) A task sets it's objcg pointer itself.
> > 
> > 2) If a task is being migrated to another cgroup, the least
> >    significant bit of the objcg pointer is set atomically.
> > 
> > 3) On the allocation path the objcg pointer is obtained locklessly
> >    using the READ_ONCE() macro and the least significant bit is
> >    checked. If it's set, the following procedure is used to update
> >    it locklessly:
> >        - task->objcg is zeroed using cmpxcg
> >        - new objcg pointer is obtained
> >        - task->objcg is updated using try_cmpxchg
> >        - operation is repeated if try_cmpxcg fails
> >    It guarantees that no updates will be lost if task migration
> >    is racing against objcg pointer update. It also allows to keep
> >    both read and write paths fully lockless.
> > 
> > Because the task is keeping a reference to the objcg, it can't go away
> > while the task is alive.
> > 
> > This commit doesn't change the way the remote memcg charging works.
> > 
> > Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> > Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > ---
> >  include/linux/sched.h |   4 ++
> >  mm/memcontrol.c       | 130 +++++++++++++++++++++++++++++++++++++++---
> >  2 files changed, 125 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 16ac2a5838fb..0605e45bd4a2 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> 
> So IIUC here we increase objcg refcount.
> 
> > +				break;
> > +			objcg = NULL;
> > +		}
> > +		rcu_read_unlock();
> > +
> > +		/*
> > +		 * Try set up a new objcg pointer atomically. If it
> > +		 * fails, it means the update flag was set concurrently, so
> > +		 * the whole procedure should be repeated.
> > +		 */
> > +	} while (!try_cmpxchg(&current->objcg, &old, objcg));
> 
> And if this fails we throw objcg away and try again, but we should do
> obj_cgroup_put(objcg) first, as otherwise it would cause a leak?

Great catch! Thanks!

> 
> > +
> > +	return objcg;
> > +}
> > +
> >  __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >  {
> >  	struct mem_cgroup *memcg;
> > @@ -3008,19 +3054,26 @@ __always_inline struct obj_cgroup *get_obj_cgroup_from_current(void)
> >  
> >  	if (in_task()) {
> >  		memcg = current->active_memcg;
> > +		if (unlikely(memcg))
> > +			goto from_memcg;
> >  
> > -		/* Memcg to charge can't be determined. */
> > -		if (likely(!memcg) && (!current->mm || (current->flags & PF_KTHREAD)))
> 
> The checks for current->mm and PF_KTHREAD seem to be gone completely after
> the patch, was that intended and why?

There is no need for those anymore because it's as cheap or cheaper
to check task->objcg for being NULL. Those were primarily used to rule out
kernel threads allocations early.

I gonna fix the objcg ref leak, add the comment you asked above and post v4
of this particular patch.

Thank you for reviewing the series!
