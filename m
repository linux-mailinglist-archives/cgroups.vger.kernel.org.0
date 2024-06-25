Return-Path: <cgroups+bounces-3348-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A18915FA7
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 09:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CCE7280F93
	for <lists+cgroups@lfdr.de>; Tue, 25 Jun 2024 07:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8571494C8;
	Tue, 25 Jun 2024 07:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sakl6TOT"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B4014A62F
	for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 07:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719299314; cv=none; b=Cp8sJ9JpeieV2ydoAmMX3KaktglaMLBzVFM4l0oslUFgWQ9IE8xdpoHsiV68b5iFjRu32rPFfVInOpRlNODCaVl9ZA2CRDuNKdfKKpRuTqg9MCXWQgBeUGmpHwkXs6rXpALHF4n7P9sYsZELa8n14qHGFVkAw9sBKzRF1KjSUB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719299314; c=relaxed/simple;
	bh=jCrJEMdo99QGceBU1xVbJ4UZd+7DkeL79d8Wk3B85kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBw7p+tISf91D5/mimIWuNv3Nh4lAJ6gk8ZlQ7jBpHz21Pd4+drW6PbVghEFoGN3AvCAO/YGo4MRtGtzSKwyo30PQnHyQCgzFRGNIt7WBNXcTztaog8pWvNrCVVAvcC5LeM/kvRFbV+0yN51cFzeto0UJMu4o0g8xeIlRAlWyI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sakl6TOT; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a725282b926so244192066b.0
        for <cgroups@vger.kernel.org>; Tue, 25 Jun 2024 00:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1719299309; x=1719904109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xyOXxnQynoFodkVpIwJuTU6KXaFUk8BI30dcxk589UQ=;
        b=Sakl6TOTS9xGvwd1AU6tXdBIagY7RT0CSQfxI5lfRzpTMpj3t2jaZz+yCOYzrw5C3d
         GwwnemJljT87Q+lyen5eXvrnDTLf63rU5DTmlTGWABCBLW41yIg0XyIwgCUgYbOP3rki
         NcADC4p1e9LU4UMmhMxPyqRhdqc31CYMusyRxr02NvLNmJtgeyaaPYXH+UyXftPdlthu
         W5cSiaOMeXktF0/F1Y4BI6TYAlschYlLyIwG00P2DBJFnQgtHCC+gaoY4QB+yXLo6rp5
         gsHNZuxOqfasJ985V5thiyqg7NZGXMQ1KJVHd+ZXmww6EwM+fy1+BfNpV80Fom3IqPsB
         POgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719299309; x=1719904109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyOXxnQynoFodkVpIwJuTU6KXaFUk8BI30dcxk589UQ=;
        b=t2ZJR6oKQQfJwuhR5aFQ2p9qSsuHUstSE07Y4zo5ilz7b+ugMW3uoytexTuKxJ6+9c
         cybB/TrxcykhIg3n/KbDp8uRI/AGGwIAC1pGKGSq7MmGDC3RWFIRdSDU3XvUliKA4/cM
         xOKKi3SWM9jOPaksRpKYaJR8vPTmLWBtTPZX8Nk7kDZQaBNpIJ7iqU8cDLmOmUcvOkoS
         J0G9ScE8gXi2BVDqQ0b0vfCfdlzTH8FmoqYQ5EIB9qm7PGczuC93qH0tWoYH4gQ2niTy
         y0fwUhmaeUUfWsACeY40bOrU5J+Mf5l5VLPWazYGdEDCJ8MAkyOREnQgovTHJWwIhGjx
         pyPA==
X-Forwarded-Encrypted: i=1; AJvYcCUQXnxljPdUn8WIwaSIAReHmQUS6KIJVPprdXONFWf8/9O3W20MtVHXkWz1APpahztIdoEyvdbN2wdfbWKG3na3C4aYU/0Szg==
X-Gm-Message-State: AOJu0Yxec4Ji8V2BiL0Q6G9NaOgGo0UhKEn0iy9L5KFFmWKz6ePk+E4F
	H6qWMP1Bq7OLSqGu1OBrZI2lU+5156bXc00j3Skt7oWD1mIRIwnwUFe0qg6SsCE=
X-Google-Smtp-Source: AGHT+IHToyxiXKJW1iERakQSaGVg/a4impp4WsyWD8XFkRD7byciNXdvnrBkubTWZUS/5YgxMIJBwA==
X-Received: by 2002:a17:907:a701:b0:a6f:5318:b8f3 with SMTP id a640c23a62f3a-a7245dc96c3mr447197666b.57.1719299308840;
        Tue, 25 Jun 2024 00:08:28 -0700 (PDT)
Received: from localhost (109-81-95-13.rct.o2.cz. [109.81.95.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a725ba97a45sm135719166b.139.2024.06.25.00.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 00:08:28 -0700 (PDT)
Date: Tue, 25 Jun 2024 09:08:27 +0200
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>, linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 08/14] mm: memcg: move cgroup v1 oom handling code
 into memcontrol-v1.c
Message-ID: <Znps61ZevzhuoWb_@tiehlicka>
References: <20240625005906.106920-1-roman.gushchin@linux.dev>
 <20240625005906.106920-9-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625005906.106920-9-roman.gushchin@linux.dev>

On Mon 24-06-24 17:59:00, Roman Gushchin wrote:
> Cgroup v1 supports a complicated OOM handling in userspace mechanism,
> which is not supported by cgroup v2. Let's move the corresponding code
> into memcontrol-v1.c.
> 
> Aside from mechanical code movement this patch introduces two new
> functions: memcg1_oom_prepare() and memcg1_oom_finish().
> Those are implementing cgroup v1-specific parts of the common memcg
> OOM handling path.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol-v1.c | 229 ++++++++++++++++++++++++++++++++++++++++++++-
>  mm/memcontrol-v1.h |   3 +-
>  mm/memcontrol.c    | 216 +-----------------------------------------
>  3 files changed, 231 insertions(+), 217 deletions(-)
> 
> diff --git a/mm/memcontrol-v1.c b/mm/memcontrol-v1.c
> index d7b5c4c14732..253d49d5fb12 100644
> --- a/mm/memcontrol-v1.c
> +++ b/mm/memcontrol-v1.c
> @@ -110,7 +110,13 @@ struct mem_cgroup_event {
>  	struct work_struct remove;
>  };
>  
> -extern spinlock_t memcg_oom_lock;
> +#ifdef CONFIG_LOCKDEP
> +static struct lockdep_map memcg_oom_lock_dep_map = {
> +	.name = "memcg_oom_lock",
> +};
> +#endif
> +
> +DEFINE_SPINLOCK(memcg_oom_lock);
>  
>  static void __mem_cgroup_insert_exceeded(struct mem_cgroup_per_node *mz,
>  					 struct mem_cgroup_tree_per_node *mctz,
> @@ -1469,7 +1475,7 @@ static int mem_cgroup_oom_notify_cb(struct mem_cgroup *memcg)
>  	return 0;
>  }
>  
> -void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
> +static void mem_cgroup_oom_notify(struct mem_cgroup *memcg)
>  {
>  	struct mem_cgroup *iter;
>  
> @@ -1959,6 +1965,225 @@ void memcg1_css_offline(struct mem_cgroup *memcg)
>  	spin_unlock_irq(&memcg->event_list_lock);
>  }
>  
> +/*
> + * Check OOM-Killer is already running under our hierarchy.
> + * If someone is running, return false.
> + */
> +static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter, *failed = NULL;
> +
> +	spin_lock(&memcg_oom_lock);
> +
> +	for_each_mem_cgroup_tree(iter, memcg) {
> +		if (iter->oom_lock) {
> +			/*
> +			 * this subtree of our hierarchy is already locked
> +			 * so we cannot give a lock.
> +			 */
> +			failed = iter;
> +			mem_cgroup_iter_break(memcg, iter);
> +			break;
> +		} else
> +			iter->oom_lock = true;
> +	}
> +
> +	if (failed) {
> +		/*
> +		 * OK, we failed to lock the whole subtree so we have
> +		 * to clean up what we set up to the failing subtree
> +		 */
> +		for_each_mem_cgroup_tree(iter, memcg) {
> +			if (iter == failed) {
> +				mem_cgroup_iter_break(memcg, iter);
> +				break;
> +			}
> +			iter->oom_lock = false;
> +		}
> +	} else
> +		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
> +
> +	spin_unlock(&memcg_oom_lock);
> +
> +	return !failed;
> +}
> +
> +static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter;
> +
> +	spin_lock(&memcg_oom_lock);
> +	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		iter->oom_lock = false;
> +	spin_unlock(&memcg_oom_lock);
> +}
> +
> +static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter;
> +
> +	spin_lock(&memcg_oom_lock);
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		iter->under_oom++;
> +	spin_unlock(&memcg_oom_lock);
> +}
> +
> +static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
> +{
> +	struct mem_cgroup *iter;
> +
> +	/*
> +	 * Be careful about under_oom underflows because a child memcg
> +	 * could have been added after mem_cgroup_mark_under_oom.
> +	 */
> +	spin_lock(&memcg_oom_lock);
> +	for_each_mem_cgroup_tree(iter, memcg)
> +		if (iter->under_oom > 0)
> +			iter->under_oom--;
> +	spin_unlock(&memcg_oom_lock);
> +}
> +
> +static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
> +
> +struct oom_wait_info {
> +	struct mem_cgroup *memcg;
> +	wait_queue_entry_t	wait;
> +};
> +
> +static int memcg_oom_wake_function(wait_queue_entry_t *wait,
> +	unsigned mode, int sync, void *arg)
> +{
> +	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
> +	struct mem_cgroup *oom_wait_memcg;
> +	struct oom_wait_info *oom_wait_info;
> +
> +	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
> +	oom_wait_memcg = oom_wait_info->memcg;
> +
> +	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
> +	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
> +		return 0;
> +	return autoremove_wake_function(wait, mode, sync, arg);
> +}
> +
> +void memcg_oom_recover(struct mem_cgroup *memcg)
> +{
> +	/*
> +	 * For the following lockless ->under_oom test, the only required
> +	 * guarantee is that it must see the state asserted by an OOM when
> +	 * this function is called as a result of userland actions
> +	 * triggered by the notification of the OOM.  This is trivially
> +	 * achieved by invoking mem_cgroup_mark_under_oom() before
> +	 * triggering notification.
> +	 */
> +	if (memcg && memcg->under_oom)
> +		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
> +}
> +
> +/**
> + * mem_cgroup_oom_synchronize - complete memcg OOM handling
> + * @handle: actually kill/wait or just clean up the OOM state
> + *
> + * This has to be called at the end of a page fault if the memcg OOM
> + * handler was enabled.
> + *
> + * Memcg supports userspace OOM handling where failed allocations must
> + * sleep on a waitqueue until the userspace task resolves the
> + * situation.  Sleeping directly in the charge context with all kinds
> + * of locks held is not a good idea, instead we remember an OOM state
> + * in the task and mem_cgroup_oom_synchronize() has to be called at
> + * the end of the page fault to complete the OOM handling.
> + *
> + * Returns %true if an ongoing memcg OOM situation was detected and
> + * completed, %false otherwise.
> + */
> +bool mem_cgroup_oom_synchronize(bool handle)
> +{
> +	struct mem_cgroup *memcg = current->memcg_in_oom;
> +	struct oom_wait_info owait;
> +	bool locked;
> +
> +	/* OOM is global, do not handle */
> +	if (!memcg)
> +		return false;
> +
> +	if (!handle)
> +		goto cleanup;
> +
> +	owait.memcg = memcg;
> +	owait.wait.flags = 0;
> +	owait.wait.func = memcg_oom_wake_function;
> +	owait.wait.private = current;
> +	INIT_LIST_HEAD(&owait.wait.entry);
> +
> +	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
> +	mem_cgroup_mark_under_oom(memcg);
> +
> +	locked = mem_cgroup_oom_trylock(memcg);
> +
> +	if (locked)
> +		mem_cgroup_oom_notify(memcg);
> +
> +	schedule();
> +	mem_cgroup_unmark_under_oom(memcg);
> +	finish_wait(&memcg_oom_waitq, &owait.wait);
> +
> +	if (locked)
> +		mem_cgroup_oom_unlock(memcg);
> +cleanup:
> +	current->memcg_in_oom = NULL;
> +	css_put(&memcg->css);
> +	return true;
> +}
> +
> +
> +bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked)
> +{
> +	/*
> +	 * We are in the middle of the charge context here, so we
> +	 * don't want to block when potentially sitting on a callstack
> +	 * that holds all kinds of filesystem and mm locks.
> +	 *
> +	 * cgroup1 allows disabling the OOM killer and waiting for outside
> +	 * handling until the charge can succeed; remember the context and put
> +	 * the task to sleep at the end of the page fault when all locks are
> +	 * released.
> +	 *
> +	 * On the other hand, in-kernel OOM killer allows for an async victim
> +	 * memory reclaim (oom_reaper) and that means that we are not solely
> +	 * relying on the oom victim to make a forward progress and we can
> +	 * invoke the oom killer here.
> +	 *
> +	 * Please note that mem_cgroup_out_of_memory might fail to find a
> +	 * victim and then we have to bail out from the charge path.
> +	 */
> +	if (READ_ONCE(memcg->oom_kill_disable)) {
> +		if (current->in_user_fault) {
> +			css_get(&memcg->css);
> +			current->memcg_in_oom = memcg;
> +		}
> +		return false;
> +	}
> +
> +	mem_cgroup_mark_under_oom(memcg);
> +
> +	*locked = mem_cgroup_oom_trylock(memcg);
> +
> +	if (*locked)
> +		mem_cgroup_oom_notify(memcg);
> +
> +	mem_cgroup_unmark_under_oom(memcg);
> +
> +	return true;
> +}
> +
> +void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked)
> +{
> +	if (locked)
> +		mem_cgroup_oom_unlock(memcg);
> +}
> +
>  static int __init memcg1_init(void)
>  {
>  	int node;
> diff --git a/mm/memcontrol-v1.h b/mm/memcontrol-v1.h
> index ef1b7037cbdc..3de956b2422f 100644
> --- a/mm/memcontrol-v1.h
> +++ b/mm/memcontrol-v1.h
> @@ -87,9 +87,10 @@ enum res_type {
>  bool mem_cgroup_event_ratelimit(struct mem_cgroup *memcg,
>  				enum mem_cgroup_events_target target);
>  unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
> -void mem_cgroup_oom_notify(struct mem_cgroup *memcg);
>  ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  				  char *buf, size_t nbytes, loff_t off);
>  
> +bool memcg1_oom_prepare(struct mem_cgroup *memcg, bool *locked);
> +void memcg1_oom_finish(struct mem_cgroup *memcg, bool locked);
>  
>  #endif	/* __MM_MEMCONTROL_V1_H */
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 92fb72bbd494..8abd364ac837 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1616,130 +1616,6 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	return ret;
>  }
>  
> -#ifdef CONFIG_LOCKDEP
> -static struct lockdep_map memcg_oom_lock_dep_map = {
> -	.name = "memcg_oom_lock",
> -};
> -#endif
> -
> -DEFINE_SPINLOCK(memcg_oom_lock);
> -
> -/*
> - * Check OOM-Killer is already running under our hierarchy.
> - * If someone is running, return false.
> - */
> -static bool mem_cgroup_oom_trylock(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *iter, *failed = NULL;
> -
> -	spin_lock(&memcg_oom_lock);
> -
> -	for_each_mem_cgroup_tree(iter, memcg) {
> -		if (iter->oom_lock) {
> -			/*
> -			 * this subtree of our hierarchy is already locked
> -			 * so we cannot give a lock.
> -			 */
> -			failed = iter;
> -			mem_cgroup_iter_break(memcg, iter);
> -			break;
> -		} else
> -			iter->oom_lock = true;
> -	}
> -
> -	if (failed) {
> -		/*
> -		 * OK, we failed to lock the whole subtree so we have
> -		 * to clean up what we set up to the failing subtree
> -		 */
> -		for_each_mem_cgroup_tree(iter, memcg) {
> -			if (iter == failed) {
> -				mem_cgroup_iter_break(memcg, iter);
> -				break;
> -			}
> -			iter->oom_lock = false;
> -		}
> -	} else
> -		mutex_acquire(&memcg_oom_lock_dep_map, 0, 1, _RET_IP_);
> -
> -	spin_unlock(&memcg_oom_lock);
> -
> -	return !failed;
> -}
> -
> -static void mem_cgroup_oom_unlock(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *iter;
> -
> -	spin_lock(&memcg_oom_lock);
> -	mutex_release(&memcg_oom_lock_dep_map, _RET_IP_);
> -	for_each_mem_cgroup_tree(iter, memcg)
> -		iter->oom_lock = false;
> -	spin_unlock(&memcg_oom_lock);
> -}
> -
> -static void mem_cgroup_mark_under_oom(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *iter;
> -
> -	spin_lock(&memcg_oom_lock);
> -	for_each_mem_cgroup_tree(iter, memcg)
> -		iter->under_oom++;
> -	spin_unlock(&memcg_oom_lock);
> -}
> -
> -static void mem_cgroup_unmark_under_oom(struct mem_cgroup *memcg)
> -{
> -	struct mem_cgroup *iter;
> -
> -	/*
> -	 * Be careful about under_oom underflows because a child memcg
> -	 * could have been added after mem_cgroup_mark_under_oom.
> -	 */
> -	spin_lock(&memcg_oom_lock);
> -	for_each_mem_cgroup_tree(iter, memcg)
> -		if (iter->under_oom > 0)
> -			iter->under_oom--;
> -	spin_unlock(&memcg_oom_lock);
> -}
> -
> -static DECLARE_WAIT_QUEUE_HEAD(memcg_oom_waitq);
> -
> -struct oom_wait_info {
> -	struct mem_cgroup *memcg;
> -	wait_queue_entry_t	wait;
> -};
> -
> -static int memcg_oom_wake_function(wait_queue_entry_t *wait,
> -	unsigned mode, int sync, void *arg)
> -{
> -	struct mem_cgroup *wake_memcg = (struct mem_cgroup *)arg;
> -	struct mem_cgroup *oom_wait_memcg;
> -	struct oom_wait_info *oom_wait_info;
> -
> -	oom_wait_info = container_of(wait, struct oom_wait_info, wait);
> -	oom_wait_memcg = oom_wait_info->memcg;
> -
> -	if (!mem_cgroup_is_descendant(wake_memcg, oom_wait_memcg) &&
> -	    !mem_cgroup_is_descendant(oom_wait_memcg, wake_memcg))
> -		return 0;
> -	return autoremove_wake_function(wait, mode, sync, arg);
> -}
> -
> -void memcg_oom_recover(struct mem_cgroup *memcg)
> -{
> -	/*
> -	 * For the following lockless ->under_oom test, the only required
> -	 * guarantee is that it must see the state asserted by an OOM when
> -	 * this function is called as a result of userland actions
> -	 * triggered by the notification of the OOM.  This is trivially
> -	 * achieved by invoking mem_cgroup_mark_under_oom() before
> -	 * triggering notification.
> -	 */
> -	if (memcg && memcg->under_oom)
> -		__wake_up(&memcg_oom_waitq, TASK_NORMAL, 0, memcg);
> -}
> -
>  /*
>   * Returns true if successfully killed one or more processes. Though in some
>   * corner cases it can return true even without killing any process.
> @@ -1753,104 +1629,16 @@ static bool mem_cgroup_oom(struct mem_cgroup *memcg, gfp_t mask, int order)
>  
>  	memcg_memory_event(memcg, MEMCG_OOM);
>  
> -	/*
> -	 * We are in the middle of the charge context here, so we
> -	 * don't want to block when potentially sitting on a callstack
> -	 * that holds all kinds of filesystem and mm locks.
> -	 *
> -	 * cgroup1 allows disabling the OOM killer and waiting for outside
> -	 * handling until the charge can succeed; remember the context and put
> -	 * the task to sleep at the end of the page fault when all locks are
> -	 * released.
> -	 *
> -	 * On the other hand, in-kernel OOM killer allows for an async victim
> -	 * memory reclaim (oom_reaper) and that means that we are not solely
> -	 * relying on the oom victim to make a forward progress and we can
> -	 * invoke the oom killer here.
> -	 *
> -	 * Please note that mem_cgroup_out_of_memory might fail to find a
> -	 * victim and then we have to bail out from the charge path.
> -	 */
> -	if (READ_ONCE(memcg->oom_kill_disable)) {
> -		if (current->in_user_fault) {
> -			css_get(&memcg->css);
> -			current->memcg_in_oom = memcg;
> -		}
> +	if (!memcg1_oom_prepare(memcg, &locked))
>  		return false;
> -	}
> -
> -	mem_cgroup_mark_under_oom(memcg);
>  
> -	locked = mem_cgroup_oom_trylock(memcg);
> -
> -	if (locked)
> -		mem_cgroup_oom_notify(memcg);
> -
> -	mem_cgroup_unmark_under_oom(memcg);
>  	ret = mem_cgroup_out_of_memory(memcg, mask, order);
>  
> -	if (locked)
> -		mem_cgroup_oom_unlock(memcg);
> +	memcg1_oom_finish(memcg, locked);
>  
>  	return ret;
>  }
>  
> -/**
> - * mem_cgroup_oom_synchronize - complete memcg OOM handling
> - * @handle: actually kill/wait or just clean up the OOM state
> - *
> - * This has to be called at the end of a page fault if the memcg OOM
> - * handler was enabled.
> - *
> - * Memcg supports userspace OOM handling where failed allocations must
> - * sleep on a waitqueue until the userspace task resolves the
> - * situation.  Sleeping directly in the charge context with all kinds
> - * of locks held is not a good idea, instead we remember an OOM state
> - * in the task and mem_cgroup_oom_synchronize() has to be called at
> - * the end of the page fault to complete the OOM handling.
> - *
> - * Returns %true if an ongoing memcg OOM situation was detected and
> - * completed, %false otherwise.
> - */
> -bool mem_cgroup_oom_synchronize(bool handle)
> -{
> -	struct mem_cgroup *memcg = current->memcg_in_oom;
> -	struct oom_wait_info owait;
> -	bool locked;
> -
> -	/* OOM is global, do not handle */
> -	if (!memcg)
> -		return false;
> -
> -	if (!handle)
> -		goto cleanup;
> -
> -	owait.memcg = memcg;
> -	owait.wait.flags = 0;
> -	owait.wait.func = memcg_oom_wake_function;
> -	owait.wait.private = current;
> -	INIT_LIST_HEAD(&owait.wait.entry);
> -
> -	prepare_to_wait(&memcg_oom_waitq, &owait.wait, TASK_KILLABLE);
> -	mem_cgroup_mark_under_oom(memcg);
> -
> -	locked = mem_cgroup_oom_trylock(memcg);
> -
> -	if (locked)
> -		mem_cgroup_oom_notify(memcg);
> -
> -	schedule();
> -	mem_cgroup_unmark_under_oom(memcg);
> -	finish_wait(&memcg_oom_waitq, &owait.wait);
> -
> -	if (locked)
> -		mem_cgroup_oom_unlock(memcg);
> -cleanup:
> -	current->memcg_in_oom = NULL;
> -	css_put(&memcg->css);
> -	return true;
> -}
> -
>  /**
>   * mem_cgroup_get_oom_group - get a memory cgroup to clean up after OOM
>   * @victim: task to be killed by the OOM killer
> -- 
> 2.45.2

-- 
Michal Hocko
SUSE Labs

