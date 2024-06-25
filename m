Return-Path: <cgroups+bounces-3346-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FC915F9D
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D77851F220C8
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6520148857;
	Tue, 25 Jun 2024 07:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Uh7lNJIL"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D242314882A
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299282; cv=none; b=PXIYBLtpPczrArs8gecMYBUzE3+XBOwUvcJMbbVYNSeiVa9S5mY5hVylYFrnww4p8WgmZ6Cn+K1BRiua6/j8ttwC3Ff/fU4uVHSUnpNCPrhnf/ifSzYmdI5vBibRptTo2hfVVt5ug21visSxF1xlDsHdW0K7SyCluoqdJtE4++c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299282; c=relaxed/simple;
	bh=6GBTsJydG0rAth76DUKya/dwAoKb7DU9GFo1q8Eq2mI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzQtgSceCRe7ZggOk9ylp4uZfXDXKCWRO/xFX27avE76BXaHJMOrQOIsU4eUIawjNVCL07SeyhDGRZ76mMI4LXhYbq56tjZREqc7x/8pYfN631eKUdFXPVxhmEGaaOyfzS5whqje7UZ37B385BwEKxuHqrQwP5CIjGSMT7WeYh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Uh7lNJIL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a724a8097deso243395366b.1
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299277; x=1719904077; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I3uGoBIbSBHWzeNAv8yNDtbADD3cIazYExLHkYP8LVo=;
        b=Uh7lNJIL0Cq87LdawQsyvQoaTXk20XcH7W1g7uU04/wzzhGiqzDVCY/Exeu6UuUjLm
         3PRZuuUUOumC6LR3KiyHP3uKiC+6r+mx49yEQTNBQwqMZURNFgoyzznuW/SsOzzgKgTf
         1joutRda79rYibmlXFjRPYhVw+5l2iiS1gRZea25RiUZ4MOm2jeOomygyRKoxk6thhY2
         Wi5Rya+tCUi2c4FoI6xp2ngyTofwJZWOwEU71L8Rb/wcEX/dENzGMImB1gFNOYWi1/GD
         ZkWAztM0BKppPrWQIyYx6etyXlF64IOBTmHg1JTaD2t3d4msRQmZjzcr/NBBSWLU+h66
         9bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299277; x=1719904077;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3uGoBIbSBHWzeNAv8yNDtbADD3cIazYExLHkYP8LVo=;
        b=hOTAcuttVCV1G61p74Ss+iXBOEehCAwSwDFIWpNuxeSPnLe/J0qELgn1bz3YXgnHI3
         3mCS1qYFwqqLrpQL5x8jkW5OMhxu56XQy5dg9kMoT1MJoMn0HLMtSURfr1vC0ysF0CG8
         67JjlIoC8NGGg0DGsXQQ1EzvkJtW0t/DL9d7IbrzCEdxcFSZ0o3FaeC2dLegrDPdM4Lp
         7ltdWEUdhj0ql7FmvCcTBy7/Fh/1UJacQiu5ndD9Rwdhj4GsBUo3QQCn/Wt/QdRx+3bp
         kwacQFhuzo/JZqGgwZ5XsJaZ33WZbtfS/W99fuBMnPib4OlmhQaAhhyvmN/rqSb+P3Gm
         iJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd+2MbrNMIup/PKq4ahgmDfGIuRoGnA6D/TpsbcTRhVMLyC8puiZtEUd2ITuDZI/wc3XuAPMqsH0lKa1kLKWlzrIsWeO6PHg==
X-Gm-Message-State: AOJu0YzBYmafhxEEp9/FbnYiz2UwQVp7XQZgIGMvDg29bwWSIUe/aSmC
	o9gGpvQF1P7ELsoc85mR7S8SiRouay5FRLzAd7bVuYACVjr1LIG+WB3JEZurl3k=
X-Google-Smtp-Source: AGHT+IEEmbmRfDsPImvVGIn3XbWXM2h0f8R0Umfs+B3a+/anngaWPNMewzvWdhAldfJkvw6VRRmi8w==
X-Received: by 2002:a17:907:6a0e:b0:a6f:b08b:86cb with SMTP id a640c23a62f3a-a7242da6a62mr510592266b.56.1719299276761;
        Tue, 25 Jun 2024 00:07:56 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a727738a865sm23596166b.102.2024.06.25.00.07.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:07:56 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:07:55 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 06/14] mm: memcg: move legacy memcg event code into
 memcontrol-v1.c
Message-ID: <Znpsy2rISbnT4Ffi@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-7-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-7-roman.gushchin@linux.dev>

On Mon 24-06-24 17:58:58, Roman Gushchin wrote:
> Cgroup v1's memory controller contains a pretty complicated
> event notifications mechanism which is not used on cgroup v2.
> Let's move the corresponding code into memcontrol-v1.c.
> 
> Please, note, that mem_cgroup_event_ratelimit() remains in
> memcontrol.c, otherwise it would require exporting too many
> details on memcg stats outside of memcontrol.c.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  include/linux/memcontrol.h |  12 -
>  mm/memcontrol-v1.c         | 653 +++++++++++++++++++++++++++++++++++
>  mm/memcontrol-v1.h         |  51 +++
>  mm/memcontrol.c            | 687 +------------------------------------
>  4 files changed, 709 insertions(+), 694 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 83c8327455d8..588179d29849 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -69,18 +69,6 @@ struct mem_cgroup_id {
>  	refcount_t ref;
>  };
>  
> -/*
> - * Per memcg event counter is incremented at every pagein/pageout. With THP,
> - * it will be incremented by the number of pages. This counter is used
> - * to trigger some periodic events. This is straightforward and better
> - * than using jiffies etc. to handle periodic memcg event.
> - */
> -enum mem_cgroup_events_target {
> -	MEM_CGROUP_TARGET_THRESH,
> -	MEM_CGROUP_TARGET_SOFTLIMIT,
> -	MEM_CGROUP_NTARGETS,
> -};
> -
>  struct memcg_vmstats_percpu;
>  struct memcg_vmstats;
>  struct lruvec_stats_percpu;
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index c25e038ac874..4b2290ceace6 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -6,6 +6,10 @@
>  #include <linux/pagewalk.h>
>  #include <linux/backing-dev.h>
>  #include <linux/swap_cgroup.h>
> +#include <linux/eventfd.h>
> +#include <linux/poll.h>
> +#include <linux/sort.h>
> +#include <linux/file.h>
>  
>  #include "internal.h"
>  #include "swap.h"
> @@ -60,6 +64,54 @@ static struct move_charge_struct {
>  	.waitq = __WAIT_QUEUE_HEAD_INITIALIZER(mc.waitq),
>  };
>  
> +/* for OOM */
> +struct mem_cgroup_eventfd_list {
> +	struct list_head list;
> +	struct eventfd_ctx *eventfd;
> +};
> +
> +/*
> + * cgroup_event represents events which userspace want to receive.
> + */
> +struct mem_cgroup_event {
> +	/*
> +	 * memcg which the event belongs to.
> +	 */
> +	struct mem_cgroup *memcg;
> +	/*
> +	 * eventfd to signal userspace about the event.
> +	 */
> +	struct eventfd_ctx *eventfd;
> +	/*
> +	 * Each of these stored in a list by the cgroup.
> +	 */
> +	struct list_head list;
> +	/*
> +	 * register_event() callback will be used to add new userspace
> +	 * waiter for changes related to this event.  Use eventfd_signal()
> +	 * on eventfd to send notification to userspace.
> +	 */
> +	int (*register_event)(struct mem_cgroup *memcg,
> +			      struct eventfd_ctx *eventfd, const char *args);
> +	/*
> +	 * unregister_event() callback will be called when userspace closes
> +	 * the eventfd or on cgroup removing.  This callback must be set,
> +	 * if you want provide notification functionality.
> +	 */
> +	void (*unregister_event)(struct mem_cgroup *memcg,
> +				 struct eventfd_ctx *eventfd);
> +	/*
> +	 * All fields below needed to unregister event when
> +	 * userspace closes eventfd.
> +	 */
> +	poll_table pt;
> +	wait_queue_head_t *wqh;
> +	wait_queue_entry_t wait;
> +	struct work_struct remove;
> +};
> +
> +extern spinlock_t memcg_oom_lock;
> +
>  static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  					 struct mem_cgroup_tree_per_node *mctz,
>  					 unsigned long new_usage_in_excess)
> @@ -1306,6 +1358,607 @@ void memcg1_move_task(void)
>  }
>  #endif
>  
> +static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
> +{
> +	struct mem_cgroup_threshold_ary *t;
> +	unsigned long usage;
> +	int i;
> +
> +	rcu_read_lock();
> +	if (!swap)
> +		t = rcu_dereference(memcg->thresholds.primary);
> +	else
> +		t = rcu_dereference(memcg->memsw_thresholds.primary);
> +
> +	if (!t)
> +		goto unlock;
> +
> +	usage = mem_cgroup_usage(memcg, swap);
> +
> +	/*
> +	 * current_threshold points to threshold just below or equal to usage.
> +	 * If it's not true, a threshold was crossed after last
> +	 * call of __mem_cgroup_threshold().
> +	 */
> +	i = t->current_threshold;
> +
> +	/*
> +	 * Iterate backward over array of thresholds starting from
> +	 * current_threshold and check if a threshold is crossed.
> +	 * If none of thresholds below usage is crossed, we read
> +	 * only one element of the array here.
> +	 */
> +	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
> +		eventfd_signal(t->entries[i].eventfd);
> +
> +	/* i = current_threshold + 1 */
> +	i++;
> +
> +	/*
> +	 * Iterate forward over array of thresholds starting from
> +	 * current_threshold+1 and check if a threshold is crossed.
> +	 * If none of thresholds above usage is crossed, we read
> +	 * only one element of the array here.
> +	 */
> +	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
> +		eventfd_signal(t->entries[i].eventfd);
> +
> +	/* Update current_threshold */
> +	t->current_threshold = i - 1;
> +unlock:
> +	rcu_read_unlock();
> +}
> +
> +static void mem_cgroup_threshold(struct mem_cgroup *memcg)
> +{
> +	while (memcg) {
> +		__mem_cgroup_threshold(memcg, false);
> +		if (do_memsw_account())
> +			__mem_cgroup_threshold(memcg, true);
> +
> +		memcg = parent_mem_cgroup(memcg);
> +	}
> +}
> +
> +/*
> + * Check events in order.
> + *
> + */
> +void memcg_check_events(struct mem_cgroup *memcg, int nid)
> +{
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return;
> +
> +	/* threshold event is triggered in finer grain than soft limit */
> +	if (unlikely(mem_cgroup_event_ratelimit(memcg,
> +						MEM_CGROUP_TARGET_THRESH))) {
> +		bool do_softlimit;
> +
> +		do_softlimit = mem_cgroup_event_ratelimit(memcg,
> +						MEM_CGROUP_TARGET_SOFTLIMIT);
> +		mem_cgroup_threshold(memcg);
> +		if (unlikely(do_softlimit))
> +			memcg1_update_tree(memcg, nid);
> +	}
> +}
> +
> +static int compare_thresholds(const void *a, const void *b)
> +{
> +	const struct mem_cgroup_threshold *_a = a;
> +	const struct mem_cgroup_threshold *_b = b;
> +
> +	if (_a->threshold > _b->threshold)
> +		return 1;
> +
> +	if (_a->threshold < _b->threshold)
> +		return -1;
> +
> +	return 0;
> +}
> +
> +static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup_eventfd_list *ev;
> +
> +	spin_lock(&memcg_oom_lock);
> +
> +	list_for_each_entry(ev, &memcg->oom_notify, list)
> +		eventfd_signal(ev->eventfd);
> +
> +	spin_unlock(&memcg_oom_lock);
> +	return 0;
> +}
> +
> +void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter;
> +
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		mem_cgroup_oom_notify_cb(iter);
> +}
> +
> +static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
> +{
> +	struct mem_cgroup_thresholds *thresholds;
> +	struct mem_cgroup_threshold_ary *new;
> +	unsigned long threshold;
> +	unsigned long usage;
> +	int i, size, ret;
> +
> +	ret = page_counter_memparse(args, "-1", &threshold);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&memcg->thresholds_lock);
> +
> +	if (type == _MEM) {
> +		thresholds = &memcg->thresholds;
> +		usage = mem_cgroup_usage(memcg, false);
> +	} else if (type == _MEMSWAP) {
> +		thresholds = &memcg->memsw_thresholds;
> +		usage = mem_cgroup_usage(memcg, true);
> +	} else
> +		BUG();
> +
> +	/* Check if a threshold crossed before adding a new one */
> +	if (thresholds->primary)
> +		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
> +
> +	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
> +
> +	/* Allocate memory for new array of thresholds */
> +	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
> +	if (!new) {
> +		ret = -ENOMEM;
> +		goto unlock;
> +	}
> +	new->size = size;
> +
> +	/* Copy thresholds (if any) to new array */
> +	if (thresholds->primary)
> +		memcpy(new->entries, thresholds->primary->entries,
> +		       flex_array_size(new, entries, size - 1));
> +
> +	/* Add new threshold */
> +	new->entries[size - 1].eventfd = eventfd;
> +	new->entries[size - 1].threshold = threshold;
> +
> +	/* Sort thresholds. Registering of new threshold isn't time-critical */
> +	sort(new->entries, size, sizeof(*new->entries),
> +			compare_thresholds, NULL);
> +
> +	/* Find current threshold */
> +	new->current_threshold = -1;
> +	for (i = 0; i < size; i++) {
> +		if (new->entries[i].threshold <= usage) {
> +			/*
> +			 * new->current_threshold will not be used until
> +			 * rcu_assign_pointer(), so it's safe to increment
> +			 * it here.
> +			 */
> +			++new->current_threshold;
> +		} else
> +			break;
> +	}
> +
> +	/* Free old spare buffer and save old primary buffer as spare */
> +	kfree(thresholds->spare);
> +	thresholds->spare = thresholds->primary;
> +
> +	rcu_assign_pointer(thresholds->primary, new);
> +
> +	/* To be sure that nobody uses thresholds */
> +	synchronize_rcu();
> +
> +unlock:
> +	mutex_unlock(&memcg->thresholds_lock);
> +
> +	return ret;
> +}
> +
> +static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd, const char *args)
> +{
> +	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
> +}
> +
> +static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd, const char *args)
> +{
> +	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
> +}
> +
> +static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd, enum res_type type)
> +{
> +	struct mem_cgroup_thresholds *thresholds;
> +	struct mem_cgroup_threshold_ary *new;
> +	unsigned long usage;
> +	int i, j, size, entries;
> +
> +	mutex_lock(&memcg->thresholds_lock);
> +
> +	if (type == _MEM) {
> +		thresholds = &memcg->thresholds;
> +		usage = mem_cgroup_usage(memcg, false);
> +	} else if (type == _MEMSWAP) {
> +		thresholds = &memcg->memsw_thresholds;
> +		usage = mem_cgroup_usage(memcg, true);
> +	} else
> +		BUG();
> +
> +	if (!thresholds->primary)
> +		goto unlock;
> +
> +	/* Check if a threshold crossed before removing */
> +	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
> +
> +	/* Calculate new number of threshold */
> +	size = entries = 0;
> +	for (i = 0; i < thresholds->primary->size; i++) {
> +		if (thresholds->primary->entries[i].eventfd != eventfd)
> +			size++;
> +		else
> +			entries++;
> +	}
> +
> +	new = thresholds->spare;
> +
> +	/* If no items related to eventfd have been cleared, nothing to do */
> +	if (!entries)
> +		goto unlock;
> +
> +	/* Set thresholds array to NULL if we don't have thresholds */
> +	if (!size) {
> +		kfree(new);
> +		new = NULL;
> +		goto swap_buffers;
> +	}
> +
> +	new->size = size;
> +
> +	/* Copy thresholds and find current threshold */
> +	new->current_threshold = -1;
> +	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
> +		if (thresholds->primary->entries[i].eventfd == eventfd)
> +			continue;
> +
> +		new->entries[j] = thresholds->primary->entries[i];
> +		if (new->entries[j].threshold <= usage) {
> +			/*
> +			 * new->current_threshold will not be used
> +			 * until rcu_assign_pointer(), so it's safe to increment
> +			 * it here.
> +			 */
> +			++new->current_threshold;
> +		}
> +		j++;
> +	}
> +
> +swap_buffers:
> +	/* Swap primary and spare array */
> +	thresholds->spare = thresholds->primary;
> +
> +	rcu_assign_pointer(thresholds->primary, new);
> +
> +	/* To be sure that nobody uses thresholds */
> +	synchronize_rcu();
> +
> +	/* If all events are unregistered, free the spare array */
> +	if (!new) {
> +		kfree(thresholds->spare);
> +		thresholds->spare = NULL;
> +	}
> +unlock:
> +	mutex_unlock(&memcg->thresholds_lock);
> +}
> +
> +static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd)
> +{
> +	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
> +}
> +
> +static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd)
> +{
> +	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
> +}
> +
> +static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd, const char *args)
> +{
> +	struct mem_cgroup_eventfd_list *event;
> +
> +	event = kmalloc(sizeof(*event),	GFP_KERNEL);
> +	if (!event)
> +		return -ENOMEM;
> +
> +	spin_lock(&memcg_oom_lock);
> +
> +	event->eventfd = eventfd;
> +	list_add(&event->list, &memcg->oom_notify);
> +
> +	/* already in OOM ? */
> +	if (memcg->under_oom)
> +		eventfd_signal(eventfd);
> +	spin_unlock(&memcg_oom_lock);
> +
> +	return 0;
> +}
> +
> +static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
> +	struct eventfd_ctx *eventfd)
> +{
> +	struct mem_cgroup_eventfd_list *ev, *tmp;
> +
> +	spin_lock(&memcg_oom_lock);
> +
> +	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
> +		if (ev->eventfd == eventfd) {
> +			list_del(&ev->list);
> +			kfree(ev);
> +		}
> +	}
> +
> +	spin_unlock(&memcg_oom_lock);
> +}
> +
> +/*
> + * DO NOT USE IN NEW FILES.
> + *
> + * "cgroup.event_control" implementation.
> + *
> + * This is way over-engineered.  It tries to support fully configurable
> + * events for each user.  Such level of flexibility is completely
> + * unnecessary especially in the light of the planned unified hierarchy.
> + *
> + * Please deprecate this and replace with something simpler if at all
> + * possible.
> + */
> +
> +/*
> + * Unregister event and free resources.
> + *
> + * Gets called from workqueue.
> + */
> +static void memcg_event_remove(struct work_struct *work)
> +{
> +	struct mem_cgroup_event *event =
> +		container_of(work, struct mem_cgroup_event, remove);
> +	struct mem_cgroup *memcg = event->memcg;
> +
> +	remove_wait_queue(event->wqh, &event->wait);
> +
> +	event->unregister_event(memcg, event->eventfd);
> +
> +	/* Notify userspace the event is going away. */
> +	eventfd_signal(event->eventfd);
> +
> +	eventfd_ctx_put(event->eventfd);
> +	kfree(event);
> +	css_put(&memcg->css);
> +}
> +
> +/*
> + * Gets called on EPOLLHUP on eventfd when user closes it.
> + *
> + * Called with wqh->lock held and interrupts disabled.
> + */
> +static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
> +			    int sync, void *key)
> +{
> +	struct mem_cgroup_event *event =
> +		container_of(wait, struct mem_cgroup_event, wait);
> +	struct mem_cgroup *memcg = event->memcg;
> +	__poll_t flags = key_to_poll(key);
> +
> +	if (flags & EPOLLHUP) {
> +		/*
> +		 * If the event has been detached at cgroup removal, we
> +		 * can simply return knowing the other side will cleanup
> +		 * for us.
> +		 *
> +		 * We can't race against event freeing since the other
> +		 * side will require wqh->lock via remove_wait_queue(),
> +		 * which we hold.
> +		 */
> +		spin_lock(&memcg->event_list_lock);
> +		if (!list_empty(&event->list)) {
> +			list_del_init(&event->list);
> +			/*
> +			 * We are in atomic context, but cgroup_event_remove()
> +			 * may sleep, so we have to call it in workqueue.
> +			 */
> +			schedule_work(&event->remove);
> +		}
> +		spin_unlock(&memcg->event_list_lock);
> +	}
> +
> +	return 0;
> +}
> +
> +static void memcg_event_ptable_queue_proc(struct file *file,
> +		wait_queue_head_t *wqh, poll_table *pt)
> +{
> +	struct mem_cgroup_event *event =
> +		container_of(pt, struct mem_cgroup_event, pt);
> +
> +	event->wqh = wqh;
> +	add_wait_queue(wqh, &event->wait);
> +}
> +
> +/*
> + * DO NOT USE IN NEW FILES.
> + *
> + * Parse input and register new cgroup event handler.
> + *
> + * Input must be in format '<event_fd> <control_fd> <args>'.
> + * Interpretation of args is defined by control file implementation.
> + */
> +ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> +				  char *buf, size_t nbytes, loff_t off)
> +{
> +	struct cgroup_subsys_state *css = of_css(of);
> +	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> +	struct mem_cgroup_event *event;
> +	struct cgroup_subsys_state *cfile_css;
> +	unsigned int efd, cfd;
> +	struct fd efile;
> +	struct fd cfile;
> +	struct dentry *cdentry;
> +	const char *name;
> +	char *endp;
> +	int ret;
> +
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return -EOPNOTSUPP;
> +
> +	buf = strstrip(buf);
> +
> +	efd = simple_strtoul(buf, &endp, 10);
> +	if (*endp != ' ')
> +		return -EINVAL;
> +	buf = endp + 1;
> +
> +	cfd = simple_strtoul(buf, &endp, 10);
> +	if ((*endp != ' ') && (*endp != '\0'))
> +		return -EINVAL;
> +	buf = endp + 1;
> +
> +	event = kzalloc(sizeof(*event), GFP_KERNEL);
> +	if (!event)
> +		return -ENOMEM;
> +
> +	event->memcg = memcg;
> +	INIT_LIST_HEAD(&event->list);
> +	init_poll_funcptr(&event->pt, memcg_event_ptable_queue_proc);
> +	init_waitqueue_func_entry(&event->wait, memcg_event_wake);
> +	INIT_WORK(&event->remove, memcg_event_remove);
> +
> +	efile = fdget(efd);
> +	if (!efile.file) {
> +		ret = -EBADF;
> +		goto out_kfree;
> +	}
> +
> +	event->eventfd = eventfd_ctx_fileget(efile.file);
> +	if (IS_ERR(event->eventfd)) {
> +		ret = PTR_ERR(event->eventfd);
> +		goto out_put_efile;
> +	}
> +
> +	cfile = fdget(cfd);
> +	if (!cfile.file) {
> +		ret = -EBADF;
> +		goto out_put_eventfd;
> +	}
> +
> +	/* the process need read permission on control file */
> +	/* AV: shouldn't we check that it's been opened for read instead? */
> +	ret = file_permission(cfile.file, MAY_READ);
> +	if (ret < 0)
> +		goto out_put_cfile;
> +
> +	/*
> +	 * The control file must be a regular cgroup1 file. As a regular cgroup
> +	 * file can't be renamed, it's safe to access its name afterwards.
> +	 */
> +	cdentry = cfile.file->f_path.dentry;
> +	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
> +		ret = -EINVAL;
> +		goto out_put_cfile;
> +	}
> +
> +	/*
> +	 * Determine the event callbacks and set them in @event.  This used
> +	 * to be done via struct cftype but cgroup core no longer knows
> +	 * about these events.  The following is crude but the whole thing
> +	 * is for compatibility anyway.
> +	 *
> +	 * DO NOT ADD NEW FILES.
> +	 */
> +	name = cdentry->d_name.name;
> +
> +	if (!strcmp(name, "memory.usage_in_bytes")) {
> +		event->register_event = mem_cgroup_usage_register_event;
> +		event->unregister_event = mem_cgroup_usage_unregister_event;
> +	} else if (!strcmp(name, "memory.oom_control")) {
> +		event->register_event = mem_cgroup_oom_register_event;
> +		event->unregister_event = mem_cgroup_oom_unregister_event;
> +	} else if (!strcmp(name, "memory.pressure_level")) {
> +		event->register_event = vmpressure_register_event;
> +		event->unregister_event = vmpressure_unregister_event;
> +	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> +		event->register_event = memsw_cgroup_usage_register_event;
> +		event->unregister_event = memsw_cgroup_usage_unregister_event;
> +	} else {
> +		ret = -EINVAL;
> +		goto out_put_cfile;
> +	}
> +
> +	/*
> +	 * Verify @cfile should belong to @css.  Also, remaining events are
> +	 * automatically removed on cgroup destruction but the removal is
> +	 * asynchronous, so take an extra ref on @css.
> +	 */
> +	cfile_css = css_tryget_online_from_dir(cdentry->d_parent,
> +					       &memory_cgrp_subsys);
> +	ret = -EINVAL;
> +	if (IS_ERR(cfile_css))
> +		goto out_put_cfile;
> +	if (cfile_css != css) {
> +		css_put(cfile_css);
> +		goto out_put_cfile;
> +	}
> +
> +	ret = event->register_event(memcg, event->eventfd, buf);
> +	if (ret)
> +		goto out_put_css;
> +
> +	vfs_poll(efile.file, &event->pt);
> +
> +	spin_lock_irq(&memcg->event_list_lock);
> +	list_add(&event->list, &memcg->event_list);
> +	spin_unlock_irq(&memcg->event_list_lock);
> +
> +	fdput(cfile);
> +	fdput(efile);
> +
> +	return nbytes;
> +
> +out_put_css:
> +	css_put(css);
> +out_put_cfile:
> +	fdput(cfile);
> +out_put_eventfd:
> +	eventfd_ctx_put(event->eventfd);
> +out_put_efile:
> +	fdput(efile);
> +out_kfree:
> +	kfree(event);
> +
> +	return ret;
> +}
> +
> +void memcg1_css_offline(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup_event *event, *tmp;
> +
> +	/*
> +	 * Unregister events and notify userspace.
> +	 * Notify userspace about cgroup removing only after rmdir of cgroup
> +	 * directory to avoid race between userspace and kernelspace.
> +	 */
> +	spin_lock_irq(&memcg->event_list_lock);
> +	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
> +		list_del_init(&event->list);
> +		schedule_work(&event->remove);
> +	}
> +	spin_unlock_irq(&memcg->event_list_lock);
> +}
> +
>  static int __init memcg1_init(void)
>  {
>  	int node;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index d377c0be9880..524a2c76ffc9 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -41,4 +41,55 @@ u64 mem_cgroup_move_charge_read(struct cgroup_subsys_state *css,
>  int mem_cgroup_move_charge_write(struct cgroup_subsys_state *css,
>  				 struct cftype *cft, u64 val);
>  
> +/*
> + * Per memcg event counter is incremented at every pagein/pageout. With THP,
> + * it will be incremented by the number of pages. This counter is used
> + * to trigger some periodic events. This is straightforward and better
> + * than using jiffies etc. to handle periodic memcg event.
> + */
> +enum mem_cgroup_events_target {
> +	MEM_CGROUP_TARGET_THRESH,
> +	MEM_CGROUP_TARGET_SOFTLIMIT,
> +	MEM_CGROUP_NTARGETS,
> +};
> +
> +/* Whether legacy memory+swap accounting is active */
> +static bool do_memsw_account(void)
> +{
> +	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> +}
> +
> +/*
> + * Iteration constructs for visiting all cgroups (under a tree).  If
> + * loops are exited prematurely (break), mem_cgroup_iter_break() must
> + * be used for reference counting.
> + */
> +#define for_each_mem_cgroup_tree(iter, root)		\
> +	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
> +	     iter != NULL;				\
> +	     iter = mem_cgroup_iter(root, iter, NULL))
> +
> +#define for_each_mem_cgroup(iter)			\
> +	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
> +	     iter != NULL;				\
> +	     iter = mem_cgroup_iter(NULL, iter, NULL))
> +
> +void memcg1_css_offline(struct mem_cgroup *memcg);
> +
> +/* for encoding cft->private value on file */
> +enum res_type {
> +	_MEM,
> +	_MEMSWAP,
> +	_KMEM,
> +	_TCP,
> +};
> +
> +bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
> +				enum mem_cgroup_events_target target);
> +unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
> +void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
> +ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> +				  char *buf, size_t nbytes, loff_t off);
> +
> +
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index da2c0fa0de1b..bd4b26a73596 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -46,9 +46,6 @@
>  #include <linux/slab.h>
>  #include <linux/swapops.h>
>  #include <linux/spinlock.h>
> -#include <linux/eventfd.h>
> -#include <linux/poll.h>
> -#include <linux/sort.h>
>  #include <linux/fs.h>
>  #include <linux/seq_file.h>
>  #include <linux/parser.h>
> @@ -59,7 +56,6 @@
>  #include <linux/cpu.h>
>  #include <linux/oom.h>
>  #include <linux/lockdep.h>
> -#include <linux/file.h>
>  #include <linux/resume_user_mode.h>
>  #include <linux/psi.h>
>  #include <linux/seq_buf.h>
> @@ -97,91 +93,13 @@ static bool cgroup_memory_nobpf __ro_after_init;
>  static DECLARE_WAIT_QUEUE_HEAD(memcg_cgwb_frn_waitq);
>  #endif
>  
> -/* Whether legacy memory+swap accounting is active */
> -static bool do_memsw_account(void)
> -{
> -	return !cgroup_subsys_on_dfl(memory_cgrp_subsys);
> -}
> -
>  #define THRESHOLDS_EVENTS_TARGET 128
>  #define SOFTLIMIT_EVENTS_TARGET 1024
>  
> -/* for OOM */
> -struct mem_cgroup_eventfd_list {
> -	struct list_head list;
> -	struct eventfd_ctx *eventfd;
> -};
> -
> -/*
> - * cgroup_event represents events which userspace want to receive.
> - */
> -struct mem_cgroup_event {
> -	/*
> -	 * memcg which the event belongs to.
> -	 */
> -	struct mem_cgroup *memcg;
> -	/*
> -	 * eventfd to signal userspace about the event.
> -	 */
> -	struct eventfd_ctx *eventfd;
> -	/*
> -	 * Each of these stored in a list by the cgroup.
> -	 */
> -	struct list_head list;
> -	/*
> -	 * register_event() callback will be used to add new userspace
> -	 * waiter for changes related to this event.  Use eventfd_signal()
> -	 * on eventfd to send notification to userspace.
> -	 */
> -	int (*register_event)(struct mem_cgroup *memcg,
> -			      struct eventfd_ctx *eventfd, const char *args);
> -	/*
> -	 * unregister_event() callback will be called when userspace closes
> -	 * the eventfd or on cgroup removing.  This callback must be set,
> -	 * if you want provide notification functionality.
> -	 */
> -	void (*unregister_event)(struct mem_cgroup *memcg,
> -				 struct eventfd_ctx *eventfd);
> -	/*
> -	 * All fields below needed to unregister event when
> -	 * userspace closes eventfd.
> -	 */
> -	poll_table pt;
> -	wait_queue_head_t *wqh;
> -	wait_queue_entry_t wait;
> -	struct work_struct remove;
> -};
> -
> -static void mem_cgroup_threshold(struct mem_cgroup *memcg);
> -static void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
> -
> -/* for encoding cft->private value on file */
> -enum res_type {
> -	_MEM,
> -	_MEMSWAP,
> -	_KMEM,
> -	_TCP,
> -};
> -
>  #define MEMFILE_PRIVATE(x, val)	((x) << 16 | (val))
>  #define MEMFILE_TYPE(val)	((val) >> 16 & 0xffff)
>  #define MEMFILE_ATTR(val)	((val) & 0xffff)
>  
> -/*
> - * Iteration constructs for visiting all cgroups (under a tree).  If
> - * loops are exited prematurely (break), mem_cgroup_iter_break() must
> - * be used for reference counting.
> - */
> -#define for_each_mem_cgroup_tree(iter, root)		\
> -	for (iter = mem_cgroup_iter(root, NULL, NULL);	\
> -	     iter != NULL;				\
> -	     iter = mem_cgroup_iter(root, iter, NULL))
> -
> -#define for_each_mem_cgroup(iter)			\
> -	for (iter = mem_cgroup_iter(NULL, NULL, NULL);	\
> -	     iter != NULL;				\
> -	     iter = mem_cgroup_iter(NULL, iter, NULL))
> -
>  static inline bool task_is_dying(void)
>  {
>  	return tsk_is_oom_victim(current) || fatal_signal_pending(current) ||
> @@ -940,8 +858,8 @@ void mem_cgroup_charge_statistics(struct mem_cgroup *memcg, int nr_pages)
>  	__this_cpu_add(memcg->vmstats_percpu->nr_page_events, nr_pages);
>  }
>  
> -static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
> -				       enum mem_cgroup_events_target target)
> +bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
> +				enum mem_cgroup_events_target target)
>  {
>  	unsigned long val, next;
>  
> @@ -965,28 +883,6 @@ static bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>  	return false;
>  }
>  
> -/*
> - * Check events in order.
> - *
> - */
> -void memcg_check_events(struct mem_cgroup *memcg, int nid)
> -{
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		return;
> -
> -	/* threshold event is triggered in finer grain than soft limit */
> -	if (unlikely(mem_cgroup_event_ratelimit(memcg,
> -						MEM_CGROUP_TARGET_THRESH))) {
> -		bool do_softlimit;
> -
> -		do_softlimit = mem_cgroup_event_ratelimit(memcg,
> -						MEM_CGROUP_TARGET_SOFTLIMIT);
> -		mem_cgroup_threshold(memcg);
> -		if (unlikely(do_softlimit))
> -			memcg1_update_tree(memcg, nid);
> -	}
> -}
> -
>  struct mem_cgroup *mem_cgroup_from_task(struct task_struct *p)
>  {
>  	/*
> @@ -1726,7 +1622,7 @@ static struct lockdep_map memcg_oom_lock_dep_map = {
>  };
>  #endif
>  
> -static DEFINE_SPINLOCK(memcg_oom_lock);
> +DEFINE_SPINLOCK(memcg_oom_lock);
>  
>  /*
>   * Check OOM-Killer is already running under our hierarchy.
> @@ -3545,7 +3441,7 @@ static int mem_cgroup_hierarchy_write(struct cgroup_subsys_state *css,
>  	return -EINVAL;
>  }
>  
> -static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
> +unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap)
>  {
>  	unsigned long val;
>  
> @@ -4046,331 +3942,6 @@ static int mem_cgroup_swappiness_write(struct cgroup_subsys_state *css,
>  	return 0;
>  }
>  
> -static void __mem_cgroup_threshold(struct mem_cgroup *memcg, bool swap)
> -{
> -	struct mem_cgroup_threshold_ary *t;
> -	unsigned long usage;
> -	int i;
> -
> -	rcu_read_lock();
> -	if (!swap)
> -		t = rcu_dereference(memcg->thresholds.primary);
> -	else
> -		t = rcu_dereference(memcg->memsw_thresholds.primary);
> -
> -	if (!t)
> -		goto unlock;
> -
> -	usage = mem_cgroup_usage(memcg, swap);
> -
> -	/*
> -	 * current_threshold points to threshold just below or equal to usage.
> -	 * If it's not true, a threshold was crossed after last
> -	 * call of __mem_cgroup_threshold().
> -	 */
> -	i = t->current_threshold;
> -
> -	/*
> -	 * Iterate backward over array of thresholds starting from
> -	 * current_threshold and check if a threshold is crossed.
> -	 * If none of thresholds below usage is crossed, we read
> -	 * only one element of the array here.
> -	 */
> -	for (; i >= 0 && unlikely(t->entries[i].threshold > usage); i--)
> -		eventfd_signal(t->entries[i].eventfd);
> -
> -	/* i = current_threshold + 1 */
> -	i++;
> -
> -	/*
> -	 * Iterate forward over array of thresholds starting from
> -	 * current_threshold+1 and check if a threshold is crossed.
> -	 * If none of thresholds above usage is crossed, we read
> -	 * only one element of the array here.
> -	 */
> -	for (; i < t->size && unlikely(t->entries[i].threshold <= usage); i++)
> -		eventfd_signal(t->entries[i].eventfd);
> -
> -	/* Update current_threshold */
> -	t->current_threshold = i - 1;
> -unlock:
> -	rcu_read_unlock();
> -}
> -
> -static void mem_cgroup_threshold(struct mem_cgroup *memcg)
> -{
> -	while (memcg) {
> -		__mem_cgroup_threshold(memcg, false);
> -		if (do_memsw_account())
> -			__mem_cgroup_threshold(memcg, true);
> -
> -		memcg = parent_mem_cgroup(memcg);
> -	}
> -}
> -
> -static int compare_thresholds(const void *a, const void *b)
> -{
> -	const struct mem_cgroup_threshold *_a = a;
> -	const struct mem_cgroup_threshold *_b = b;
> -
> -	if (_a->threshold > _b->threshold)
> -		return 1;
> -
> -	if (_a->threshold < _b->threshold)
> -		return -1;
> -
> -	return 0;
> -}
> -
> -static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup_eventfd_list *ev;
> -
> -	spin_lock(&memcg_oom_lock);
> -
> -	list_for_each_entry(ev, &memcg->oom_notify, list)
> -		eventfd_signal(ev->eventfd);
> -
> -	spin_unlock(&memcg_oom_lock);
> -	return 0;
> -}
> -
> -static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *iter;
> -
> -	for_each_mem_cgroup_tree(iter, memcg)
> -		mem_cgroup_oom_notify_cb(iter);
> -}
> -
> -static int __mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd, const char *args, enum res_type type)
> -{
> -	struct mem_cgroup_thresholds *thresholds;
> -	struct mem_cgroup_threshold_ary *new;
> -	unsigned long threshold;
> -	unsigned long usage;
> -	int i, size, ret;
> -
> -	ret = page_counter_memparse(args, "-1", &threshold);
> -	if (ret)
> -		return ret;
> -
> -	mutex_lock(&memcg->thresholds_lock);
> -
> -	if (type == _MEM) {
> -		thresholds = &memcg->thresholds;
> -		usage = mem_cgroup_usage(memcg, false);
> -	} else if (type == _MEMSWAP) {
> -		thresholds = &memcg->memsw_thresholds;
> -		usage = mem_cgroup_usage(memcg, true);
> -	} else
> -		BUG();
> -
> -	/* Check if a threshold crossed before adding a new one */
> -	if (thresholds->primary)
> -		__mem_cgroup_threshold(memcg, type == _MEMSWAP);
> -
> -	size = thresholds->primary ? thresholds->primary->size + 1 : 1;
> -
> -	/* Allocate memory for new array of thresholds */
> -	new = kmalloc(struct_size(new, entries, size), GFP_KERNEL);
> -	if (!new) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> -	new->size = size;
> -
> -	/* Copy thresholds (if any) to new array */
> -	if (thresholds->primary)
> -		memcpy(new->entries, thresholds->primary->entries,
> -		       flex_array_size(new, entries, size - 1));
> -
> -	/* Add new threshold */
> -	new->entries[size - 1].eventfd = eventfd;
> -	new->entries[size - 1].threshold = threshold;
> -
> -	/* Sort thresholds. Registering of new threshold isn't time-critical */
> -	sort(new->entries, size, sizeof(*new->entries),
> -			compare_thresholds, NULL);
> -
> -	/* Find current threshold */
> -	new->current_threshold = -1;
> -	for (i = 0; i < size; i++) {
> -		if (new->entries[i].threshold <= usage) {
> -			/*
> -			 * new->current_threshold will not be used until
> -			 * rcu_assign_pointer(), so it's safe to increment
> -			 * it here.
> -			 */
> -			++new->current_threshold;
> -		} else
> -			break;
> -	}
> -
> -	/* Free old spare buffer and save old primary buffer as spare */
> -	kfree(thresholds->spare);
> -	thresholds->spare = thresholds->primary;
> -
> -	rcu_assign_pointer(thresholds->primary, new);
> -
> -	/* To be sure that nobody uses thresholds */
> -	synchronize_rcu();
> -
> -unlock:
> -	mutex_unlock(&memcg->thresholds_lock);
> -
> -	return ret;
> -}
> -
> -static int mem_cgroup_usage_register_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd, const char *args)
> -{
> -	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEM);
> -}
> -
> -static int memsw_cgroup_usage_register_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd, const char *args)
> -{
> -	return __mem_cgroup_usage_register_event(memcg, eventfd, args, _MEMSWAP);
> -}
> -
> -static void __mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd, enum res_type type)
> -{
> -	struct mem_cgroup_thresholds *thresholds;
> -	struct mem_cgroup_threshold_ary *new;
> -	unsigned long usage;
> -	int i, j, size, entries;
> -
> -	mutex_lock(&memcg->thresholds_lock);
> -
> -	if (type == _MEM) {
> -		thresholds = &memcg->thresholds;
> -		usage = mem_cgroup_usage(memcg, false);
> -	} else if (type == _MEMSWAP) {
> -		thresholds = &memcg->memsw_thresholds;
> -		usage = mem_cgroup_usage(memcg, true);
> -	} else
> -		BUG();
> -
> -	if (!thresholds->primary)
> -		goto unlock;
> -
> -	/* Check if a threshold crossed before removing */
> -	__mem_cgroup_threshold(memcg, type == _MEMSWAP);
> -
> -	/* Calculate new number of threshold */
> -	size = entries = 0;
> -	for (i = 0; i < thresholds->primary->size; i++) {
> -		if (thresholds->primary->entries[i].eventfd != eventfd)
> -			size++;
> -		else
> -			entries++;
> -	}
> -
> -	new = thresholds->spare;
> -
> -	/* If no items related to eventfd have been cleared, nothing to do */
> -	if (!entries)
> -		goto unlock;
> -
> -	/* Set thresholds array to NULL if we don't have thresholds */
> -	if (!size) {
> -		kfree(new);
> -		new = NULL;
> -		goto swap_buffers;
> -	}
> -
> -	new->size = size;
> -
> -	/* Copy thresholds and find current threshold */
> -	new->current_threshold = -1;
> -	for (i = 0, j = 0; i < thresholds->primary->size; i++) {
> -		if (thresholds->primary->entries[i].eventfd == eventfd)
> -			continue;
> -
> -		new->entries[j] = thresholds->primary->entries[i];
> -		if (new->entries[j].threshold <= usage) {
> -			/*
> -			 * new->current_threshold will not be used
> -			 * until rcu_assign_pointer(), so it's safe to increment
> -			 * it here.
> -			 */
> -			++new->current_threshold;
> -		}
> -		j++;
> -	}
> -
> -swap_buffers:
> -	/* Swap primary and spare array */
> -	thresholds->spare = thresholds->primary;
> -
> -	rcu_assign_pointer(thresholds->primary, new);
> -
> -	/* To be sure that nobody uses thresholds */
> -	synchronize_rcu();
> -
> -	/* If all events are unregistered, free the spare array */
> -	if (!new) {
> -		kfree(thresholds->spare);
> -		thresholds->spare = NULL;
> -	}
> -unlock:
> -	mutex_unlock(&memcg->thresholds_lock);
> -}
> -
> -static void mem_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd)
> -{
> -	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEM);
> -}
> -
> -static void memsw_cgroup_usage_unregister_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd)
> -{
> -	return __mem_cgroup_usage_unregister_event(memcg, eventfd, _MEMSWAP);
> -}
> -
> -static int mem_cgroup_oom_register_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd, const char *args)
> -{
> -	struct mem_cgroup_eventfd_list *event;
> -
> -	event = kmalloc(sizeof(*event),	GFP_KERNEL);
> -	if (!event)
> -		return -ENOMEM;
> -
> -	spin_lock(&memcg_oom_lock);
> -
> -	event->eventfd = eventfd;
> -	list_add(&event->list, &memcg->oom_notify);
> -
> -	/* already in OOM ? */
> -	if (memcg->under_oom)
> -		eventfd_signal(eventfd);
> -	spin_unlock(&memcg_oom_lock);
> -
> -	return 0;
> -}
> -
> -static void mem_cgroup_oom_unregister_event(struct mem_cgroup *memcg,
> -	struct eventfd_ctx *eventfd)
> -{
> -	struct mem_cgroup_eventfd_list *ev, *tmp;
> -
> -	spin_lock(&memcg_oom_lock);
> -
> -	list_for_each_entry_safe(ev, tmp, &memcg->oom_notify, list) {
> -		if (ev->eventfd == eventfd) {
> -			list_del(&ev->list);
> -			kfree(ev);
> -		}
> -	}
> -
> -	spin_unlock(&memcg_oom_lock);
> -}
> -
>  static int mem_cgroup_oom_control_read(struct seq_file *sf, void *v)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_seq(sf);
> @@ -4611,243 +4182,6 @@ static void memcg_wb_domain_size_changed(struct mem_cgroup *memcg)
>  
>  #endif	/* CONFIG_CGROUP_WRITEBACK */
>  
> -/*
> - * DO NOT USE IN NEW FILES.
> - *
> - * "cgroup.event_control" implementation.
> - *
> - * This is way over-engineered.  It tries to support fully configurable
> - * events for each user.  Such level of flexibility is completely
> - * unnecessary especially in the light of the planned unified hierarchy.
> - *
> - * Please deprecate this and replace with something simpler if at all
> - * possible.
> - */
> -
> -/*
> - * Unregister event and free resources.
> - *
> - * Gets called from workqueue.
> - */
> -static void memcg_event_remove(struct work_struct *work)
> -{
> -	struct mem_cgroup_event *event =
> -		container_of(work, struct mem_cgroup_event, remove);
> -	struct mem_cgroup *memcg = event->memcg;
> -
> -	remove_wait_queue(event->wqh, &event->wait);
> -
> -	event->unregister_event(memcg, event->eventfd);
> -
> -	/* Notify userspace the event is going away. */
> -	eventfd_signal(event->eventfd);
> -
> -	eventfd_ctx_put(event->eventfd);
> -	kfree(event);
> -	css_put(&memcg->css);
> -}
> -
> -/*
> - * Gets called on EPOLLHUP on eventfd when user closes it.
> - *
> - * Called with wqh->lock held and interrupts disabled.
> - */
> -static int memcg_event_wake(wait_queue_entry_t *wait, unsigned mode,
> -			    int sync, void *key)
> -{
> -	struct mem_cgroup_event *event =
> -		container_of(wait, struct mem_cgroup_event, wait);
> -	struct mem_cgroup *memcg = event->memcg;
> -	__poll_t flags = key_to_poll(key);
> -
> -	if (flags & EPOLLHUP) {
> -		/*
> -		 * If the event has been detached at cgroup removal, we
> -		 * can simply return knowing the other side will cleanup
> -		 * for us.
> -		 *
> -		 * We can't race against event freeing since the other
> -		 * side will require wqh->lock via remove_wait_queue(),
> -		 * which we hold.
> -		 */
> -		spin_lock(&memcg->event_list_lock);
> -		if (!list_empty(&event->list)) {
> -			list_del_init(&event->list);
> -			/*
> -			 * We are in atomic context, but cgroup_event_remove()
> -			 * may sleep, so we have to call it in workqueue.
> -			 */
> -			schedule_work(&event->remove);
> -		}
> -		spin_unlock(&memcg->event_list_lock);
> -	}
> -
> -	return 0;
> -}
> -
> -static void memcg_event_ptable_queue_proc(struct file *file,
> -		wait_queue_head_t *wqh, poll_table *pt)
> -{
> -	struct mem_cgroup_event *event =
> -		container_of(pt, struct mem_cgroup_event, pt);
> -
> -	event->wqh = wqh;
> -	add_wait_queue(wqh, &event->wait);
> -}
> -
> -/*
> - * DO NOT USE IN NEW FILES.
> - *
> - * Parse input and register new cgroup event handler.
> - *
> - * Input must be in format '<event_fd> <control_fd> <args>'.
> - * Interpretation of args is defined by control file implementation.
> - */
> -static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
> -					 char *buf, size_t nbytes, loff_t off)
> -{
> -	struct cgroup_subsys_state *css = of_css(of);
> -	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> -	struct mem_cgroup_event *event;
> -	struct cgroup_subsys_state *cfile_css;
> -	unsigned int efd, cfd;
> -	struct fd efile;
> -	struct fd cfile;
> -	struct dentry *cdentry;
> -	const char *name;
> -	char *endp;
> -	int ret;
> -
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT))
> -		return -EOPNOTSUPP;
> -
> -	buf = strstrip(buf);
> -
> -	efd = simple_strtoul(buf, &endp, 10);
> -	if (*endp != ' ')
> -		return -EINVAL;
> -	buf = endp + 1;
> -
> -	cfd = simple_strtoul(buf, &endp, 10);
> -	if ((*endp != ' ') && (*endp != '\0'))
> -		return -EINVAL;
> -	buf = endp + 1;
> -
> -	event = kzalloc(sizeof(*event), GFP_KERNEL);
> -	if (!event)
> -		return -ENOMEM;
> -
> -	event->memcg = memcg;
> -	INIT_LIST_HEAD(&event->list);
> -	init_poll_funcptr(&event->pt, memcg_event_ptable_queue_proc);
> -	init_waitqueue_func_entry(&event->wait, memcg_event_wake);
> -	INIT_WORK(&event->remove, memcg_event_remove);
> -
> -	efile = fdget(efd);
> -	if (!efile.file) {
> -		ret = -EBADF;
> -		goto out_kfree;
> -	}
> -
> -	event->eventfd = eventfd_ctx_fileget(efile.file);
> -	if (IS_ERR(event->eventfd)) {
> -		ret = PTR_ERR(event->eventfd);
> -		goto out_put_efile;
> -	}
> -
> -	cfile = fdget(cfd);
> -	if (!cfile.file) {
> -		ret = -EBADF;
> -		goto out_put_eventfd;
> -	}
> -
> -	/* the process need read permission on control file */
> -	/* AV: shouldn't we check that it's been opened for read instead? */
> -	ret = file_permission(cfile.file, MAY_READ);
> -	if (ret < 0)
> -		goto out_put_cfile;
> -
> -	/*
> -	 * The control file must be a regular cgroup1 file. As a regular cgroup
> -	 * file can't be renamed, it's safe to access its name afterwards.
> -	 */
> -	cdentry = cfile.file->f_path.dentry;
> -	if (cdentry->d_sb->s_type != &cgroup_fs_type || !d_is_reg(cdentry)) {
> -		ret = -EINVAL;
> -		goto out_put_cfile;
> -	}
> -
> -	/*
> -	 * Determine the event callbacks and set them in @event.  This used
> -	 * to be done via struct cftype but cgroup core no longer knows
> -	 * about these events.  The following is crude but the whole thing
> -	 * is for compatibility anyway.
> -	 *
> -	 * DO NOT ADD NEW FILES.
> -	 */
> -	name = cdentry->d_name.name;
> -
> -	if (!strcmp(name, "memory.usage_in_bytes")) {
> -		event->register_event = mem_cgroup_usage_register_event;
> -		event->unregister_event = mem_cgroup_usage_unregister_event;
> -	} else if (!strcmp(name, "memory.oom_control")) {
> -		event->register_event = mem_cgroup_oom_register_event;
> -		event->unregister_event = mem_cgroup_oom_unregister_event;
> -	} else if (!strcmp(name, "memory.pressure_level")) {
> -		event->register_event = vmpressure_register_event;
> -		event->unregister_event = vmpressure_unregister_event;
> -	} else if (!strcmp(name, "memory.memsw.usage_in_bytes")) {
> -		event->register_event = memsw_cgroup_usage_register_event;
> -		event->unregister_event = memsw_cgroup_usage_unregister_event;
> -	} else {
> -		ret = -EINVAL;
> -		goto out_put_cfile;
> -	}
> -
> -	/*
> -	 * Verify @cfile should belong to @css.  Also, remaining events are
> -	 * automatically removed on cgroup destruction but the removal is
> -	 * asynchronous, so take an extra ref on @css.
> -	 */
> -	cfile_css = css_tryget_online_from_dir(cdentry->d_parent,
> -					       &memory_cgrp_subsys);
> -	ret = -EINVAL;
> -	if (IS_ERR(cfile_css))
> -		goto out_put_cfile;
> -	if (cfile_css != css) {
> -		css_put(cfile_css);
> -		goto out_put_cfile;
> -	}
> -
> -	ret = event->register_event(memcg, event->eventfd, buf);
> -	if (ret)
> -		goto out_put_css;
> -
> -	vfs_poll(efile.file, &event->pt);
> -
> -	spin_lock_irq(&memcg->event_list_lock);
> -	list_add(&event->list, &memcg->event_list);
> -	spin_unlock_irq(&memcg->event_list_lock);
> -
> -	fdput(cfile);
> -	fdput(efile);
> -
> -	return nbytes;
> -
> -out_put_css:
> -	css_put(css);
> -out_put_cfile:
> -	fdput(cfile);
> -out_put_eventfd:
> -	eventfd_ctx_put(event->eventfd);
> -out_put_efile:
> -	fdput(efile);
> -out_kfree:
> -	kfree(event);
> -
> -	return ret;
> -}
> -
>  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
>  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  {
> @@ -5314,19 +4648,8 @@ static int mem_cgroup_css_online(struct cgroup_subsys_state *css)
>  static void mem_cgroup_css_offline(struct cgroup_subsys_state *css)
>  {
>  	struct mem_cgroup *memcg = mem_cgroup_from_css(css);
> -	struct mem_cgroup_event *event, *tmp;
>  
> -	/*
> -	 * Unregister events and notify userspace.
> -	 * Notify userspace about cgroup removing only after rmdir of cgroup
> -	 * directory to avoid race between userspace and kernelspace.
> -	 */
> -	spin_lock_irq(&memcg->event_list_lock);
> -	list_for_each_entry_safe(event, tmp, &memcg->event_list, list) {
> -		list_del_init(&event->list);
> -		schedule_work(&event->remove);
> -	}
> -	spin_unlock_irq(&memcg->event_list_lock);
> +	memcg1_css_offline(memcg);
>  
>  	page_counter_set_min(&memcg->memory, 0);
>  	page_counter_set_low(&memcg->memory, 0);
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

