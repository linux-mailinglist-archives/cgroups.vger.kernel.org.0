Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3853D518
	for <lists+cgroups@lfdr.de>; Sat,  4 Jun 2022 05:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiFDD7S (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 3 Jun 2022 23:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbiFDD7Q (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 3 Jun 2022 23:59:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 78ED5CE2D
        for <cgroups@vger.kernel.org>; Fri,  3 Jun 2022 20:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654315150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=frdNSw6VvFSq/dJTwsjI7LLBzyeNJyK6cwhGv34I0Y4=;
        b=Zh9kXgl0Cst5xwggtoppplYMLCjBhLMCWS7G/ojGOcK1uEGtjK6LflgOhKujQBofSjqVW5
        LQjOV4pRo02ZyKkjh9y7ObXYP2NbGtJ2yeAqwFFyXJ4XbA7pI+fEtwd69nC1N8Qj89TRrj
        WZXTaG1wO047ck4Up8i3tghpqGxpSCM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-671-OyIuMPekNhqhy9OiWUO0rA-1; Fri, 03 Jun 2022 23:59:08 -0400
X-MC-Unique: OyIuMPekNhqhy9OiWUO0rA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5BED1C05140;
        Sat,  4 Jun 2022 03:59:07 +0000 (UTC)
Received: from T590 (ovpn-8-17.pek2.redhat.com [10.72.8.17])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0243F492C3B;
        Sat,  4 Jun 2022 03:59:02 +0000 (UTC)
Date:   Sat, 4 Jun 2022 11:58:57 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        cgroups@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH v6 3/3] blk-cgroup: Optimize blkcg_rstat_flush()
Message-ID: <YprYgdV0IxAeJZsz@T590>
References: <20220602192020.166940-1-longman@redhat.com>
 <20220602192020.166940-4-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220602192020.166940-4-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi Waiman,

On Thu, Jun 02, 2022 at 03:20:20PM -0400, Waiman Long wrote:
> For a system with many CPUs and block devices, the time to do
> blkcg_rstat_flush() from cgroup_rstat_flush() can be rather long. It
> can be especially problematic as interrupt is disabled during the flush.
> It was reported that it might take seconds to complete in some extreme
> cases leading to hard lockup messages.
> 
> As it is likely that not all the percpu blkg_iostat_set's has been
> updated since the last flush, those stale blkg_iostat_set's don't need
> to be flushed in this case. This patch optimizes blkcg_rstat_flush()
> by keeping a lockless list of recently updated blkg_iostat_set's in a
> newly added percpu blkcg->lhead pointer.
> 
> The blkg_iostat_set is added to the lockless list on the update side
> in blk_cgroup_bio_start(). It is removed from the lockless list when
> flushed in blkcg_rstat_flush(). Due to racing, it is possible that
> blk_iostat_set's in the lockless list may have no new IO stats to be
> flushed. To protect against destruction of blkg, a percpu reference is
> gotten when putting into the lockless list and put back when removed.
> 
> A blkg_iostat_set can determine if it is in a lockless list by checking
> the content of its lnode.next pointer which will be non-NULL when in
> a lockless list. This requires the presence of a special llist_last
> sentinel node to be put at the end of the lockless list.
> 
> When booting up an instrumented test kernel with this patch on a
> 2-socket 96-thread system with cgroup v2, out of the 2051 calls to
> cgroup_rstat_flush() after bootup, 1788 of the calls were exited
> immediately because of empty lockless list. After an all-cpu kernel
> build, the ratio became 6295424/6340513. That was more than 99%.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Tejun Heo <tj@kernel.org>
> ---
>  block/blk-cgroup.c | 100 ++++++++++++++++++++++++++++++++++++++++++---
>  block/blk-cgroup.h |   9 ++++
>  2 files changed, 103 insertions(+), 6 deletions(-)
> 
> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
> index 9021f75fc752..963a779c4cab 100644
> --- a/block/blk-cgroup.c
> +++ b/block/blk-cgroup.c
> @@ -59,6 +59,71 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
>  
>  #define BLKG_DESTROY_BATCH_SIZE  64
>  
> +/*
> + * Lockless lists for tracking IO stats update
> + *
> + * New IO stats are stored in the percpu iostat_cpu within blkcg_gq (blkg).
> + * There are multiple blkg's (one for each block device) attached to each
> + * blkcg. The rstat code keeps track of which cpu has IO stats updated,
> + * but it doesn't know which blkg has the updated stats. If there are many
> + * block devices in a system, the cost of iterating all the blkg's to flush
> + * out the IO stats can be high. To reduce such overhead, a set of percpu
> + * lockless lists (lhead) per blkcg are used to track the set of recently
> + * updated iostat_cpu's since the last flush. An iostat_cpu will be put
> + * onto the lockless list on the update side [blk_cgroup_bio_start()] if
> + * not there yet and then removed when being flushed [blkcg_rstat_flush()].
> + * References to blkg are gotten and then put back in the process to
> + * protect against blkg removal.
> + *
> + * lnode.next of the last entry in a lockless list is NULL. To enable us to
> + * use lnode.next as a boolean flag to indicate its presence in a lockless
> + * list, we have to make it non-NULL for all. This is done by using a
> + * sentinel node at the end of the lockless list. All the percpu lhead's
> + * are initialized to point to that sentinel node as being empty.
> + */
> +static struct llist_node llist_last;
> +
> +static bool blkcg_llist_empty(struct llist_head *lhead)
> +{
> +	return lhead->first == &llist_last;
> +}
> +
> +static void init_blkcg_llists(struct blkcg *blkcg)
> +{
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu_ptr(blkcg->lhead, cpu)->first = &llist_last;
> +}
> +
> +static struct llist_node *fetch_delete_blkcg_llist(struct llist_head *lhead)
> +{
> +	return xchg(&lhead->first, &llist_last);
> +}
> +
> +static struct llist_node *fetch_delete_lnode_next(struct llist_node *lnode)
> +{
> +	struct llist_node *next = READ_ONCE(lnode->next);
> +	struct blkcg_gq *blkg = llist_entry(lnode, struct blkg_iostat_set,
> +					    lnode)->blkg;
> +
> +	WRITE_ONCE(lnode->next, NULL);
> +	percpu_ref_put(&blkg->refcnt);
> +	return next;
> +}
> +
> +/*
> + * The retrieved blkg_iostat_set is immediately marked as not in the
> + * lockless list by clearing its node->next pointer. It could be put
> + * back into the list by a parallel update before the iostat's are
> + * finally flushed including probably the new update.
> + */
> +#define blkcg_llist_for_each_entry_safe(pos, node, nxt)			\
> +	for (; (node != &llist_last) &&					\
> +	       (pos = llist_entry(node, struct blkg_iostat_set, lnode),	\
> +		nxt = fetch_delete_lnode_next(node), true);		\
> +		node = nxt)
> +
>  /**
>   * blkcg_css - find the current css
>   *
> @@ -236,8 +301,10 @@ static struct blkcg_gq *blkg_alloc(struct blkcg *blkcg, struct request_queue *q,
>  	blkg->blkcg = blkcg;
>  
>  	u64_stats_init(&blkg->iostat.sync);
> -	for_each_possible_cpu(cpu)
> +	for_each_possible_cpu(cpu) {
>  		u64_stats_init(&per_cpu_ptr(blkg->iostat_cpu, cpu)->sync);
> +		per_cpu_ptr(blkg->iostat_cpu, cpu)->blkg = blkg;
> +	}
>  
>  	for (i = 0; i < BLKCG_MAX_POLS; i++) {
>  		struct blkcg_policy *pol = blkcg_policy[i];
> @@ -852,17 +919,23 @@ static void blkg_iostat_sub(struct blkg_iostat *dst, struct blkg_iostat *src)
>  static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
>  {
>  	struct blkcg *blkcg = css_to_blkcg(css);
> -	struct blkcg_gq *blkg;
> +	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +	struct llist_node *lnode, *lnext;
> +	struct blkg_iostat_set *bisc;
>  
>  	/* Root-level stats are sourced from system-wide IO stats */
>  	if (!cgroup_parent(css->cgroup))
>  		return;
>  
> +	if (blkcg_llist_empty(lhead))
> +		return;
> +
>  	rcu_read_lock();
>  
> -	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
> +	lnode = fetch_delete_blkcg_llist(lhead);
> +	blkcg_llist_for_each_entry_safe(bisc, lnode, lnext) {
> +		struct blkcg_gq *blkg = bisc->blkg;
>  		struct blkcg_gq *parent = blkg->parent;
> -		struct blkg_iostat_set *bisc = per_cpu_ptr(blkg->iostat_cpu, cpu);
>  		struct blkg_iostat cur, delta;
>  		unsigned long flags;
>  		unsigned int seq;
> @@ -1170,6 +1243,7 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
>  
>  	mutex_unlock(&blkcg_pol_mutex);
>  
> +	free_percpu(blkcg->lhead);
>  	kfree(blkcg);
>  }
>  
> @@ -1189,6 +1263,11 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
>  			goto unlock;
>  	}
>  
> +	blkcg->lhead = alloc_percpu_gfp(struct llist_head, GFP_KERNEL);
> +	if (!blkcg->lhead)
> +		goto free_blkcg;
> +	init_blkcg_llists(blkcg);
> +
>  	for (i = 0; i < BLKCG_MAX_POLS ; i++) {
>  		struct blkcg_policy *pol = blkcg_policy[i];
>  		struct blkcg_policy_data *cpd;
> @@ -1229,7 +1308,8 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
>  	for (i--; i >= 0; i--)
>  		if (blkcg->cpd[i])
>  			blkcg_policy[i]->cpd_free_fn(blkcg->cpd[i]);
> -
> +	free_percpu(blkcg->lhead);
> +free_blkcg:
>  	if (blkcg != &blkcg_root)
>  		kfree(blkcg);
>  unlock:
> @@ -1993,6 +2073,7 @@ static int blk_cgroup_io_type(struct bio *bio)
>  
>  void blk_cgroup_bio_start(struct bio *bio)
>  {
> +	struct blkcg *blkcg = bio->bi_blkg->blkcg;
>  	int rwd = blk_cgroup_io_type(bio), cpu;
>  	struct blkg_iostat_set *bis;
>  	unsigned long flags;
> @@ -2011,9 +2092,16 @@ void blk_cgroup_bio_start(struct bio *bio)
>  	}
>  	bis->cur.ios[rwd]++;
>  
> +	if (!READ_ONCE(bis->lnode.next)) {
> +		struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
> +
> +		llist_add(&bis->lnode, lhead);
> +		percpu_ref_get(&bis->blkg->refcnt);
> +	}

The above still adds cost in fast io path.

> +
>  	u64_stats_update_end_irqrestore(&bis->sync, flags);
>  	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
> -		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
> +		cgroup_rstat_updated(blkcg->css.cgroup, cpu);
>  	put_cpu();
>  }

IMO, it seems one cgroup generic issue. More importantly, the percpu
lock of cgroup_rstat_cpu_lock is held in both cgroup_rstat_updated()
and cgroup_rstat_flush_locked(), which can provide enough sync with
zero extra cost, meantime other cgroups can benefit from this kind of
much simpler improvement.

So what do you think of the following approach?

BTW, the cpumask can be replaced with one plain percpu variable for avoiding
cache conflict.

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 23ec30f50cca..f8287fced726 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -858,6 +858,11 @@ static void blkcg_rstat_flush(struct cgroup_subsys_state *css, int cpu)
 	if (!cgroup_parent(css->cgroup))
 		return;
 
+	if (!cpumask_test_cpu(cpu, blkcg->iostat_cpumask))
+		return;
+
+	cpumask_clear_cpu(cpu, blkcg->iostat_cpumask);
+
 	rcu_read_lock();
 
 	hlist_for_each_entry_rcu(blkg, &blkcg->blkg_list, blkcg_node) {
@@ -1170,6 +1175,7 @@ static void blkcg_css_free(struct cgroup_subsys_state *css)
 
 	mutex_unlock(&blkcg_pol_mutex);
 
+	free_cpumask_var(blkcg->iostat_cpumask);
 	kfree(blkcg);
 }
 
@@ -1213,6 +1219,9 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 			pol->cpd_init_fn(cpd);
 	}
 
+	if (!zalloc_cpumask_var(&blkcg->iostat_cpumask, GFP_KERNEL))
+		goto free_pd_blkcg;
+
 	spin_lock_init(&blkcg->lock);
 	refcount_set(&blkcg->online_pin, 1);
 	INIT_RADIX_TREE(&blkcg->blkg_tree, GFP_NOWAIT | __GFP_NOWARN);
@@ -2009,7 +2018,8 @@ void blk_cgroup_bio_start(struct bio *bio)
 
 	u64_stats_update_end_irqrestore(&bis->sync, flags);
 	if (cgroup_subsys_on_dfl(io_cgrp_subsys))
-		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu);
+		cgroup_rstat_updated(bio->bi_blkg->blkcg->css.cgroup, cpu,
+				bio->bi_blkg->blkcg->iostat_cpumask);
 	put_cpu();
 }
 
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index d4de0a35e066..458b40ca045a 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -103,6 +103,7 @@ struct blkcg {
 #ifdef CONFIG_CGROUP_WRITEBACK
 	struct list_head		cgwb_list;
 #endif
+	cpumask_var_t			iostat_cpumask;
 };
 
 static inline struct blkcg *css_to_blkcg(struct cgroup_subsys_state *css)
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 0d1ada8968d7..4fa5dde3a62c 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -763,7 +763,7 @@ static inline struct cgroup *cgroup_get_from_id(u64 id)
 /*
  * cgroup scalable recursive statistics.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu);
+void cgroup_rstat_updated(struct cgroup *cgrp, int cpu, cpumask_var_t cpumask);
 void cgroup_rstat_flush(struct cgroup *cgrp);
 void cgroup_rstat_flush_irqsafe(struct cgroup *cgrp);
 void cgroup_rstat_flush_hold(struct cgroup *cgrp);
diff --git a/kernel/cgroup/rstat.c b/kernel/cgroup/rstat.c
index 24b5c2ab5598..f4eb63b86e56 100644
--- a/kernel/cgroup/rstat.c
+++ b/kernel/cgroup/rstat.c
@@ -22,7 +22,7 @@ static struct cgroup_rstat_cpu *cgroup_rstat_cpu(struct cgroup *cgrp, int cpu)
  * rstat_cpu->updated_children list.  See the comment on top of
  * cgroup_rstat_cpu definition for details.
  */
-void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
+void cgroup_rstat_updated(struct cgroup *cgrp, int cpu, cpumask_var_t cpumask)
 {
 	raw_spinlock_t *cpu_lock = per_cpu_ptr(&cgroup_rstat_cpu_lock, cpu);
 	unsigned long flags;
@@ -40,6 +40,9 @@ void cgroup_rstat_updated(struct cgroup *cgrp, int cpu)
 
 	raw_spin_lock_irqsave(cpu_lock, flags);
 
+	if (cpumask)
+		cpumask_set_cpu(cpu, cpumask);
+
 	/* put @cgrp and all ancestors on the corresponding updated lists */
 	while (true) {
 		struct cgroup_rstat_cpu *rstatc = cgroup_rstat_cpu(cgrp, cpu);
@@ -366,7 +369,7 @@ static void cgroup_base_stat_cputime_account_end(struct cgroup *cgrp,
 						 unsigned long flags)
 {
 	u64_stats_update_end_irqrestore(&rstatc->bsync, flags);
-	cgroup_rstat_updated(cgrp, smp_processor_id());
+	cgroup_rstat_updated(cgrp, smp_processor_id(), NULL);
 	put_cpu_ptr(rstatc);
 }
 
diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index abec50f31fe6..8c4f204dbf5b 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -622,7 +622,7 @@ static inline void memcg_rstat_updated(struct mem_cgroup *memcg, int val)
 {
 	unsigned int x;
 
-	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id());
+	cgroup_rstat_updated(memcg->css.cgroup, smp_processor_id(), NULL);
 
 	x = __this_cpu_add_return(stats_updates, abs(val));
 	if (x > MEMCG_CHARGE_BATCH) {

Thanks, 
Ming

