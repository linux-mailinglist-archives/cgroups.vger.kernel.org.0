Return-Path: <cgroups+bounces-3342-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBF915F8C
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D185B1C211B9
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4BC149C6C;
	Tue, 25 Jun 2024 07:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YFWf+yIq"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5A8149C54
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299207; cv=none; b=tWMkWIFyJ2EmbHmi3+L/Po8P4aSyTUUx3hYwblnzOHZRBFcfCxvnoAF8VxGggy74uD8zwCBGdV30z5QFAddiushv+7jSvXh4Jv7F6k3gqynesElm0N7s3xRQ8kklKsasF51itHV7eCi/f/dPSGxB2SdmK3CoI3ozPar3pqkEsQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299207; c=relaxed/simple;
	bh=apRxJ/tK7s+B7TXa/ZyQTn0IJg2Q3rI9CGHnuw5TD2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAuVVMDESBiRru5qf2Uf0vlNrD8rPFUz4RzEHNFW5y4eKNUnwkHgIT/yxvLLgF8TMbrAZmm3HCpOllSwPR/jIXp4xAX9EFT7zrV+QhJYnrJqFSvUF2rRvqefCN/T7ViXh9J/gfGDRtgns4O9nMXtlu+tlKGd4Mlcy6n4LulOC7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YFWf+yIq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee83so5402838a12.2
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299203; x=1719904003; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vkVlokoi4lO7NEIFqoydt7u6CUpuefnK9FFj+5Uy49k=;
        b=YFWf+yIqX4ZuAmKy3vG8NfNxZtDKcCQsfwzOCYLlp0+kWzc7KMUUmImQj575DdRQlE
         taD9aQxKzuwV/AKi5Cf+5ZMhfS3QQW6h48rqOz+RHzKqoKmUraYEjS7IpVKynz4BLzqZ
         YD4yvEd3lXNX16BM5jgwzZhIEHRfYRfy60aVZZejQkRoKkfP2NgAD21v9o88C9pAKg9C
         GC4Z3SP9kb3jQvZKCMgefvTPp3FhZ+2swfEY2wSTLvg0fjUWm3X/KuQv8klcgGkCDDlj
         tAae3gKzidlX253dKEo66hiGafPa3wKTSV9mbC7zzXeB3OpEJ8UiAWrUAk/JnktjqqN1
         Jd5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299203; x=1719904003;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vkVlokoi4lO7NEIFqoydt7u6CUpuefnK9FFj+5Uy49k=;
        b=BUQCTkjKmIBjYCqfdwxcKQHPKgTbVXSwPMsl7d5/Ia0buZogLPc1hv21Pj+5PdCkQs
         d8AixYPZl/SPNcbsloVEdye7Ap0MiySC3oIoeaszTibQP0BFLAV0yQjDAvMYPO+rgEIX
         3TYKR5uX4MeoYiqtcs9E/rwrHKzlJARi7l4iYPWG7x2ra7kE/+WeLP7fssbeh3A7UwTG
         svHukJyzENpoWtwW8jdewRtk2GmVyYc9fBK5yKHRk+PSNP9CYLHao13Ilv/TxRzdT47t
         be+VrM8GHdToMi883dHTLSxZ/Qtu3DIY4yVfKlBcIev/ddskladfcctzwj5RMDTy73dw
         gh8w==
X-Forwarded-Encrypted: i=1; AJvYcCU1oK4X9dr4qrkWa6O+K4eUaN8/tOYjffCb+7LQRIPtBBPos35cMrIjKqiBSkkh7lH8S3Qt1NdZABpubeOfrOtKQpRkXY0X3Q==
X-Gm-Message-State: AOJu0Yzp10Y+P3894aquPkQLiXIJ/xBr7yc6AONvXxqonJFfb3Bu02IA
	Mkjn22pal6NE+iKa/pp+NXaIOJgWEav0tpTAFxXqLQhQbAEID3RIjF0cExj0ydA=
X-Google-Smtp-Source: AGHT+IGxBcnE3vK+/984R2n9TZBKuIe3Bf/z9KXPqWWJlnj85zh5TIHd9QpzbI2iG8xczvw/tz5gdA==
X-Received: by 2002:a50:9f8d:0:b0:57d:1627:93ed with SMTP id 4fb4d7f45d1cf-57d457a1540mr5341690a12.22.1719299202542;
        Tue, 25 Jun 2024 00:06:42 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3042d8b1sm5593016a12.45.2024.06.25.00.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:06:42 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:06:41 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 02/14] mm: memcg: move soft limit reclaim code to
 memcontrol-v1.c
Message-ID: <ZnpsgSCeSLOaYwA4@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-3-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-3-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:54, Roman Gushchin wrote:
> Soft limits are cgroup v1-specific and are not supported by cgroup v2,
> so let's move the corresponding code into memcontrol-v1.c.
> 
> Aside from simple moving the code, this commits introduces a trivial
> memcg1_soft_limit_reset() function to reset soft limits and also
> moves the global soft limit tree initialization code into a new
> memcg1_init() function.
> 
> It also moves corresponding declarations shared between memcontrol.c
> and memcontrol-v1.c into mm/memcontrol-v1.h.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

I haven't done line for line check here and in other patches that move a
lot of code. I like you have separated the renaming into its own patch
because this makes review just easier.

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 342 +++++++++++++++++++++++++++++++++++++++++++++
>  mm/memcontrol-v1.h |   7 +
>  mm/memcontrol.c    | 337 +-------------------------------------------
>  3 files changed, 353 insertions(+), 333 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index a941446ba575..2ccb8406fa84 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -1,3 +1,345 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  
> +#include <linux/memcontrol.h>
> +#include <linux/swap.h>
> +#include <linux/mm_inline.h>
> +
>  #include "memcontrol-v1.h"
> +
> +/*
> + * Cgroups above their limits are maintained in a RB-Tree, independent of
> + * their hierarchy representation
> + */
> +
> +struct mem_cgroup_tree_per_node {
> +	struct rb_root rb_root;
> +	struct rb_node *rb_rightmost;
> +	spinlock_t lock;
> +};
> +
> +struct mem_cgroup_tree {
> +	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
> +};
> +
> +static struct mem_cgroup_tree soft_limit_tree __read_mostly;
> +
> +/*
> + * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
> + * limit reclaim to prevent infinite loops, if they ever occur.
> + */
> +#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
> +#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
> +
> +static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
> +					 struct mem_cgroup_tree_per_node *mctz,
> +					 unsigned long new_usage_in_excess)
> +{
> +	struct rb_node **p = &mctz->rb_root.rb_node;
> +	struct rb_node *parent = NULL;
> +	struct mem_cgroup_per_node *mz_node;
> +	bool rightmost = true;
> +
> +	if (mz->on_tree)
> +		return;
> +
> +	mz->usage_in_excess = new_usage_in_excess;
> +	if (!mz->usage_in_excess)
> +		return;
> +	while (*p) {
> +		parent = *p;
> +		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
> +					tree_node);
> +		if (mz->usage_in_excess < mz_node->usage_in_excess) {
> +			p = &(*p)->rb_left;
> +			rightmost = false;
> +		} else {
> +			p = &(*p)->rb_right;
> +		}
> +	}
> +
> +	if (rightmost)
> +		mctz->rb_rightmost = &mz->tree_node;
> +
> +	rb_link_node(&mz->tree_node, parent, p);
> +	rb_insert_color(&mz->tree_node, &mctz->rb_root);
> +	mz->on_tree = true;
> +}
> +
> +static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
> +					 struct mem_cgroup_tree_per_node *mctz)
> +{
> +	if (!mz->on_tree)
> +		return;
> +
> +	if (&mz->tree_node == mctz->rb_rightmost)
> +		mctz->rb_rightmost = rb_prev(&mz->tree_node);
> +
> +	rb_erase(&mz->tree_node, &mctz->rb_root);
> +	mz->on_tree = false;
> +}
> +
> +static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
> +				       struct mem_cgroup_tree_per_node *mctz)
> +{
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&mctz->lock, flags);
> +	__mem_cgroup_remove_exceeded(mz, mctz);
> +	spin_unlock_irqrestore(&mctz->lock, flags);
> +}
> +
> +static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
> +{
> +	unsigned long nr_pages = page_counter_read(&memcg->memory);
> +	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
> +	unsigned long excess = 0;
> +
> +	if (nr_pages > soft_limit)
> +		excess = nr_pages - soft_limit;
> +
> +	return excess;
> +}
> +
> +void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
> +{
> +	unsigned long excess;
> +	struct mem_cgroup_per_node *mz;
> +	struct mem_cgroup_tree_per_node *mctz;
> +
> +	if (lru_gen_enabled()) {
> +		if (soft_limit_excess(memcg))
> +			lru_gen_soft_reclaim(memcg, nid);
> +		return;
> +	}
> +
> +	mctz = soft_limit_tree.rb_tree_per_node[nid];
> +	if (!mctz)
> +		return;
> +	/*
> +	 * Necessary to update all ancestors when hierarchy is used.
> +	 * because their event counter is not touched.
> +	 */
> +	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> +		mz = memcg->nodeinfo[nid];
> +		excess = soft_limit_excess(memcg);
> +		/*
> +		 * We have to update the tree if mz is on RB-tree or
> +		 * mem is over its softlimit.
> +		 */
> +		if (excess || mz->on_tree) {
> +			unsigned long flags;
> +
> +			spin_lock_irqsave(&mctz->lock, flags);
> +			/* if on-tree, remove it */
> +			if (mz->on_tree)
> +				__mem_cgroup_remove_exceeded(mz, mctz);
> +			/*
> +			 * Insert again. mz->usage_in_excess will be updated.
> +			 * If excess is 0, no tree ops.
> +			 */
> +			__mem_cgroup_insert_exceeded(mz, mctz, excess);
> +			spin_unlock_irqrestore(&mctz->lock, flags);
> +		}
> +	}
> +}
> +
> +void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup_tree_per_node *mctz;
> +	struct mem_cgroup_per_node *mz;
> +	int nid;
> +
> +	for_each_node(nid) {
> +		mz = memcg->nodeinfo[nid];
> +		mctz = soft_limit_tree.rb_tree_per_node[nid];
> +		if (mctz)
> +			mem_cgroup_remove_exceeded(mz, mctz);
> +	}
> +}
> +
> +static struct mem_cgroup_per_node *
> +__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> +{
> +	struct mem_cgroup_per_node *mz;
> +
> +retry:
> +	mz = NULL;
> +	if (!mctz->rb_rightmost)
> +		goto done;		/* Nothing to reclaim from */
> +
> +	mz = rb_entry(mctz->rb_rightmost,
> +		      struct mem_cgroup_per_node, tree_node);
> +	/*
> +	 * Remove the node now but someone else can add it back,
> +	 * we will to add it back at the end of reclaim to its correct
> +	 * position in the tree.
> +	 */
> +	__mem_cgroup_remove_exceeded(mz, mctz);
> +	if (!soft_limit_excess(mz->memcg) ||
> +	    !css_tryget(&mz->memcg->css))
> +		goto retry;
> +done:
> +	return mz;
> +}
> +
> +static struct mem_cgroup_per_node *
> +mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> +{
> +	struct mem_cgroup_per_node *mz;
> +
> +	spin_lock_irq(&mctz->lock);
> +	mz = __mem_cgroup_largest_soft_limit_node(mctz);
> +	spin_unlock_irq(&mctz->lock);
> +	return mz;
> +}
> +
> +static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
> +				   pg_data_t *pgdat,
> +				   gfp_t gfp_mask,
> +				   unsigned long *total_scanned)
> +{
> +	struct mem_cgroup *victim = NULL;
> +	int total = 0;
> +	int loop = 0;
> +	unsigned long excess;
> +	unsigned long nr_scanned;
> +	struct mem_cgroup_reclaim_cookie reclaim = {
> +		.pgdat = pgdat,
> +	};
> +
> +	excess = soft_limit_excess(root_memcg);
> +
> +	while (1) {
> +		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
> +		if (!victim) {
> +			loop++;
> +			if (loop >= 2) {
> +				/*
> +				 * If we have not been able to reclaim
> +				 * anything, it might because there are
> +				 * no reclaimable pages under this hierarchy
> +				 */
> +				if (!total)
> +					break;
> +				/*
> +				 * We want to do more targeted reclaim.
> +				 * excess >> 2 is not to excessive so as to
> +				 * reclaim too much, nor too less that we keep
> +				 * coming back to reclaim from this cgroup
> +				 */
> +				if (total >= (excess >> 2) ||
> +					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
> +					break;
> +			}
> +			continue;
> +		}
> +		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
> +					pgdat, &nr_scanned);
> +		*total_scanned += nr_scanned;
> +		if (!soft_limit_excess(root_memcg))
> +			break;
> +	}
> +	mem_cgroup_iter_break(root_memcg, victim);
> +	return total;
> +}
> +
> +unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> +					    gfp_t gfp_mask,
> +					    unsigned long *total_scanned)
> +{
> +	unsigned long nr_reclaimed = 0;
> +	struct mem_cgroup_per_node *mz, *next_mz = NULL;
> +	unsigned long reclaimed;
> +	int loop = 0;
> +	struct mem_cgroup_tree_per_node *mctz;
> +	unsigned long excess;
> +
> +	if (lru_gen_enabled())
> +		return 0;
> +
> +	if (order > 0)
> +		return 0;
> +
> +	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
> +
> +	/*
> +	 * Do not even bother to check the largest node if the root
> +	 * is empty. Do it lockless to prevent lock bouncing. Races
> +	 * are acceptable as soft limit is best effort anyway.
> +	 */
> +	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
> +		return 0;
> +
> +	/*
> +	 * This loop can run a while, specially if mem_cgroup's continuously
> +	 * keep exceeding their soft limit and putting the system under
> +	 * pressure
> +	 */
> +	do {
> +		if (next_mz)
> +			mz = next_mz;
> +		else
> +			mz = mem_cgroup_largest_soft_limit_node(mctz);
> +		if (!mz)
> +			break;
> +
> +		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
> +						    gfp_mask, total_scanned);
> +		nr_reclaimed += reclaimed;
> +		spin_lock_irq(&mctz->lock);
> +
> +		/*
> +		 * If we failed to reclaim anything from this memory cgroup
> +		 * it is time to move on to the next cgroup
> +		 */
> +		next_mz = NULL;
> +		if (!reclaimed)
> +			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
> +
> +		excess = soft_limit_excess(mz->memcg);
> +		/*
> +		 * One school of thought says that we should not add
> +		 * back the node to the tree if reclaim returns 0.
> +		 * But our reclaim could return 0, simply because due
> +		 * to priority we are exposing a smaller subset of
> +		 * memory to reclaim from. Consider this as a longer
> +		 * term TODO.
> +		 */
> +		/* If excess == 0, no tree ops */
> +		__mem_cgroup_insert_exceeded(mz, mctz, excess);
> +		spin_unlock_irq(&mctz->lock);
> +		css_put(&mz->memcg->css);
> +		loop++;
> +		/*
> +		 * Could not reclaim anything and there are no more
> +		 * mem cgroups to try or we seem to be looping without
> +		 * reclaiming anything.
> +		 */
> +		if (!nr_reclaimed &&
> +			(next_mz == NULL ||
> +			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
> +			break;
> +	} while (!nr_reclaimed);
> +	if (next_mz)
> +		css_put(&next_mz->memcg->css);
> +	return nr_reclaimed;
> +}
> +
> +static int __init memcg1_init(void)
> +{
> +	int node;
> +
> +	for_each_node(node) {
> +		struct mem_cgroup_tree_per_node *rtpn;
> +
> +		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> +
> +		rtpn->rb_root = RB_ROOT;
> +		rtpn->rb_rightmost = NULL;
> +		spin_lock_init(&rtpn->lock);
> +		soft_limit_tree.rb_tree_per_node[node] = rtpn;
> +	}
> +
> +	return 0;
> +}
> +subsys_initcall(memcg1_init);
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index 7c5f094755ff..4da6fa561c6d 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -3,5 +3,12 @@
>  #ifndef __MM_MEMCONTROL_V1_H
>  #define __MM_MEMCONTROL_V1_H
>  
> +void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid);
> +void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg);
> +
> +static inline void memcg1_soft_limit_reset(struct mem_cgroup *memcg)
> +{
> +	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> +}
>  
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 974bd160838c..003e944f34ea 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -72,6 +72,7 @@
>  #include <net/ip.h>
>  #include "slab.h"
>  #include "swap.h"
> +#include "memcontrol-v1.h"
>  
>  #include <linux/uaccess.h>
>  
> @@ -108,23 +109,6 @@ static bool do_memsw_account(void)
>  #define THRESHOLDS_EVENTS_TARGET 128
>  #define SOFTLIMIT_EVENTS_TARGET 1024
>  
> -/*
> - * Cgroups above their limits are maintained in a RB-Tree, independent of
> - * their hierarchy representation
> - */
> -
> -struct mem_cgroup_tree_per_node {
> -	struct rb_root rb_root;
> -	struct rb_node *rb_rightmost;
> -	spinlock_t lock;
> -};
> -
> -struct mem_cgroup_tree {
> -	struct mem_cgroup_tree_per_node *rb_tree_per_node[MAX_NUMNODES];
> -};
> -
> -static struct mem_cgroup_tree soft_limit_tree __read_mostly;
> -
>  /* for OOM */
>  struct mem_cgroup_eventfd_list {
>  	struct list_head list;
> @@ -199,13 +183,6 @@ static struct move_charge_struct {
>  	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
>  };
>  
> -/*
> - * Maximum loops in mem_cgroup_soft_reclaim(), used for soft
> - * limit reclaim to prevent infinite loops, if they ever occur.
> - */
> -#define	MEM_CGROUP_MAX_RECLAIM_LOOPS		100
> -#define	MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS	2
> -
>  /* for encoding cft->private value on file */
>  enum res_type {
>  	_MEM,
> @@ -413,169 +390,6 @@ ino_t page_cgroup_ino(struct page *page)
>  	return ino;
>  }
>  
> -static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
> -					 struct mem_cgroup_tree_per_node *mctz,
> -					 unsigned long new_usage_in_excess)
> -{
> -	struct rb_node **p = &mctz->rb_root.rb_node;
> -	struct rb_node *parent = NULL;
> -	struct mem_cgroup_per_node *mz_node;
> -	bool rightmost = true;
> -
> -	if (mz->on_tree)
> -		return;
> -
> -	mz->usage_in_excess = new_usage_in_excess;
> -	if (!mz->usage_in_excess)
> -		return;
> -	while (*p) {
> -		parent = *p;
> -		mz_node = rb_entry(parent, struct mem_cgroup_per_node,
> -					tree_node);
> -		if (mz->usage_in_excess < mz_node->usage_in_excess) {
> -			p = &(*p)->rb_left;
> -			rightmost = false;
> -		} else {
> -			p = &(*p)->rb_right;
> -		}
> -	}
> -
> -	if (rightmost)
> -		mctz->rb_rightmost = &mz->tree_node;
> -
> -	rb_link_node(&mz->tree_node, parent, p);
> -	rb_insert_color(&mz->tree_node, &mctz->rb_root);
> -	mz->on_tree = true;
> -}
> -
> -static void __mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
> -					 struct mem_cgroup_tree_per_node *mctz)
> -{
> -	if (!mz->on_tree)
> -		return;
> -
> -	if (&mz->tree_node == mctz->rb_rightmost)
> -		mctz->rb_rightmost = rb_prev(&mz->tree_node);
> -
> -	rb_erase(&mz->tree_node, &mctz->rb_root);
> -	mz->on_tree = false;
> -}
> -
> -static void mem_cgroup_remove_exceeded(struct mem_cgroup_per_node *mz,
> -				       struct mem_cgroup_tree_per_node *mctz)
> -{
> -	unsigned long flags;
> -
> -	spin_lock_irqsave(&mctz->lock, flags);
> -	__mem_cgroup_remove_exceeded(mz, mctz);
> -	spin_unlock_irqrestore(&mctz->lock, flags);
> -}
> -
> -static unsigned long soft_limit_excess(struct mem_cgroup *memcg)
> -{
> -	unsigned long nr_pages = page_counter_read(&memcg->memory);
> -	unsigned long soft_limit = READ_ONCE(memcg->soft_limit);
> -	unsigned long excess = 0;
> -
> -	if (nr_pages > soft_limit)
> -		excess = nr_pages - soft_limit;
> -
> -	return excess;
> -}
> -
> -static void mem_cgroup_update_tree(struct mem_cgroup *memcg, int nid)
> -{
> -	unsigned long excess;
> -	struct mem_cgroup_per_node *mz;
> -	struct mem_cgroup_tree_per_node *mctz;
> -
> -	if (lru_gen_enabled()) {
> -		if (soft_limit_excess(memcg))
> -			lru_gen_soft_reclaim(memcg, nid);
> -		return;
> -	}
> -
> -	mctz = soft_limit_tree.rb_tree_per_node[nid];
> -	if (!mctz)
> -		return;
> -	/*
> -	 * Necessary to update all ancestors when hierarchy is used.
> -	 * because their event counter is not touched.
> -	 */
> -	for (; memcg; memcg = parent_mem_cgroup(memcg)) {
> -		mz = memcg->nodeinfo[nid];
> -		excess = soft_limit_excess(memcg);
> -		/*
> -		 * We have to update the tree if mz is on RB-tree or
> -		 * mem is over its softlimit.
> -		 */
> -		if (excess || mz->on_tree) {
> -			unsigned long flags;
> -
> -			spin_lock_irqsave(&mctz->lock, flags);
> -			/* if on-tree, remove it */
> -			if (mz->on_tree)
> -				__mem_cgroup_remove_exceeded(mz, mctz);
> -			/*
> -			 * Insert again. mz->usage_in_excess will be updated.
> -			 * If excess is 0, no tree ops.
> -			 */
> -			__mem_cgroup_insert_exceeded(mz, mctz, excess);
> -			spin_unlock_irqrestore(&mctz->lock, flags);
> -		}
> -	}
> -}
> -
> -static void mem_cgroup_remove_from_trees(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup_tree_per_node *mctz;
> -	struct mem_cgroup_per_node *mz;
> -	int nid;
> -
> -	for_each_node(nid) {
> -		mz = memcg->nodeinfo[nid];
> -		mctz = soft_limit_tree.rb_tree_per_node[nid];
> -		if (mctz)
> -			mem_cgroup_remove_exceeded(mz, mctz);
> -	}
> -}
> -
> -static struct mem_cgroup_per_node *
> -__mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> -{
> -	struct mem_cgroup_per_node *mz;
> -
> -retry:
> -	mz = NULL;
> -	if (!mctz->rb_rightmost)
> -		goto done;		/* Nothing to reclaim from */
> -
> -	mz = rb_entry(mctz->rb_rightmost,
> -		      struct mem_cgroup_per_node, tree_node);
> -	/*
> -	 * Remove the node now but someone else can add it back,
> -	 * we will to add it back at the end of reclaim to its correct
> -	 * position in the tree.
> -	 */
> -	__mem_cgroup_remove_exceeded(mz, mctz);
> -	if (!soft_limit_excess(mz->memcg) ||
> -	    !css_tryget(&mz->memcg->css))
> -		goto retry;
> -done:
> -	return mz;
> -}
> -
> -static struct mem_cgroup_per_node *
> -mem_cgroup_largest_soft_limit_node(struct mem_cgroup_tree_per_node *mctz)
> -{
> -	struct mem_cgroup_per_node *mz;
> -
> -	spin_lock_irq(&mctz->lock);
> -	mz = __mem_cgroup_largest_soft_limit_node(mctz);
> -	spin_unlock_irq(&mctz->lock);
> -	return mz;
> -}
> -
>  /* Subset of node_stat_item for memcg stats */
>  static const unsigned int memcg_node_stat_items[] = {
>  	NR_INACTIVE_ANON,
> @@ -1980,56 +1794,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return ret;
>  }
>  
> -static int mem_cgroup_soft_reclaim(struct mem_cgroup *root_memcg,
> -				   pg_data_t *pgdat,
> -				   gfp_t gfp_mask,
> -				   unsigned long *total_scanned)
> -{
> -	struct mem_cgroup *victim = NULL;
> -	int total = 0;
> -	int loop = 0;
> -	unsigned long excess;
> -	unsigned long nr_scanned;
> -	struct mem_cgroup_reclaim_cookie reclaim = {
> -		.pgdat = pgdat,
> -	};
> -
> -	excess = soft_limit_excess(root_memcg);
> -
> -	while (1) {
> -		victim = mem_cgroup_iter(root_memcg, victim, &reclaim);
> -		if (!victim) {
> -			loop++;
> -			if (loop >= 2) {
> -				/*
> -				 * If we have not been able to reclaim
> -				 * anything, it might because there are
> -				 * no reclaimable pages under this hierarchy
> -				 */
> -				if (!total)
> -					break;
> -				/*
> -				 * We want to do more targeted reclaim.
> -				 * excess >> 2 is not to excessive so as to
> -				 * reclaim too much, nor too less that we keep
> -				 * coming back to reclaim from this cgroup
> -				 */
> -				if (total >= (excess >> 2) ||
> -					(loop > MEM_CGROUP_MAX_RECLAIM_LOOPS))
> -					break;
> -			}
> -			continue;
> -		}
> -		total += mem_cgroup_shrink_node(victim, gfp_mask, false,
> -					pgdat, &nr_scanned);
> -		*total_scanned += nr_scanned;
> -		if (!soft_limit_excess(root_memcg))
> -			break;
> -	}
> -	mem_cgroup_iter_break(root_memcg, victim);
> -	return total;
> -}
> -
>  #ifdef CONFIG_LOCKDEP
>  static struct lockdep_map memcg_oom_lock_dep_map = {
>  	.name = "memcg_oom_lock",
> @@ -3925,88 +3689,6 @@ static int mem_cgroup_resize_max(struct mem_cgroup *memcg,
>  	return ret;
>  }
>  
> -unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
> -					    gfp_t gfp_mask,
> -					    unsigned long *total_scanned)
> -{
> -	unsigned long nr_reclaimed = 0;
> -	struct mem_cgroup_per_node *mz, *next_mz = NULL;
> -	unsigned long reclaimed;
> -	int loop = 0;
> -	struct mem_cgroup_tree_per_node *mctz;
> -	unsigned long excess;
> -
> -	if (lru_gen_enabled())
> -		return 0;
> -
> -	if (order > 0)
> -		return 0;
> -
> -	mctz = soft_limit_tree.rb_tree_per_node[pgdat->node_id];
> -
> -	/*
> -	 * Do not even bother to check the largest node if the root
> -	 * is empty. Do it lockless to prevent lock bouncing. Races
> -	 * are acceptable as soft limit is best effort anyway.
> -	 */
> -	if (!mctz || RB_EMPTY_ROOT(&mctz->rb_root))
> -		return 0;
> -
> -	/*
> -	 * This loop can run a while, specially if mem_cgroup's continuously
> -	 * keep exceeding their soft limit and putting the system under
> -	 * pressure
> -	 */
> -	do {
> -		if (next_mz)
> -			mz = next_mz;
> -		else
> -			mz = mem_cgroup_largest_soft_limit_node(mctz);
> -		if (!mz)
> -			break;
> -
> -		reclaimed = mem_cgroup_soft_reclaim(mz->memcg, pgdat,
> -						    gfp_mask, total_scanned);
> -		nr_reclaimed += reclaimed;
> -		spin_lock_irq(&mctz->lock);
> -
> -		/*
> -		 * If we failed to reclaim anything from this memory cgroup
> -		 * it is time to move on to the next cgroup
> -		 */
> -		next_mz = NULL;
> -		if (!reclaimed)
> -			next_mz = __mem_cgroup_largest_soft_limit_node(mctz);
> -
> -		excess = soft_limit_excess(mz->memcg);
> -		/*
> -		 * One school of thought says that we should not add
> -		 * back the node to the tree if reclaim returns 0.
> -		 * But our reclaim could return 0, simply because due
> -		 * to priority we are exposing a smaller subset of
> -		 * memory to reclaim from. Consider this as a longer
> -		 * term TODO.
> -		 */
> -		/* If excess == 0, no tree ops */
> -		__mem_cgroup_insert_exceeded(mz, mctz, excess);
> -		spin_unlock_irq(&mctz->lock);
> -		css_put(&mz->memcg->css);
> -		loop++;
> -		/*
> -		 * Could not reclaim anything and there are no more
> -		 * mem cgroups to try or we seem to be looping without
> -		 * reclaiming anything.
> -		 */
> -		if (!nr_reclaimed &&
> -			(next_mz == NULL ||
> -			loop > MEM_CGROUP_MAX_SOFT_LIMIT_RECLAIM_LOOPS))
> -			break;
> -	} while (!nr_reclaimed);
> -	if (next_mz)
> -		css_put(&next_mz->memcg->css);
> -	return nr_reclaimed;
> -}
> -
>  /*
>   * Reclaims as many pages from the given memcg as possible.
>   *
> @@ -5784,7 +5466,7 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  		return ERR_CAST(memcg);
>  
>  	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> -	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> +	memcg1_soft_limit_reset(memcg);
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
>  	memcg->zswap_max = PAGE_COUNTER_MAX;
>  	WRITE_ONCE(memcg->zswap_writeback,
> @@ -5957,7 +5639,7 @@ static void mem_cgroup_css_reset(struct cgroup_subsys_state *css)
>  	page_counter_set_min(&memcg->memory, 0);
>  	page_counter_set_low(&memcg->memory, 0);
>  	page_counter_set_high(&memcg->memory, PAGE_COUNTER_MAX);
> -	WRITE_ONCE(memcg->soft_limit, PAGE_COUNTER_MAX);
> +	memcg1_soft_limit_reset(memcg);
>  	page_counter_set_high(&memcg->swap, PAGE_COUNTER_MAX);
>  	memcg_wb_domain_size_changed(memcg);
>  }
> @@ -7984,7 +7666,7 @@ __setup("cgroup.memory=", cgroup_memory);
>   */
>  static int __init mem_cgroup_init(void)
>  {
> -	int cpu, node;
> +	int cpu;
>  
>  	/*
>  	 * Currently s32 type (can refer to struct batched_lruvec_stat) is
> @@ -8001,17 +7683,6 @@ static int __init mem_cgroup_init(void)
>  		INIT_WORK(&per_cpu_ptr(&memcg_stock, cpu)->work,
>  			  drain_local_stock);
>  
> -	for_each_node(node) {
> -		struct mem_cgroup_tree_per_node *rtpn;
> -
> -		rtpn = kzalloc_node(sizeof(*rtpn), GFP_KERNEL, node);
> -
> -		rtpn->rb_root = RB_ROOT;
> -		rtpn->rb_rightmost = NULL;
> -		spin_lock_init(&rtpn->lock);
> -		soft_limit_tree.rb_tree_per_node[node] = rtpn;
> -	}
> -
>  	return 0;
>  }
>  subsys_initcall(mem_cgroup_init);
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

