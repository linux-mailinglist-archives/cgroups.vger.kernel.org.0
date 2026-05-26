Return-Path: <cgroups+bounces-16295-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDNxHYBZFWp7UgcAu9opvQ
	(envelope-from <cgroups+bounces-16295-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:27:44 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CC75A5D2757
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 10:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6220E3019923
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 08:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAD5A3BAD9F;
	Tue, 26 May 2026 08:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AneQ5dk4"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936383451A7;
	Tue, 26 May 2026 08:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779784059; cv=none; b=lPdKdkIfjIPAEGc+CurREyq8OUvRNgvJDKC3jErviqmihE3mxB7MsIlWKK9GpWoaTXL6xCLiODk3EwMViLlPzs8JvDblPfrFZ7s8US+S3oQJb5CxYmpduVGe3bzAIosYqfbVdwE5pq2Kul9PqYMliAOjaqsRnLotJbrSPnhvuQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779784059; c=relaxed/simple;
	bh=DgmBZfnl50mbPzvprAgrTr4A3hMm2/nN2fbwtqAYjfw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JZdLCDGEYGkpSwFDOLi62F7PzO4H1Q/lLWLNYy31ZGTOZRnE3qWkouT+KkunkvzV8ylNYe+XnCkQeWxw9Goa2Os3ziHver9a5FA7FXlvpqEUqibZAZ2U0AaG/w/KlqnQC78rHnAbvqSHR5Yr0e73ifGEDQFoKV44bw3GJ1YjaX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AneQ5dk4; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779784058; x=1811320058;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=DgmBZfnl50mbPzvprAgrTr4A3hMm2/nN2fbwtqAYjfw=;
  b=AneQ5dk4AmYtLRpWkTsHYUSK2YRqVd1NjyJd984sQUqvD0RSpFJ7zlxu
   DzWqv4HBUUER5yKPYQRqEEaVzPZKNJDM1N7onMjDn2wEro6mAoGSQ2lQR
   FTbZ0kM9QfvxmNUTgf7ToiGwF07pSWaoqKICnSbnIIj1rPYT+aLKFtST8
   cejpcELds9r1tgUDTqXeqQUx47Io/zY5iYnmyjx09hXHElHtN0WL6fmZW
   nhXZS9ycg80tym8RvM/feEGPajGWBkqJWShJM+FqE0ehhlMzLKGeJ6PA9
   cf+PE8nHZXTA8mSnGwbHWMNUCvR46L8aoH5Ai0vCDvx+0IqhY8HcWC+ps
   A==;
X-CSE-ConnectionGUID: D3mQZPKzSmKkKkQKa6Abvg==
X-CSE-MsgGUID: nz28Sg2XQTWJHgr2Pq+qQA==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80576398"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80576398"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 01:27:37 -0700
X-CSE-ConnectionGUID: Aj32FojvT7CqXhOQVCGpLA==
X-CSE-MsgGUID: sL6DyJ2wR3SD/LO5KmujJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="241704662"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.113]) ([10.245.244.113])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 01:27:31 -0700
Message-ID: <9fe89d8e-9c32-4b03-ac2c-a634f5d4de0c@linux.intel.com>
Date: Tue, 26 May 2026 10:27:13 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH v4 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260512082406.44470-1-thomas.hellstrom@linux.intel.com>
 <20260512082406.44470-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20260512082406.44470-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16295-lists,cgroups=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CC75A5D2757
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello,

Den 2026-05-12 kl. 10:24, skrev Thomas Hellström:
> Add an optional reclaim callback to struct dmem_cgroup_region. When
> dmem.max is set below the current usage of a cgroup pool, the new limit
> is applied immediately (so that concurrent allocations are throttled
> while reclaim is in progress) and then the driver is asked to evict
> memory to bring usage back below the limit.
> 
> Reclaim is attempted up to a bounded number of times. No error is
> returned to userspace if usage remains above the limit after reclaim,
> and a pending signal will abort the reclaim loop early. This matches
> the behavior of memory.max in the memory cgroup controller.
> 
> Also honor O_NONBLOCK so that if that flag is set during the
> max value write, no reclaim is initiated. The idea is to avoid
> charging the reclaim cost to the writer of the max value.
> 
> v2:
> - Write max before reclaim is attempted (Maarten)
> - Let signals abort the reclaim without error (Maarten)
> - If a new max value is written with the O_NONBLOCK flag,
>   reclaim is not attempted (Maarten)
> - Extract region from the pool parameter rather than
>   passing it explicitly to set_resource_xxx().
> v3:
> - Use an rwsem to protect reclaim callback registration and
>   region unregister against concurrent reclaim invocations,
>   ensuring reclaim_priv is visible when the callback is
>   invoked. (Sashiko-bot)
> 
> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/linux/cgroup_dmem.h |  24 ++++++++
>  kernel/cgroup/dmem.c        | 106 +++++++++++++++++++++++++++++++++---
>  2 files changed, 121 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index dd4869f1d736..c3bce21cbe80 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -14,6 +14,21 @@ struct dmem_cgroup_pool_state;
>  /* Opaque definition of a cgroup region, used internally */
>  struct dmem_cgroup_region;
>  
> +/**
> + * typedef dmem_cgroup_reclaim_fn_t - Reclaim callback for a dmem cgroup region.
> + * @pool: The cgroup pool that needs memory reclaimed.
> + * @target_bytes: Minimum number of bytes the driver should attempt to free.
> + * @priv: Private data registered with dmem_cgroup_region_set_reclaim().
> + *
> + * Called by the dmem cgroup controller when dmem.max is set below the current
> + * usage of @pool. The driver should evict at least @target_bytes of memory
> + * from @pool. May be called multiple times if usage remains above the limit.
> + *
> + * Return: 0 if progress was made, negative error code otherwise.
> + */
> +typedef int (*dmem_cgroup_reclaim_fn_t)(struct dmem_cgroup_pool_state *pool,
> +					u64 target_bytes, void *priv);
> +
>  #if IS_ENABLED(CONFIG_CGROUP_DMEM)
>  struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *name_fmt, ...) __printf(2,3);
>  void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region);
> @@ -26,6 +41,9 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      bool ignore_low, bool *ret_hit_low);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +				    dmem_cgroup_reclaim_fn_t reclaim,
> +				    void *priv);
>  #else
>  static inline __printf(2,3) struct dmem_cgroup_region *
>  dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> @@ -62,5 +80,11 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> +static inline void
> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +			       dmem_cgroup_reclaim_fn_t reclaim,
> +			       void *priv)
> +{ }
> +
>  #endif
>  #endif	/* _CGROUP_DMEM_H */
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 1ab1fb47f271..5fd5a1634d21 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -51,6 +51,20 @@ struct dmem_cgroup_region {
>  	 * No new pools should be added to the region afterwards.
>  	 */
>  	bool unregistered;
> +
> +	/**
> +	 * @reclaim: Optional callback invoked when dmem.max is set below the
> +	 * current usage of a pool. The driver should attempt to free at least
> +	 * @target_bytes from @pool. May be called multiple times if usage
> +	 * remains above the limit after returning.
> +	 */
> +	dmem_cgroup_reclaim_fn_t reclaim;
> +
> +	/** @reclaim_priv: Private data passed to @reclaim. */
> +	void *reclaim_priv;
> +
> +	/** @unregister_sem: Protect @reclaim while it is running. */
> +	struct rw_semaphore unregister_sem;
>  };
>  
>  struct dmemcg_state {
> @@ -145,21 +159,58 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
>  }
>  
>  static void
> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
>  {
>  	page_counter_set_min(&pool->cnt, val);
>  }
>  
>  static void
> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
>  {
>  	page_counter_set_low(&pool->cnt, val);
>  }
>  
>  static void
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val, bool nonblock)
>  {
> -	page_counter_set_max(&pool->cnt, val);
> +	struct dmem_cgroup_region *region = pool->region;
> +
> +	/*
> +	 * Always update the limit, even if usage currently exceeds it.
> +	 * Concurrent allocations will be throttled against the new limit
> +	 * while reclaim is in progress.
> +	 */
> +	xchg(&pool->cnt.max, (unsigned long)val);
> +
> +	if (nonblock || !READ_ONCE(region->reclaim))
> +		return;
> +
> +	for (int retries = 5; retries > 0; retries--) {
Where does 5 come from? This code should retry until no longer above limit, otherwise you'll get some hard to debug issues.

> +		u64 usage = page_counter_read(&pool->cnt);
> +		int ret;
> +
> +		if (usage <= val)
> +			break;
> +
> +		if (signal_pending(current))
> +			break;
> +
> +		/* Block unregister until the reclaim callback completes. */
> +		if (down_read_interruptible(&region->unregister_sem))
> +			break;
> +
> +		if (!region->reclaim) {
> +			up_read(&region->unregister_sem);
> +			break;
> +		}
> +
> +		ret = region->reclaim(pool, usage - val, region->reclaim_priv);
> +		up_read(&region->unregister_sem);
> +		if (ret)
> +			break;
> +
> +		cond_resched();
> +	}
>  }
>  
>  static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
> @@ -184,9 +235,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
>  
>  static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
>  {
> -	set_resource_min(rpool, 0);
> -	set_resource_low(rpool, 0);
> -	set_resource_max(rpool, PAGE_COUNTER_MAX);
> +	set_resource_min(rpool, 0, false);
> +	set_resource_low(rpool, 0, false);
> +	set_resource_max(rpool, PAGE_COUNTER_MAX, false);
>  }
>  
>  static void dmemcs_offline(struct cgroup_subsys_state *css)
> @@ -491,6 +542,12 @@ void dmem_cgroup_unregister_region(struct dmem_cgroup_region *region)
>  	region->unregistered = true;
>  	spin_unlock(&dmemcg_lock);
>  
> +	/* Ensure all reclaim() callbacks have finished. */
> +	down_write(&region->unregister_sem);
> +	/* Pairs with READ_ONCE() in set_resource_max() */
> +	WRITE_ONCE(region->reclaim, NULL);
> +	up_write(&region->unregister_sem);
> +
>  	kref_put(&region->ref, dmemcg_free_region);
>  }
I've thought about it some more, Can we do the same as dma-buf init?

DEFINE_DMEMCG_REGION_INFO(info);
info.size = size.
info.ops = &drm_ttm_dmem_region_ops;
info.region_priv = ttm_region;
info.device_priv = drm_dev;

dmem_region = dmem_cgroup_register_region(&info);

This way we don't need to have a typedef for function pointers,
no need for READ_ONCE() and/or additional locking, which was only
added because it wasn't set at init.

If we can push the responsibility for serialization against unload
to the driver, we should also be able to use drm_dev_enter/exit here
for the reclaim loop?

Something like below:

if (!ops->device_begin(device_priv, &cookie))
	return 0; // Device gone

while (true) {
	ops->reclaim(region_priv, ...);
}

ops->device_end(device_priv, cookie);

Although we will additionally need to ensure that the region holds a refcount on
reclaim_priv until dmemcg_free_region is called, otherwise this breaks.

So 4 ops needed:
- device_begin
- reclaim
- device_end
- free (called after region refcount drops to 0, called immediately on !CONFIG_DMEMCG, drops device refcount)

Relatedly, I believe perhaps we should also convert from drmm managed to devm managed,
as all memory is already freed after the device is physically detached.

Hopefully this solves all lifetime issues, and this design allows for
additional callbacks into the device or region later on if needed.

Kind regards,
~Maarten Lankhorst

>  EXPORT_SYMBOL_GPL(dmem_cgroup_unregister_region);
> @@ -530,6 +587,7 @@ struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size, const char *fmt
>  	INIT_LIST_HEAD(&ret->pools);
>  	ret->name = region_name;
>  	ret->size = size;
> +	init_rwsem(&ret->unregister_sem);
>  	kref_init(&ret->ref);
>  
>  	spin_lock(&dmemcg_lock);
> @@ -568,6 +626,34 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
>  
> +/**
> + * dmem_cgroup_region_set_reclaim() - Register a reclaim callback on a region.
> + * @region: The region to register the callback for.
> + * @reclaim: Callback to invoke when dmem.max is set below current usage.
> + *           Called with the pool that needs reclaiming and the number of
> + *           bytes to free. Returns 0 on progress, negative on failure.
> + * @priv: Opaque pointer passed back to @reclaim.
> + *
> + * When dmem.max is lowered below the current usage of a cgroup pool, the
> + * dmem controller will call @reclaim with a target number of bytes to free.
> + * After @reclaim returns the controller retries setting the limit; if usage
> + * is still too high it calls @reclaim again, up to a bounded retry count.
> + */
> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +				    dmem_cgroup_reclaim_fn_t reclaim,
> +				    void *priv)
> +{
> +	if (!region)
> +		return;
> +
> +	down_write(&region->unregister_sem);
> +	region->reclaim_priv = priv;
> +	/* Pairs with READ_ONCE() in set_resource_max() */
> +	WRITE_ONCE(region->reclaim, reclaim);
> +	up_write(&region->unregister_sem);
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
> +
>  static struct dmem_cgroup_pool_state *
>  get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>  {
> @@ -725,9 +811,10 @@ static int dmemcg_parse_limit(char *options, u64 *new_limit)
>  
>  static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  				 char *buf, size_t nbytes, loff_t off,
> -				 void (*apply)(struct dmem_cgroup_pool_state *, u64))
> +				 void (*apply)(struct dmem_cgroup_pool_state *, u64, bool))
>  {
>  	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
> +	bool nonblock = of->file->f_flags & O_NONBLOCK;
>  	int err = 0;
>  
>  	while (buf && !err) {
> @@ -772,7 +859,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  		}
>  
>  		/* And commit */
> -		apply(pool, new_limit);
> +		apply(pool, new_limit, nonblock);
> +
>  		dmemcg_pool_put(pool);
>  
>  out_put:


