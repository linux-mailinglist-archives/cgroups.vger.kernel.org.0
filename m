Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B5F7B5CFD
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 00:03:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjJBWEA (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 18:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbjJBWD7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 18:03:59 -0400
Received: from out-199.mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C994CE
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 15:03:56 -0700 (PDT)
Date:   Mon, 2 Oct 2023 15:03:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696284234;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o3rGOO1zzAI6sGQiZBiVHTxVUTx8U4hPLeaBLW4Dbqo=;
        b=aMU8C6+gDYX9Rh2K28PLdF/LkSHtF/2ivJP7BkQWxGfsHbFh8sB+WnyZIJH8mjr5lSASnq
        2C83mJ6EBVkBQ3aJZeCXqktu2U86y9f3ij7rS5q8KUT5HSqgeObIkkB9411jnq6KVMeunM
        qQMKuH2QKt/oJGXu3jYdhpz+uDzDQpo=
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
Message-ID: <ZRs-RKsOhtO3eclx@P9FQF9L96D>
References: <20230927150832.335132-1-roman.gushchin@linux.dev>
 <20230927150832.335132-3-roman.gushchin@linux.dev>
 <20231002201254.GA8435@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002201254.GA8435@cmpxchg.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Oct 02, 2023 at 04:12:54PM -0400, Johannes Weiner wrote:
> On Wed, Sep 27, 2023 at 08:08:29AM -0700, Roman Gushchin wrote:
> > @@ -3001,6 +3001,47 @@ static struct obj_cgroup *__get_obj_cgroup_from_memcg(struct mem_cgroup *memcg)
> >  	return objcg;
> >  }
> >  
> > +static DEFINE_SPINLOCK(current_objcg_lock);
> > +
> > +static struct obj_cgroup *current_objcg_update(struct obj_cgroup *old)
> > +{
> > +	struct mem_cgroup *memcg;
> > +	struct obj_cgroup *objcg;
> > +	unsigned long flags;
> > +
> > +	old = current_objcg_clear_update_flag(old);
> > +	if (old)
> > +		obj_cgroup_put(old);
> > +
> > +	spin_lock_irqsave(&current_objcg_lock, flags);
> > +	rcu_read_lock();
> > +	memcg = mem_cgroup_from_task(current);
> > +	for (; memcg != root_mem_cgroup; memcg = parent_mem_cgroup(memcg)) {
> > +		objcg = rcu_dereference(memcg->objcg);
> > +		if (objcg && obj_cgroup_tryget(objcg))
> > +			break;
> > +		objcg = NULL;
> > +	}
> > +	rcu_read_unlock();
> 
> Can this tryget() actually fail when this is called on the current
> task during fork() and attach()? A cgroup cannot be offlined while
> there is a task in it.

Highly theoretically it can if it races against a migration of the current
task to another memcg and the previous memcg is getting offlined.

I actually might make sense to apply the same approach for memcgs as well
(saving a lazily-updating memcg pointer on task_struct). Then it will be
possible to ditch this "for" loop. But I need some time to master the code
and run benchmarks. Idk if it will make enough difference to justify the change.

Btw, this is the rfc version, while there is a newer v1 version, which Andrew
already picked for mm-unstable. Both of your comments still apply, just fyi.

> 
> > @@ -6345,6 +6393,22 @@ static void mem_cgroup_move_task(void)
> >  		mem_cgroup_clear_mc();
> >  	}
> >  }
> > +
> > +#ifdef CONFIG_MEMCG_KMEM
> > +static void mem_cgroup_fork(struct task_struct *task)
> > +{
> > +	task->objcg = (struct obj_cgroup *)0x1;
> 
> dup_task_struct() will copy this pointer from the old task. Would it
> be possible to bump the refcount here instead? That would save quite a
> bit of work during fork().

Yeah, it should be possible. It won't save a lot, but I agree it makes
sense. I'll take a look and will prepare a separate patch for this.

Thank you!
