Return-Path: <cgroups+bounces-15456-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGZ0FYWa6GlNNQIAu9opvQ
	(envelope-from <cgroups+bounces-15456-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:53:09 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7D4444A4
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 11:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1DAAB3048E7C
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A9E39F181;
	Wed, 22 Apr 2026 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Om0Cbmor"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EC9A347BD7;
	Wed, 22 Apr 2026 09:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776851437; cv=none; b=q3MYNMDw6bzlc1AdXtWrpH8tY1ph7T0b6cOShN8/EixA6K8LCBN+oY+Sp9/0rsQ8YcbGj/n0CG49OqrA9AxGm4EYcHhm4nlPnTNRK65CFCPJIMopBJoD+uS00oh5iGwBcKVoMTqKbV1/2t/BLnB6NgWVsBRk6CKjChklvCl7aT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776851437; c=relaxed/simple;
	bh=kcLv6TMheSCYHWv7Tmi77yXjSjjhJ9NvmWDLM99VOjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=soBU5+ti7DIG2/7KvhlkoW/cWZNZE0uOuQw6OoVvdn1qUQsEuIiXywM/HncAgycKsUjfNnYotKq/rRE6OO5hzZc9+Y1JZtMTMktm0M2vpswvo/KPu//asg737q2dk4xB56JQ8kxg5ct2h6Bf8x71Ly+nQrMTxMP9j1P4zaY/CMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Om0Cbmor; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776851437; x=1808387437;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kcLv6TMheSCYHWv7Tmi77yXjSjjhJ9NvmWDLM99VOjo=;
  b=Om0Cbmor4fVHB3C+5rYPT2RBce+D3JzUJu06IvAys5+wlqEcboEzJ9+m
   n1VAFKVv4K8yEQ6tao3Cq6bzsesPAqSeWugfahgLoDpJ+IGqYHi8OqaRz
   kJzH7csFv8GUwkY2qYoY4NsPMUNX8CFE5XtXkede2GQ+K4D9Bf3U4vYxg
   8EUBDus+nM5UZ5y4MB4rhg/g2xbbitqFu9UDNDIwM9/6rJWaWIqChdgne
   o29QSb221mBCRLra3TCzMtvVOUi/tn4RsEwNwjHihuk4QzNM+eeerjyj9
   jciE1e+HWacMAIeQ33blunHwudNQPb22LQDSln3L02fx33cWa7GNQHa1k
   g==;
X-CSE-ConnectionGUID: zx35SpISSlisWFgew3zLKA==
X-CSE-MsgGUID: MzrUB8SuSQ2bTPhSPHtk1w==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="100453990"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="100453990"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:50:36 -0700
X-CSE-ConnectionGUID: vAn15CqpS3uRGieKrfyVdQ==
X-CSE-MsgGUID: RyVHDFWOSHCNX7u0DOWkNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="231419495"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.228]) ([10.245.245.228])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 02:50:31 -0700
Message-ID: <8ecda206-d290-4895-bf57-346419afdc3c@linux.intel.com>
Date: Wed, 22 Apr 2026 11:50:29 +0200
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
 Matthew Auld <matthew.auld@intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Simona Vetter <simona@ffwll.ch>,
 David Airlie <airlied@gmail.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
References: <20260327081600.4885-1-thomas.hellstrom@linux.intel.com>
 <20260327081600.4885-3-thomas.hellstrom@linux.intel.com>
 <4b647952-0038-4878-b67e-6c7fc7ab27a6@linux.intel.com>
 <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <398623a092c65ce4e53d1713112fa39ac0979fd7.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org,igalia.com];
	TAGGED_FROM(0.00)[bounces-15456-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:dkim,intel.com:email,linux.intel.com:mid]
X-Rspamd-Queue-Id: 02A7D4444A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-04-22 kl. 10:42, skrev Thomas Hellström:
> On Wed, 2026-04-22 at 10:31 +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> (Adding Thadeu to cc since they've been working on the same issue)
>>
>> Den 2026-03-27 kl. 09:15, skrev Thomas Hellström:
>>> Add an optional reclaim callback to struct dmem_cgroup_region. 
>>> When
>>> dmem.max is set below current usage, invoke the callback to evict
>>> memory
>>> and retry setting the limit rather than failing immediately. 
>>> Signal
>>> interruptions propagate back to the write() caller.
>>>
>>> RFC:
>>> Due to us updating the max limit _after_ the usage has been
>>> sufficiently lowered, this should be prone to failures if there are
>>> aggressive allocators running in parallel to the reclaim.
>>> So can we somehow enforce the new limit while the eviction is
>>> happening?
>>>
>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> ---
>>>  include/linux/cgroup_dmem.h | 11 +++++
>>>  kernel/cgroup/dmem.c        | 94
>>> +++++++++++++++++++++++++++++++++----
>>>  2 files changed, 96 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/cgroup_dmem.h
>>> b/include/linux/cgroup_dmem.h
>>> index dd4869f1d736..61520a431740 100644
>>> --- a/include/linux/cgroup_dmem.h
>>> +++ b/include/linux/cgroup_dmem.h
>>> @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct
>>> dmem_cgroup_pool_state *limit_pool,
>>>  				      bool ignore_low, bool
>>> *ret_hit_low);
>>>  
>>>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
>>> *pool);
>>> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
>>> *region,
>>> +				    int (*reclaim)(struct
>>> dmem_cgroup_pool_state *pool,
>>> +						   u64
>>> target_bytes, void *priv),
>>> +				    void *priv);
>>>  #else
>>>  static inline __printf(2,3) struct dmem_cgroup_region *
>>>  dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
>>> @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct
>>> dmem_cgroup_pool_state *limit_pool,
>>>  static inline void dmem_cgroup_pool_state_put(struct
>>> dmem_cgroup_pool_state *pool)
>>>  { }
>>>  
>>> +static inline void
>>> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
>>> +			       int (*reclaim)(struct
>>> dmem_cgroup_pool_state *pool,
>>> +					      u64 target_bytes,
>>> void *priv),
>>> +			       void *priv)
>>> +{ }
>>> +
>>>  #endif
>>>  #endif	/* _CGROUP_DMEM_H */
>>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>>> index 3e6d4c0b26a1..f993fb058b74 100644
>>> --- a/kernel/cgroup/dmem.c
>>> +++ b/kernel/cgroup/dmem.c
>>> @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
>>>  	 * No new pools should be added to the region afterwards.
>>>  	 */
>>>  	bool unregistered;
>>> +
>>> +	/**
>>> +	 * @reclaim: Optional callback invoked when dmem.max is
>>> set below the
>>> +	 * current usage of a pool. The driver should attempt to
>>> free at least
>>> +	 * @target_bytes from @pool. May be called multiple times
>>> if usage
>>> +	 * remains above the limit after returning.
>>> +	 */
>>> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool, u64
>>> target_bytes,
>>> +		       void *priv);
>>> +
>>> +	/** @reclaim_priv: Private data passed to @reclaim. */
>>> +	void *reclaim_priv;
>>>  };
>>>  
>>>  struct dmemcg_state {
>>> @@ -145,23 +157,59 @@ static void free_cg_pool(struct
>>> dmem_cgroup_pool_state *pool)
>>>  }
>>>  
>>>  static int
>>> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
>>> +		 struct dmem_cgroup_region *region)
>>>  {
>>>  	page_counter_set_min(&pool->cnt, val);
>>>  	return 0;
>>>  }
>>>  
>>>  static int
>>> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
>>> +		 struct dmem_cgroup_region *region)
>>>  {
>>>  	page_counter_set_low(&pool->cnt, val);
>>>  	return 0;
>>>  }
>>>  
>>>  static int
>>> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
>>> +		 struct dmem_cgroup_region *region)
>>>  {
>>> -	return page_counter_set_max(&pool->cnt, val);
>>> +	int err = page_counter_set_max(&pool->cnt, val);
>>> +
>>> +	if (err != -EBUSY || !region || !region->reclaim)
>>> +		return err;
>>> +
>>> +	/*
>>> +	 * The new max is below current usage.  Ask the driver to
>>> evict memory
>>> +	 * and retry, up to a bounded number of times.  Signal
>>> interruptions are
>>> +	 * propagated back to the write() caller; other reclaim
>>> failures leave
>>> +	 * -EBUSY as the result.
>>> +	 */
>>> +	for (int retries = 5; retries > 0; retries--) {
>>> +		u64 usage = page_counter_read(&pool->cnt);
>>> +		u64 target = usage > val ? usage - val : 0;
>>> +		int reclaim_err;
>>> +
>>> +		if (!target) {
>>> +			err = page_counter_set_max(&pool->cnt,
>>> val);
>>> +			break;
>>> +		}
>>> +
>>> +		reclaim_err = region->reclaim(pool, target,
>>> region->reclaim_priv);
>>> +		if (reclaim_err) {
>>> +			if (reclaim_err == -EINTR || reclaim_err
>>> == -ERESTARTSYS)
>>> +				err = reclaim_err;
>>> +			break;
>>> +		}
>>> +
>>> +		err = page_counter_set_max(&pool->cnt, val);
>>> +		if (err != -EBUSY)
>>> +			break;
>>> +	}
>>> +
>>> +	return err;
>>>  }
>>
>> I mentioned this in chat but I wanted to mention it on the mailing
>> list for others as well,
>> can we reproduce the behavior from memory_max_write() in
>> mm/memcontrol.c?
>>
>> 1. First set new limit through xchg.
>> 2. If O_NONBLOCK is set -> do nothing, next allocation in target
>> region will fail and cause reclaim.
>> 3. If not set -> reclaim until below new limit or interrupted by a
>> signal, return success in all cases here since we set new limit.
>>
>>
> 
> Yup.
> 
> For 3, we also need to consider the case where we fail to reclaim due
> to memory being pinned. If it's OK to (usually temporary) have current
> usage above max, that would work.
> 
> I have that coded up and also add a patch on top to defer reclaim to a
> thread if we bail due to signal or O_NONBLOCK. Perhaps we could discuss
> whether that's a good or bad idea in that patch.

That doesn't sound like a good idea. The semantics of O_NONBLOCK
are deliberately intended to be able to change the max without causing
reclaim.

See the details in commit ("memcg: introduce non-blocking limit setting option")

I also believe it's ok not to continue reclaiming if aborted, the caller can
always try again if necessary.

If we want to deviate from the memcg controller, we need a very good reason
to do so. I'd like to keep the semantics the same if possible.

> Will send out when I've updated the IGT tests accordingly.
> 
> Thanks,
> Thomas

Kind regards,
~Maarten Lankhorst

