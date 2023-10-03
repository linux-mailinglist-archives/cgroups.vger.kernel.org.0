Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEBBB7B6DFE
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 18:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjJCQGt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 12:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240261AbjJCQGs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 12:06:48 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [IPv6:2001:41d0:1004:224b::be])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC62AB
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 09:06:44 -0700 (PDT)
Date:   Tue, 3 Oct 2023 09:06:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696349202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tRheB7dETWf8f4OAiyndFdU2UVxXlXBvd7C4CoDG3TU=;
        b=HGW90tkxTBjygi4RoJR32zHjjtfg8fkKEkDJxZqeuBobY/HHNGCENMNy1rysNoGjI+5qco
        KV33S9OqA2Gu5B1LimooAIORHHK5wXzZLkX7/UH+SBxULBvecb4YNTpQKI0RYu7EpKWXeh
        Lew/eGx9aHP4rQiu5KVyV48Vu0mjUlg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rfc 2/5] mm: kmem: add direct objcg pointer to task_struct
Message-ID: <ZRw8AvDt2wrDlKhG@P9FQF9L96D.corp.robot.car>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
 <20230927150832.335132-3-roman.gushchin@linux.dev>
 <20231002201254.GA8435@cmpxchg.org>
 <ZRs-RKsOhtO3eclx@P9FQF9L96D>
 <20231003142255.GE17012@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003142255.GE17012@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 03, 2023 at 10:22:55AM -0400, Johannes Weiner wrote:
> On Mon, Oct 02, 2023 at 03:03:48PM -0700, Roman Gushchin wrote:
> > On Mon, Oct 02, 2023 at 04:12:54PM -0400, Johannes Weiner wrote:
> > > On Wed, Sep 27, 2023 at 08:08:29AM -0700, Roman Gushchin wrote:
> > > > @@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
> > > >  	return objcg;
> > > >  }
> > > >  
> > > > +static DEFINE_SPINLOCK(current_objcg_lock);
> > > > +
> > > > +static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
> > > > +{
> > > > +	struct mem_cgroup *memcg;
> > > > +	struct obj_cgroup *objcg;
> > > > +	unsigned long flags;
> > > > +
> > > > +	old = current_objcg_clear_update_flag(old);
> > > > +	if (old)
> > > > +		obj_cgroup_put(old);
> > > > +
> > > > +	spin_lock_irqsave(&current_objcg_lock, flags);
> > > > +	rcu_read_lock();
> > > > +	memcg = mem_cgroup_from_task(current);
> > > > +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > > > +		objcg = rcu_dereference(memcg->objcg);
> > > > +		if (objcg && obj_cgroup_tryget(objcg))
> > > > +			break;
> > > > +		objcg = NULL;
> > > > +	}
> > > > +	rcu_read_unlock();
> > > 
> > > Can this tryget() actually fail when this is called on the current
> > > task during fork() and attach()? A cgroup cannot be offlined while
> > > there is a task in it.
> > 
> > Highly theoretically it can if it races against a migration of the current
> > task to another memcg and the previous memcg is getting offlined.
> 
> Ah right, if this runs between css_set_move_task() and ->attach(). The
> cache would be briefly updated to a parent in the old hierarchy, but
> then quickly reset from the ->attach().

Even simpler:
	rcu_read_lock();
	memcg = mem_cgroup_from_task(current);
---------
	Here the task can be moved to another memcg and the previous one
	can be offlined, making objcg fully detached.
---------
	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
		objcg = rcu_dereference(memcg->objcg);
		if (objcg && obj_cgroup_tryget(objcg))
---------
	Objcg can be NULL here or it can be not NULL, but loose the last reference
	between the objcg check and obj_cgroup_tryget().
---------
			break;
		objcg = NULL;
	}
	rcu_read_unlock();

> 
> Can you please add a comment along these lines?

Sure, will do.

> 
> > I actually might make sense to apply the same approach for memcgs as well
> > (saving a lazily-updating memcg pointer on task_struct). Then it will be
> > possible to ditch this "for" loop. But I need some time to master the code
> > and run benchmarks. Idk if it will make enough difference to justify the change.
> 
> Yeah the memcg pointer is slightly less attractive from an
> optimization POV because it already is a pretty direct pointer from
> task through the cset array.
> 
> If you still want to look into it from a simplification POV that
> sounds reasonable, but IMO it would be fine with a comment.

I'll come back with some numbers, hard to speculate without it. In this case
the majority of savings came from not bumping and decreasing a percpu objcg
refcounter on the slab allocation path - that was quite surprising to me.

> 
> > > > @@ -6345,6 +6393,22 @@ static void mem_cgroup_move_task(void)
> > > >  		mem_cgroup_clear_mc();
> > > >  	}
> > > >  }
> > > > +
> > > > +#ifdef CONFIG_MEMCG_KMEM
> > > > +static void mem_cgroup_fork(struct task_struct *task)
> > > > +{
> > > > +	task->objcg = (struct obj_cgroup *)0x1;
> > > 
> > > dup_task_struct() will copy this pointer from the old task. Would it
> > > be possible to bump the refcount here instead? That would save quite a
> > > bit of work during fork().
> > 
> > Yeah, it should be possible. It won't save a lot, but I agree it makes
> > sense. I'll take a look and will prepare a separate patch for this.
> 
> I guess the hairiest part would be synchronizing against a migration
> because all these cgroup core callbacks are unlocked.

Yep.

> 
> Would it make sense to add ->fork_locked() and ->attach_locked()
> callbacks that are dispatched under the css_set_lock? Then this could
> be a simple if (p && !(p & 0x1)) obj_cgroup_get(), which would
> certainly be nice to workloads where fork() is hot, with little
> downside otherwise.

Maybe, but then the question is if it really worth it. In the final version
the update path doesn't need a spinlock, so it's quite cheap and happens
once on the first allocation, so Idk if it's worth it at all, but I'll take
a look.

I think the bigger question I have here (and probably worth a lsfmmbpf/plumbers
discussion) - what if we introduce a cgroup mount (or even Kconfig) option to
prohibit moving tasks between cgroups and rely solely on fork to enter the right
cgroup (a-la namespaces). I start thinking that this is the right path long-term,
things will be not only more reliable, but we also can ditch a lot of
synchronization and get better performance. Obviously not a small project.

Thanks!
