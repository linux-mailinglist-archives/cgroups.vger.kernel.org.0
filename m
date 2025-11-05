Return-Path: <cgroups+bounces-11589-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC0DFC349CA
	for <lists+cgroups@lfdr.de>; Wed, 05 Nov 2025 09:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C083F4608B4
	for <lists+cgroups@lfdr.de>; Wed,  5 Nov 2025 08:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8BE2DF3F9;
	Wed,  5 Nov 2025 08:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eh/hNEFe"
X-Original-To: cgroups@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A5D2DF3E7;
	Wed,  5 Nov 2025 08:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762332646; cv=none; b=gIarW3cAwy4iuBefMIYXrulsdh+q2Ca4hf65xKKZ9eU7uuJVl/7UWsSzOMB6lnmH1iqFoPdXdyodri0m6JU2pwMThSu/IG8IIhAEDjqJNV8rhU7dQQLN/YAZXL333srYAuIDZ343GzZ+GKqnOoUtCSiPxNCerfd0xUq/cluLzqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762332646; c=relaxed/simple;
	bh=alJ9DKvAA2XoUuggZMhfcSIPBk05leBN7BQvLxH2hNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jD7zgvQ/2LjhHerWnTqdutsGaAVb6wa6iybggZVaSdLH8Qvh+A7BebPYY/KGe81HqzmuybCfSU8rS3rn8reLkBJyadeypNRurIxFUHjiPJvsHj4YAIiElAf/KXOfSqe58vV6YSak9kHxVrDb3qeqnSKPKTDHyI53ZStxTIYCtLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Eh/hNEFe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nq4ZIpIK78yQorT4DeV/yv+XuJFAASDfY7zS+pTaBeg=; b=Eh/hNEFekqYCQEYPx70gg5sqFH
	cG5REJ1Cc2Ea1bondqq6Lxm5sQHI8BtYjV9Er7e/Ig/HHMZSajbRBHIZ3l+6SHdlES4Ve3riczw18
	MKzZ/QlEVcSJuz3+mlHcORCYGrHE+rs2hC9x8rjni+C9XJwxiZMy3iw5tAT+1hl9XcnlfpVdroaI8
	yynfwPHCSKxAKh68RTrRx9yQOa62bfiJDjJIJXMj5R0rNg8dgScwKT+rWa+l9Tax3vQvvOW6RZl1Z
	/gwI67KJ9CLknOByEK0FAY6UwZRxn4m4TqRDUmn3uZluDrAUEqVR4dlbgiV/iAyQmCzZfc4JLRxya
	JHcgcunw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZDw-00000000RmF-2Lw6;
	Wed, 05 Nov 2025 08:50:37 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 7802C300230; Wed, 05 Nov 2025 09:50:36 +0100 (CET)
Date: Wed, 5 Nov 2025 09:50:36 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, cgroups@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH cgroup/for-6.19 1/2] cgroup: Convert css_set_lock from
 spinlock_t to raw_spinlock_t
Message-ID: <20251105085036.GN4067720@noisy.programming.kicks-ass.net>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d03d2a6e0d0a09e9da6a54370f253c00@kernel.org>

On Tue, Nov 04, 2025 at 09:32:24AM -1000, Tejun Heo wrote:
> Convert css_set_lock from spinlock_t to raw_spinlock_t to address RT-related
> scheduling constraints. cgroup_task_dead() is called from finish_task_switch()
> which cannot schedule even in PREEMPT_RT kernels, requiring css_set_lock to be
> a raw spinlock to avoid sleeping in a non-preemptible context.

The constraint for doing so, is that each critical section is actually
bounded in time. The below seem to contain list iteration. I'm thinking
it is unbounded since userspace is on control of the cgroup hierarchy.

> Fixes: d245698d727a ("cgroup: Defer task cgroup unlink until after the task is done switching out")
> Reported-by: Calvin Owens <calvin@wbinvd.org>
> Link: https://lore.kernel.org/r/20251104181114.489391-1-calvin@wbinvd.org
> Signed-off-by: Tejun Heo <tj@kernel.org>
>  kernel/cgroup/cgroup.c          |  130 ++++++++++++++++++++--------------------
>  kernel/cgroup/debug.c           |   12 +--
>  kernel/cgroup/freezer.c         |   16 ++--
>  kernel/cgroup/namespace.c       |    4 -
>  7 files changed, 91 insertions(+), 89 deletions(-)
> 
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -76,7 +76,7 @@ enum cgroup_lifetime_events {
>  extern struct file_system_type cgroup_fs_type;
>  extern struct cgroup_root cgrp_dfl_root;
>  extern struct css_set init_css_set;
> -extern spinlock_t css_set_lock;
> +extern raw_spinlock_t css_set_lock;
>  extern struct blocking_notifier_head cgroup_lifetime_notifier;
>  
>  #define SUBSYS(_x) extern struct cgroup_subsys _x ## _cgrp_subsys;
> --- a/kernel/cgroup/cgroup-internal.h
> +++ b/kernel/cgroup/cgroup-internal.h
> @@ -208,9 +208,9 @@ static inline void put_css_set(struct cs
>  	if (refcount_dec_not_one(&cset->refcount))
>  		return;
>  
> -	spin_lock_irqsave(&css_set_lock, flags);
> +	raw_spin_lock_irqsave(&css_set_lock, flags);
>  	put_css_set_locked(cset);
> -	spin_unlock_irqrestore(&css_set_lock, flags);
> +	raw_spin_unlock_irqrestore(&css_set_lock, flags);
>  }
>  
>  /*
> --- a/kernel/cgroup/cgroup-v1.c
> +++ b/kernel/cgroup/cgroup-v1.c
> @@ -73,9 +73,9 @@ int cgroup_attach_task_all(struct task_s
>  	for_each_root(root) {
>  		struct cgroup *from_cgrp;
>  
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  		from_cgrp = task_cgroup_from_root(from, root);
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  
>  		retval = cgroup_attach_task(from_cgrp, tsk, false);
>  		if (retval)
> @@ -121,10 +121,10 @@ int cgroup_transfer_tasks(struct cgroup
>  	cgroup_attach_lock(CGRP_ATTACH_LOCK_GLOBAL, NULL);
>  
>  	/* all tasks in @from are being moved, all csets are source */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	list_for_each_entry(link, &from->cset_links, cset_link)
>  		cgroup_migrate_add_src(link->cset, to, &mgctx);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	ret = cgroup_migrate_prepare_dst(&mgctx);
>  	if (ret)
> @@ -1308,11 +1308,11 @@ struct cgroup *task_get_cgroup1(struct t
>  			continue;
>  		if (root->hierarchy_id != hierarchy_id)
>  			continue;
> -		spin_lock_irqsave(&css_set_lock, flags);
> +		raw_spin_lock_irqsave(&css_set_lock, flags);
>  		cgrp = task_cgroup_from_root(tsk, root);
>  		if (!cgrp || !cgroup_tryget(cgrp))
>  			cgrp = ERR_PTR(-ENOENT);
> -		spin_unlock_irqrestore(&css_set_lock, flags);
> +		raw_spin_unlock_irqrestore(&css_set_lock, flags);
>  		break;
>  	}
>  	rcu_read_unlock();
> --- a/kernel/cgroup/cgroup.c
> +++ b/kernel/cgroup/cgroup.c
> @@ -83,13 +83,15 @@
>   * hierarchy must be performed while holding it.
>   *
>   * css_set_lock protects task->cgroups pointer, the list of css_set
> - * objects, and the chain of tasks off each css_set.
> + * objects, and the chain of tasks off each css_set. This needs to be
> + * a raw spinlock as cgroup_task_dead() which grabs the lock is called
> + * from finish_task_switch() which can't schedule even in RT.
>   *
>   * These locks are exported if CONFIG_PROVE_RCU so that accessors in
>   * cgroup.h can use them for lockdep annotations.
>   */
>  DEFINE_MUTEX(cgroup_mutex);
> -DEFINE_SPINLOCK(css_set_lock);
> +DEFINE_RAW_SPINLOCK(css_set_lock);
>  
>  #if (defined CONFIG_PROVE_RCU || defined CONFIG_LOCKDEP)
>  EXPORT_SYMBOL_GPL(cgroup_mutex);
> @@ -666,9 +668,9 @@ int cgroup_task_count(const struct cgrou
>  {
>  	int count;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	count = __cgroup_task_count(cgrp);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	return count;
>  }
> @@ -1236,11 +1238,11 @@ static struct css_set *find_css_set(stru
>  
>  	/* First see if we already have a cgroup group that matches
>  	 * the desired set */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cset = find_existing_css_set(old_cset, cgrp, template);
>  	if (cset)
>  		get_css_set(cset);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	if (cset)
>  		return cset;
> @@ -1272,7 +1274,7 @@ static struct css_set *find_css_set(stru
>  	 * find_existing_css_set() */
>  	memcpy(cset->subsys, template, sizeof(cset->subsys));
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	/* Add reference counts and links from the new css_set. */
>  	list_for_each_entry(link, &old_cset->cgrp_links, cgrp_link) {
>  		struct cgroup *c = link->cgrp;
> @@ -1298,7 +1300,7 @@ static struct css_set *find_css_set(stru
>  		css_get(css);
>  	}
>  
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * If @cset should be threaded, look up the matching dom_cset and
> @@ -1315,11 +1317,11 @@ static struct css_set *find_css_set(stru
>  			return NULL;
>  		}
>  
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  		cset->dom_cset = dcset;
>  		list_add_tail(&cset->threaded_csets_node,
>  			      &dcset->threaded_csets);
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  	}
>  
>  	return cset;
> @@ -1412,7 +1414,7 @@ static void cgroup_destroy_root(struct c
>  	 * Release all the links from cset_links to this hierarchy's
>  	 * root cgroup
>  	 */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	list_for_each_entry_safe(link, tmp_link, &cgrp->cset_links, cset_link) {
>  		list_del(&link->cset_link);
> @@ -1420,7 +1422,7 @@ static void cgroup_destroy_root(struct c
>  		kfree(link);
>  	}
>  
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	WARN_ON_ONCE(list_empty(&root->root_list));
>  	list_del_rcu(&root->root_list);
> @@ -1917,7 +1919,7 @@ int rebind_subsystems(struct cgroup_root
>  		rcu_assign_pointer(dcgrp->subsys[ssid], css);
>  		ss->root = dst_root;
>  
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  		css->cgroup = dcgrp;
>  		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
>  		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
> @@ -1935,7 +1937,7 @@ int rebind_subsystems(struct cgroup_root
>  				if (it->cset_head == &scgrp->e_csets[ss->id])
>  					it->cset_head = &dcgrp->e_csets[ss->id];
>  		}
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  
>  		/* default hierarchy doesn't enable controllers by default */
>  		dst_root->subsys_mask |= 1 << ssid;
> @@ -1971,10 +1973,10 @@ int cgroup_show_path(struct seq_file *sf
>  	if (!buf)
>  		return -ENOMEM;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	ns_cgroup = current_cgns_cgroup_from_root(kf_cgroot);
>  	len = kernfs_path_from_node(kf_node, ns_cgroup->kn, buf, PATH_MAX);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	if (len == -E2BIG)
>  		len = -ERANGE;
> @@ -2230,13 +2232,13 @@ int cgroup_setup_root(struct cgroup_root
>  	 * Link the root cgroup in this hierarchy into all the css_set
>  	 * objects.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	hash_for_each(css_set_table, i, cset, hlist) {
>  		link_css_set(&tmp_links, cset, root_cgrp);
>  		if (css_set_populated(cset))
>  			cgroup_update_populated(root_cgrp, true);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	BUG_ON(!list_empty(&root_cgrp->self.children));
>  	BUG_ON(atomic_read(&root->nr_cgrps) != 1);
> @@ -2280,11 +2282,11 @@ int cgroup_do_get_tree(struct fs_context
>  		struct cgroup *cgrp;
>  
>  		cgroup_lock();
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  
>  		cgrp = cset_cgroup_from_root(ctx->ns->root_cset, ctx->root);
>  
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  		cgroup_unlock();
>  
>  		nsdentry = kernfs_node_dentry(cgrp->kn, sb);
> @@ -2496,11 +2498,11 @@ int cgroup_path_ns(struct cgroup *cgrp,
>  	int ret;
>  
>  	cgroup_lock();
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	ret = cgroup_path_ns_locked(cgrp, buf, buflen, ns);
>  
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  	cgroup_unlock();
>  
>  	return ret;
> @@ -2719,7 +2721,7 @@ static int cgroup_migrate_execute(struct
>  	 * the new cgroup.  There are no failure cases after here, so this
>  	 * is the commit point.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	list_for_each_entry(cset, &tset->src_csets, mg_node) {
>  		list_for_each_entry_safe(task, tmp_task, &cset->mg_tasks, cg_list) {
>  			struct css_set *from_cset = task_css_set(task);
> @@ -2739,7 +2741,7 @@ static int cgroup_migrate_execute(struct
>  
>  		}
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * Migration is committed, all target tasks are now on dst_csets.
> @@ -2772,13 +2774,13 @@ out_cancel_attach:
>  		} while_each_subsys_mask();
>  	}
>  out_release_tset:
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	list_splice_init(&tset->dst_csets, &tset->src_csets);
>  	list_for_each_entry_safe(cset, tmp_cset, &tset->src_csets, mg_node) {
>  		list_splice_tail_init(&cset->mg_tasks, &cset->tasks);
>  		list_del_init(&cset->mg_node);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * Re-initialize the cgroup_taskset structure in case it is reused
> @@ -2836,7 +2838,7 @@ void cgroup_migrate_finish(struct cgroup
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	list_for_each_entry_safe(cset, tmp_cset, &mgctx->preloaded_src_csets,
>  				 mg_src_preload_node) {
> @@ -2856,7 +2858,7 @@ void cgroup_migrate_finish(struct cgroup
>  		put_css_set_locked(cset);
>  	}
>  
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  }
>  
>  /**
> @@ -2999,14 +3001,14 @@ int cgroup_migrate(struct task_struct *l
>  	 * section to prevent tasks from being freed while taking the snapshot.
>  	 * spin_lock_irq() implies RCU critical section here.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	task = leader;
>  	do {
>  		cgroup_migrate_add_task(task, mgctx);
>  		if (!threadgroup)
>  			break;
>  	} while_each_thread(leader, task);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	return cgroup_migrate_execute(mgctx);
>  }
> @@ -3027,14 +3029,14 @@ int cgroup_attach_task(struct cgroup *ds
>  	int ret = 0;
>  
>  	/* look up all src csets */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	task = leader;
>  	do {
>  		cgroup_migrate_add_src(task_css_set(task), dst_cgrp, &mgctx);
>  		if (!threadgroup)
>  			break;
>  	} while_each_thread(leader, task);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/* prepare dst csets and commit */
>  	ret = cgroup_migrate_prepare_dst(&mgctx);
> @@ -3191,7 +3193,7 @@ static int cgroup_update_dfl_csses(struc
>  	lockdep_assert_held(&cgroup_mutex);
>  
>  	/* look up all csses currently attached to @cgrp's subtree */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cgroup_for_each_live_descendant_pre(dsct, d_css, cgrp) {
>  		struct cgrp_cset_link *link;
>  
> @@ -3207,7 +3209,7 @@ static int cgroup_update_dfl_csses(struc
>  		list_for_each_entry(link, &dsct->cset_links, cset_link)
>  			cgroup_migrate_add_src(link->cset, dsct, &mgctx);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * We need to write-lock threadgroup_rwsem while migrating tasks.
> @@ -3229,7 +3231,7 @@ static int cgroup_update_dfl_csses(struc
>  	if (ret)
>  		goto out_finish;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	list_for_each_entry(src_cset, &mgctx.preloaded_src_csets,
>  			    mg_src_preload_node) {
>  		struct task_struct *task, *ntask;
> @@ -3238,7 +3240,7 @@ static int cgroup_update_dfl_csses(struc
>  		list_for_each_entry_safe(task, ntask, &src_cset->tasks, cg_list)
>  			cgroup_migrate_add_task(task, &mgctx);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	ret = cgroup_migrate_execute(&mgctx);
>  out_finish:
> @@ -4186,9 +4188,9 @@ static void __cgroup_kill(struct cgroup
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cgrp->kill_seq++;
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	css_task_iter_start(&cgrp->self, CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED, &it);
>  	while ((task = css_task_iter_next(&it))) {
> @@ -5146,7 +5148,7 @@ void css_task_iter_start(struct cgroup_s
>  
>  	memset(it, 0, sizeof(*it));
>  
> -	spin_lock_irqsave(&css_set_lock, irqflags);
> +	raw_spin_lock_irqsave(&css_set_lock, irqflags);
>  
>  	it->ss = css->ss;
>  	it->flags = flags;
> @@ -5160,7 +5162,7 @@ void css_task_iter_start(struct cgroup_s
>  
>  	css_task_iter_advance(it);
>  
> -	spin_unlock_irqrestore(&css_set_lock, irqflags);
> +	raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
>  }
>  
>  /**
> @@ -5180,7 +5182,7 @@ struct task_struct *css_task_iter_next(s
>  		it->cur_task = NULL;
>  	}
>  
> -	spin_lock_irqsave(&css_set_lock, irqflags);
> +	raw_spin_lock_irqsave(&css_set_lock, irqflags);
>  
>  	/* @it may be half-advanced by skips, finish advancing */
>  	if (it->flags & CSS_TASK_ITER_SKIPPED)
> @@ -5193,7 +5195,7 @@ struct task_struct *css_task_iter_next(s
>  		css_task_iter_advance(it);
>  	}
>  
> -	spin_unlock_irqrestore(&css_set_lock, irqflags);
> +	raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
>  
>  	return it->cur_task;
>  }
> @@ -5209,10 +5211,10 @@ void css_task_iter_end(struct css_task_i
>  	unsigned long irqflags;
>  
>  	if (it->cur_cset) {
> -		spin_lock_irqsave(&css_set_lock, irqflags);
> +		raw_spin_lock_irqsave(&css_set_lock, irqflags);
>  		list_del(&it->iters_node);
>  		put_css_set_locked(it->cur_cset);
> -		spin_unlock_irqrestore(&css_set_lock, irqflags);
> +		raw_spin_unlock_irqrestore(&css_set_lock, irqflags);
>  	}
>  
>  	if (it->cur_dcset)
> @@ -5378,9 +5380,9 @@ static ssize_t __cgroup_procs_write(stru
>  		goto out_unlock;
>  
>  	/* find the source cgroup */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	src_cgrp = task_cgroup_from_root(task, &cgrp_dfl_root);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * Process and thread migrations follow same delegation rule. Check
> @@ -5667,11 +5669,11 @@ static void css_release_work_fn(struct w
>  
>  		css_rstat_flush(&cgrp->self);
>  
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  		for (tcgrp = cgroup_parent(cgrp); tcgrp;
>  		     tcgrp = cgroup_parent(tcgrp))
>  			tcgrp->nr_dying_descendants--;
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  
>  		/*
>  		 * There are two control paths which try to determine
> @@ -5922,7 +5924,7 @@ static struct cgroup *cgroup_create(stru
>  		goto out_psi_free;
>  
>  	/* allocation complete, commit to creation */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	for (i = 0; i < level; i++) {
>  		tcgrp = cgrp->ancestors[i];
>  		tcgrp->nr_descendants++;
> @@ -5935,7 +5937,7 @@ static struct cgroup *cgroup_create(stru
>  		if (cgrp->freezer.e_freeze)
>  			tcgrp->freezer.nr_frozen_descendants++;
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	list_add_tail_rcu(&cgrp->self.sibling, &cgroup_parent(cgrp)->self.children);
>  	atomic_inc(&root->nr_cgrps);
> @@ -6181,10 +6183,10 @@ static int cgroup_destroy_locked(struct
>  	 */
>  	cgrp->self.flags &= ~CSS_ONLINE;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	list_for_each_entry(link, &cgrp->cset_links, cset_link)
>  		link->cset->dead = true;
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/* initiate massacre of all css's */
>  	for_each_css(css, ssid, cgrp)
> @@ -6197,7 +6199,7 @@ static int cgroup_destroy_locked(struct
>  	if (cgroup_is_threaded(cgrp))
>  		parent->nr_threaded_children--;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	for (tcgrp = parent; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
>  		tcgrp->nr_descendants--;
>  		tcgrp->nr_dying_descendants++;
> @@ -6208,7 +6210,7 @@ static int cgroup_destroy_locked(struct
>  		if (test_bit(CGRP_FROZEN, &cgrp->flags))
>  			tcgrp->freezer.nr_frozen_descendants--;
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	cgroup1_check_for_release(parent);
>  
> @@ -6557,7 +6559,7 @@ int proc_cgroup_show(struct seq_file *m,
>  		goto out;
>  
>  	rcu_read_lock();
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	for_each_root(root) {
>  		struct cgroup_subsys *ss;
> @@ -6612,7 +6614,7 @@ int proc_cgroup_show(struct seq_file *m,
>  
>  	retval = 0;
>  out_unlock:
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  	rcu_read_unlock();
>  	kfree(buf);
>  out:
> @@ -6700,14 +6702,14 @@ static int cgroup_css_set_fork(struct ke
>  
>  	cgroup_threadgroup_change_begin(current);
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cset = task_css_set(current);
>  	get_css_set(cset);
>  	if (kargs->cgrp)
>  		kargs->kill_seq = kargs->cgrp->kill_seq;
>  	else
>  		kargs->kill_seq = cset->dfl_cgrp->kill_seq;
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	if (!(kargs->flags & CLONE_INTO_CGROUP)) {
>  		kargs->cset = cset;
> @@ -6897,7 +6899,7 @@ void cgroup_post_fork(struct task_struct
>  	cset = kargs->cset;
>  	kargs->cset = NULL;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	/* init tasks are special, only link regular threads */
>  	if (likely(child->pid)) {
> @@ -6945,7 +6947,7 @@ void cgroup_post_fork(struct task_struct
>  		kill = kargs->kill_seq != cgrp_kill_seq;
>  	}
>  
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	/*
>  	 * Call ss->fork().  This must happen after @child is linked on
> @@ -6995,7 +6997,7 @@ void cgroup_task_dead(struct task_struct
>  	struct css_set *cset;
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&css_set_lock, flags);
> +	raw_spin_lock_irqsave(&css_set_lock, flags);
>  
>  	WARN_ON_ONCE(list_empty(&tsk->cg_list));
>  	cset = task_css_set(tsk);
> @@ -7013,7 +7015,7 @@ void cgroup_task_dead(struct task_struct
>  		     test_bit(CGRP_FREEZE, &task_dfl_cgroup(tsk)->flags)))
>  		cgroup_update_frozen(task_dfl_cgroup(tsk));
>  
> -	spin_unlock_irqrestore(&css_set_lock, flags);
> +	raw_spin_unlock_irqrestore(&css_set_lock, flags);
>  }
>  
>  void cgroup_task_release(struct task_struct *task)
> @@ -7031,10 +7033,10 @@ void cgroup_task_free(struct task_struct
>  	struct css_set *cset = task_css_set(task);
>  
>  	if (!list_empty(&task->cg_list)) {
> -		spin_lock_irq(&css_set_lock);
> +		raw_spin_lock_irq(&css_set_lock);
>  		css_set_skip_task_iters(task_css_set(task), task);
>  		list_del_init(&task->cg_list);
> -		spin_unlock_irq(&css_set_lock);
> +		raw_spin_unlock_irq(&css_set_lock);
>  	}
>  
>  	put_css_set(cset);
> --- a/kernel/cgroup/debug.c
> +++ b/kernel/cgroup/debug.c
> @@ -48,7 +48,7 @@ static int current_css_set_read(struct s
>  	if (!cgroup_kn_lock_live(of->kn, false))
>  		return -ENODEV;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cset = task_css_set(current);
>  	refcnt = refcount_read(&cset->refcount);
>  	seq_printf(seq, "css_set %pK %d", cset, refcnt);
> @@ -66,7 +66,7 @@ static int current_css_set_read(struct s
>  		seq_printf(seq, "%2d: %-4s\t- %p[%d]\n", ss->id, ss->name,
>  			  css, css->id);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  	cgroup_kn_unlock(of->kn);
>  	return 0;
>  }
> @@ -92,7 +92,7 @@ static int current_css_set_cg_links_read
>  	if (!name_buf)
>  		return -ENOMEM;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cset = task_css_set(current);
>  	list_for_each_entry(link, &cset->cgrp_links, cgrp_link) {
>  		struct cgroup *c = link->cgrp;
> @@ -101,7 +101,7 @@ static int current_css_set_cg_links_read
>  		seq_printf(seq, "Root %d group %s\n",
>  			   c->root->hierarchy_id, name_buf);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  	kfree(name_buf);
>  	return 0;
>  }
> @@ -113,7 +113,7 @@ static int cgroup_css_links_read(struct
>  	struct cgrp_cset_link *link;
>  	int dead_cnt = 0, extra_refs = 0, threaded_csets = 0;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  
>  	list_for_each_entry(link, &css->cgroup->cset_links, cset_link) {
>  		struct css_set *cset = link->cset;
> @@ -180,7 +180,7 @@ static int cgroup_css_links_read(struct
>  
>  		WARN_ON(count != cset->nr_tasks);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	if (!dead_cnt && !extra_refs && !threaded_csets)
>  		return 0;
> --- a/kernel/cgroup/freezer.c
> +++ b/kernel/cgroup/freezer.c
> @@ -108,12 +108,12 @@ void cgroup_enter_frozen(void)
>  	if (current->frozen)
>  		return;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	current->frozen = true;
>  	cgrp = task_dfl_cgroup(current);
>  	cgroup_inc_frozen_cnt(cgrp);
>  	cgroup_update_frozen(cgrp);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  }
>  
>  /*
> @@ -129,7 +129,7 @@ void cgroup_leave_frozen(bool always_lea
>  {
>  	struct cgroup *cgrp;
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cgrp = task_dfl_cgroup(current);
>  	if (always_leave || !test_bit(CGRP_FREEZE, &cgrp->flags)) {
>  		cgroup_dec_frozen_cnt(cgrp);
> @@ -142,7 +142,7 @@ void cgroup_leave_frozen(bool always_lea
>  		set_thread_flag(TIF_SIGPENDING);
>  		spin_unlock(&current->sighand->siglock);
>  	}
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  }
>  
>  /*
> @@ -178,7 +178,7 @@ static void cgroup_do_freeze(struct cgro
>  
>  	lockdep_assert_held(&cgroup_mutex);
>  
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	write_seqcount_begin(&cgrp->freezer.freeze_seq);
>  	if (freeze) {
>  		set_bit(CGRP_FREEZE, &cgrp->flags);
> @@ -189,7 +189,7 @@ static void cgroup_do_freeze(struct cgro
>  			cgrp->freezer.freeze_start_nsec);
>  	}
>  	write_seqcount_end(&cgrp->freezer.freeze_seq);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	if (freeze)
>  		TRACE_CGROUP_PATH(freeze, cgrp);
> @@ -212,10 +212,10 @@ static void cgroup_do_freeze(struct cgro
>  	 * Cgroup state should be revisited here to cover empty leaf cgroups
>  	 * and cgroups which descendants are already in the desired state.
>  	 */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	if (cgrp->nr_descendants == cgrp->freezer.nr_frozen_descendants)
>  		cgroup_update_frozen(cgrp);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  }
>  
>  /*
> --- a/kernel/cgroup/namespace.c
> +++ b/kernel/cgroup/namespace.c
> @@ -70,10 +70,10 @@ struct cgroup_namespace *copy_cgroup_ns(
>  		return ERR_PTR(-ENOSPC);
>  
>  	/* It is not safe to take cgroup_mutex here */
> -	spin_lock_irq(&css_set_lock);
> +	raw_spin_lock_irq(&css_set_lock);
>  	cset = task_css_set(current);
>  	get_css_set(cset);
> -	spin_unlock_irq(&css_set_lock);
> +	raw_spin_unlock_irq(&css_set_lock);
>  
>  	new_ns = alloc_cgroup_ns();
>  	if (IS_ERR(new_ns)) {

