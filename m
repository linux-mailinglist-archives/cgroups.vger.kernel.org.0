Return-Path: <cgroups+bounces-15509-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACAkB3xi7Gm/YAAAu9opvQ
	(envelope-from <cgroups+bounces-15509-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 08:43:08 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47837465322
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 08:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C675B300EF4E
	for <lists+cgroups@lfdr.de>; Sat, 25 Apr 2026 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A252DAFDE;
	Sat, 25 Apr 2026 06:42:52 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130862D879E;
	Sat, 25 Apr 2026 06:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777099371; cv=none; b=LT0+2oRmbhHYr7PjiahKtgBovhW7hzmRmOCDcE8dMrcQqvQ0xX6UJEtvd6vMzHiKgb/WMGgt9JyvEvWryakGvQYhNFIDtk0hSboI/xoyO93esL1oruCuNQUEud3SP4QanypNoKF29YD2+mcjerazdjb8iZ77BlrDnlWKKqqtgu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777099371; c=relaxed/simple;
	bh=2kgocpl43v3B4U78Y6tW9J5mzvEfoEuXvs4KYHjTAQs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y87hxkvltYLrC5mzQ2qTt4xO708Arejjcsfeb1/4IwnHCLXwHDMpyg3ZRuPIBH8pcbkKLnjlpgX1x1ttfUM+8OrRRi4BnOILsonw+acSpagYEXzRjr6sZRlA9IUh0uLKzc7xFG2YJmXOTgVkTjkLtUkb94DcmvgOiNezZEzkHwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g2gHC21WPzKHMXJ;
	Sat, 25 Apr 2026 14:42:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5961A4058D;
	Sat, 25 Apr 2026 14:42:40 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP4 (Coremail) with SMTP id gCh0CgA3HrxeYuxpzYCiBg--.33183S2;
	Sat, 25 Apr 2026 14:42:40 +0800 (CST)
Message-ID: <220aadd9-0d92-44ce-8a70-bd30030defa9@huaweicloud.com>
Date: Sat, 25 Apr 2026 14:42:38 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] cgroup/dmem: Add reclaim callback for lowering max
 below current usage
To: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 intel-xe@lists.freedesktop.org
Cc: Natalie Vock <natalie.vock@gmx.de>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, cgroups@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, David Airlie <airlied@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3HrxeYuxpzYCiBg--.33183S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Jr4kKr4xGFWxCr47Ar1DKFg_yoW3XrykpF
	ZrCr13Kw4rXrW7Zrsay3W8uF93u3Wvgr45W34xGw4fuFsrJw1Yyr4qk3yYyF1UCF9rGr1f
	Xan0krnruFWjyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUIa
	0PDUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/
X-Rspamd-Queue-Id: 47837465322
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,linux.intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-15509-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[huaweicloud.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenridong@huaweicloud.com,cgroups@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]



On 2026/3/27 16:15, Thomas Hellström wrote:
> Add an optional reclaim callback to struct dmem_cgroup_region.  When
> dmem.max is set below current usage, invoke the callback to evict memory
> and retry setting the limit rather than failing immediately.  Signal
> interruptions propagate back to the write() caller.
> 
> RFC:
> Due to us updating the max limit _after_ the usage has been
> sufficiently lowered, this should be prone to failures if there are
> aggressive allocators running in parallel to the reclaim.
> So can we somehow enforce the new limit while the eviction is
> happening?
> 
> Assisted-by: GitHub Copilot:claude-sonnet-4.6
> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> ---
>  include/linux/cgroup_dmem.h | 11 +++++
>  kernel/cgroup/dmem.c        | 94 +++++++++++++++++++++++++++++++++----
>  2 files changed, 96 insertions(+), 9 deletions(-)
> 
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index dd4869f1d736..61520a431740 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      bool ignore_low, bool *ret_hit_low);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +						   u64 target_bytes, void *priv),
> +				    void *priv);
>  #else
>  static inline __printf(2,3) struct dmem_cgroup_region *
>  dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
> @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> +static inline void
> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
> +			       int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +					      u64 target_bytes, void *priv),
> +			       void *priv)
> +{ }
> +
>  #endif
>  #endif	/* _CGROUP_DMEM_H */
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 3e6d4c0b26a1..f993fb058b74 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
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
> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64 target_bytes,
> +		       void *priv);
> +
> +	/** @reclaim_priv: Private data passed to @reclaim. */
> +	void *reclaim_priv;
>  };
>  
>  struct dmemcg_state {
> @@ -145,23 +157,59 @@ static void free_cg_pool(struct dmem_cgroup_pool_state *pool)
>  }
>  
>  static int
> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
> +		 struct dmem_cgroup_region *region)
>  {
>  	page_counter_set_min(&pool->cnt, val);
>  	return 0;
>  }
>  
>  static int
> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
> +		 struct dmem_cgroup_region *region)
>  {
>  	page_counter_set_low(&pool->cnt, val);
>  	return 0;
>  }
>  
>  static int
> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,

Though we are discussing how to set the maximum, renaming 'val' to 'max' would
improve readability in the next version.

> +		 struct dmem_cgroup_region *region)
>  {
> -	return page_counter_set_max(&pool->cnt, val);
> +	int err = page_counter_set_max(&pool->cnt, val);
> +
> +	if (err != -EBUSY || !region || !region->reclaim)
> +		return err;
> +
> +	/*
> +	 * The new max is below current usage.  Ask the driver to evict memory
> +	 * and retry, up to a bounded number of times.  Signal interruptions are
> +	 * propagated back to the write() caller; other reclaim failures leave
> +	 * -EBUSY as the result.
> +	 */
> +	for (int retries = 5; retries > 0; retries--) {
> +		u64 usage = page_counter_read(&pool->cnt);
> +		u64 target = usage > val ? usage - val : 0;
> +		int reclaim_err;
> +
> +		if (!target) {
> +			err = page_counter_set_max(&pool->cnt, val);
> +			break;
> +		}
> +
> +		reclaim_err = region->reclaim(pool, target, region->reclaim_priv);
> +		if (reclaim_err) {
> +			if (reclaim_err == -EINTR || reclaim_err == -ERESTARTSYS)
> +				err = reclaim_err;
> +			break;
> +		}
> +
> +		err = page_counter_set_max(&pool->cnt, val);
> +		if (err != -EBUSY)
> +			break;
> +	}
> +
> +	return err;
>  }
>  
>  static u64 get_resource_low(struct dmem_cgroup_pool_state *pool)
> @@ -186,9 +234,9 @@ static u64 get_resource_current(struct dmem_cgroup_pool_state *pool)
>  
>  static void reset_all_resource_limits(struct dmem_cgroup_pool_state *rpool)
>  {
> -	set_resource_min(rpool, 0);
> -	set_resource_low(rpool, 0);
> -	set_resource_max(rpool, PAGE_COUNTER_MAX);
> +	set_resource_min(rpool, 0, NULL);
> +	set_resource_low(rpool, 0, NULL);
> +	set_resource_max(rpool, PAGE_COUNTER_MAX, NULL);
>  }
>  
>  static void dmemcs_offline(struct cgroup_subsys_state *css)
> @@ -570,6 +618,32 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
>  
> +/**
> + * dmem_cgroup_region_set_reclaim - Register a reclaim callback on a region.
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
> +				    int (*reclaim)(struct dmem_cgroup_pool_state *pool,
> +						   u64 target_bytes, void *priv),
> +				    void *priv)
> +{
> +	if (!region)
> +		return;
> +
> +	region->reclaim = reclaim;
> +	region->reclaim_priv = priv;
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_region_set_reclaim);
> +
>  static struct dmem_cgroup_pool_state *
>  get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>  {
> @@ -728,7 +802,8 @@ static int dmemcg_parse_limit(char *options, struct dmem_cgroup_region *region,
>  
>  static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  				 char *buf, size_t nbytes, loff_t off,
> -				 int (*apply)(struct dmem_cgroup_pool_state *, u64))
> +				 int (*apply)(struct dmem_cgroup_pool_state *, u64,
> +					      struct dmem_cgroup_region *))
>  {
>  	struct dmemcg_state *dmemcs = css_to_dmemcs(of_css(of));
>  	int err = 0;
> @@ -775,7 +850,8 @@ static ssize_t dmemcg_limit_write(struct kernfs_open_file *of,
>  		}
>  
>  		/* And commit */
> -		err = apply(pool, new_limit);
> +		err = apply(pool, new_limit, region);
> +
>  		dmemcg_pool_put(pool);
>  
>  out_put:

-- 
Best regards,
Ridong


