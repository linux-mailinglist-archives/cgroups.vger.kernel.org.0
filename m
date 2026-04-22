Return-Path: <cgroups+bounces-15458-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGJ0Nnqj6GkaOQIAu9opvQ
	(envelope-from <cgroups+bounces-15458-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 12:31:22 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C77A444B96
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 12:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEEB1300DF53
	for <lists+cgroups@lfdr.de>; Wed, 22 Apr 2026 10:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577CE3C3456;
	Wed, 22 Apr 2026 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="frNPfyXR"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A215C33B95E;
	Wed, 22 Apr 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776853784; cv=none; b=bgarRTayXZof0FMvHH4YhMIFgnJCXMHHDQm/pHg160/KfReAItA3yOR4m0o4LnTkCnGZgLOleXTeTEn9LOT7ENlGErWjIAh2x4Ve8Zl6I4ozUu827pA/Am5qood216DTa8u9F/yfc8W07HO/L7zPFhVwbnX2VamAS5BTp18YZ68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776853784; c=relaxed/simple;
	bh=auy2u+Gs2Ji/Jlwrh4HD3XtXCLmifnNNlGdQJLIyD14=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSecwTygyVwCzWGMDgzd7XCJDm/+8tqB2upir3aU32wSVU6H+W2M79JtBitrIZE20qcESBF3Xjnn5JYxdY2eT1hfD2ca5/Y7nrSMlqwBaP9eEbr8dwiDe3/kB2kLpQrf1B6RuEnqMl7Z9vHsDG6siia7CPE6AWJPq3v0Qkeq80Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=frNPfyXR; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776853782; x=1808389782;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=auy2u+Gs2Ji/Jlwrh4HD3XtXCLmifnNNlGdQJLIyD14=;
  b=frNPfyXRM3bm6Lw+4gRN14t84PN7qKw66GlufI12T5ic6+bEBTx6Xa96
   dWn/Xir27VGqrQ0yvFsr7YWgwYW24UfR9Vq6ga69UYh7O1sc+4OAZAGnm
   npKUH0758Kjw092xC102qFzXtjxsHwPMvZ/eedMFaDeNpyvOZ2Anw0fP9
   Ca726Bmbeq9WHV5JFAwnC8CmylY27jIJBEQmt69ef1pGj8yKhhS6nkMmj
   oZ3vd8qVCJGUcI1D+Un32N19JUtFg6GNYFENHgUDbL6ltfCe90XprzM81
   wvlQIt7vuHy8OsJBOqQltNJSGIFjAVG7WlZwuFaBJmSwMD1WSYFmbQFVt
   g==;
X-CSE-ConnectionGUID: 0COz+4AMQfClSl8xdQyImQ==
X-CSE-MsgGUID: tuq1pystSo2zvQuDf0Esbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11763"; a="77678457"
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="77678457"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 03:29:42 -0700
X-CSE-ConnectionGUID: lWq4nYq7SIynvDYM3mko8w==
X-CSE-MsgGUID: HMiHusvQQf+tZ7IBNWRcdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,192,1770624000"; 
   d="scan'208";a="232184948"
Received: from amilburn-desk.amilburn-desk (HELO [10.245.245.228]) ([10.245.245.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2026 03:29:38 -0700
Message-ID: <4f74cacc-ff98-426f-ac31-c25e6cbec314@linux.intel.com>
Date: Wed, 22 Apr 2026 12:29:35 +0200
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
 <8ecda206-d290-4895-bf57-346419afdc3c@linux.intel.com>
 <3b662522e17e380953d9b981d8c2febecf42455e.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <3b662522e17e380953d9b981d8c2febecf42455e.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org,igalia.com];
	TAGGED_FROM(0.00)[bounces-15458-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.intel.com:mid]
X-Rspamd-Queue-Id: 4C77A444B96
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hey,

Den 2026-04-22 kl. 12:20, skrev Thomas Hellström:
> On Wed, 2026-04-22 at 11:50 +0200, Maarten Lankhorst wrote:
>> Hey,
>>
>> Den 2026-04-22 kl. 10:42, skrev Thomas Hellström:
>>> On Wed, 2026-04-22 at 10:31 +0200, Maarten Lankhorst wrote:
>>>> Hey,
>>>>
>>>> (Adding Thadeu to cc since they've been working on the same
>>>> issue)
>>>>
>>>> Den 2026-03-27 kl. 09:15, skrev Thomas Hellström:
>>>>> Add an optional reclaim callback to struct dmem_cgroup_region. 
>>>>> When
>>>>> dmem.max is set below current usage, invoke the callback to
>>>>> evict
>>>>> memory
>>>>> and retry setting the limit rather than failing immediately. 
>>>>> Signal
>>>>> interruptions propagate back to the write() caller.
>>>>>
>>>>> RFC:
>>>>> Due to us updating the max limit _after_ the usage has been
>>>>> sufficiently lowered, this should be prone to failures if there
>>>>> are
>>>>> aggressive allocators running in parallel to the reclaim.
>>>>> So can we somehow enforce the new limit while the eviction is
>>>>> happening?
>>>>>
>>>>> Assisted-by: GitHub Copilot:claude-sonnet-4.6
>>>>> Signed-off-by: Thomas Hellström
>>>>> <thomas.hellstrom@linux.intel.com>
>>>>> ---
>>>>>  include/linux/cgroup_dmem.h | 11 +++++
>>>>>  kernel/cgroup/dmem.c        | 94
>>>>> +++++++++++++++++++++++++++++++++----
>>>>>  2 files changed, 96 insertions(+), 9 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/cgroup_dmem.h
>>>>> b/include/linux/cgroup_dmem.h
>>>>> index dd4869f1d736..61520a431740 100644
>>>>> --- a/include/linux/cgroup_dmem.h
>>>>> +++ b/include/linux/cgroup_dmem.h
>>>>> @@ -26,6 +26,10 @@ bool dmem_cgroup_state_evict_valuable(struct
>>>>> dmem_cgroup_pool_state *limit_pool,
>>>>>  				      bool ignore_low, bool
>>>>> *ret_hit_low);
>>>>>  
>>>>>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
>>>>> *pool);
>>>>> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
>>>>> *region,
>>>>> +				    int (*reclaim)(struct
>>>>> dmem_cgroup_pool_state *pool,
>>>>> +						   u64
>>>>> target_bytes, void *priv),
>>>>> +				    void *priv);
>>>>>  #else
>>>>>  static inline __printf(2,3) struct dmem_cgroup_region *
>>>>>  dmem_cgroup_register_region(u64 size, const char *name_fmt,
>>>>> ...)
>>>>> @@ -62,5 +66,12 @@ bool dmem_cgroup_state_evict_valuable(struct
>>>>> dmem_cgroup_pool_state *limit_pool,
>>>>>  static inline void dmem_cgroup_pool_state_put(struct
>>>>> dmem_cgroup_pool_state *pool)
>>>>>  { }
>>>>>  
>>>>> +static inline void
>>>>> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
>>>>> *region,
>>>>> +			       int (*reclaim)(struct
>>>>> dmem_cgroup_pool_state *pool,
>>>>> +					      u64
>>>>> target_bytes,
>>>>> void *priv),
>>>>> +			       void *priv)
>>>>> +{ }
>>>>> +
>>>>>  #endif
>>>>>  #endif	/* _CGROUP_DMEM_H */
>>>>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>>>>> index 3e6d4c0b26a1..f993fb058b74 100644
>>>>> --- a/kernel/cgroup/dmem.c
>>>>> +++ b/kernel/cgroup/dmem.c
>>>>> @@ -51,6 +51,18 @@ struct dmem_cgroup_region {
>>>>>  	 * No new pools should be added to the region
>>>>> afterwards.
>>>>>  	 */
>>>>>  	bool unregistered;
>>>>> +
>>>>> +	/**
>>>>> +	 * @reclaim: Optional callback invoked when dmem.max
>>>>> is
>>>>> set below the
>>>>> +	 * current usage of a pool. The driver should attempt
>>>>> to
>>>>> free at least
>>>>> +	 * @target_bytes from @pool. May be called multiple
>>>>> times
>>>>> if usage
>>>>> +	 * remains above the limit after returning.
>>>>> +	 */
>>>>> +	int (*reclaim)(struct dmem_cgroup_pool_state *pool,
>>>>> u64
>>>>> target_bytes,
>>>>> +		       void *priv);
>>>>> +
>>>>> +	/** @reclaim_priv: Private data passed to @reclaim. */
>>>>> +	void *reclaim_priv;
>>>>>  };
>>>>>  
>>>>>  struct dmemcg_state {
>>>>> @@ -145,23 +157,59 @@ static void free_cg_pool(struct
>>>>> dmem_cgroup_pool_state *pool)
>>>>>  }
>>>>>  
>>>>>  static int
>>>>> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
>>>>> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
>>>>> +		 struct dmem_cgroup_region *region)
>>>>>  {
>>>>>  	page_counter_set_min(&pool->cnt, val);
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>>  static int
>>>>> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>>>>> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
>>>>> +		 struct dmem_cgroup_region *region)
>>>>>  {
>>>>>  	page_counter_set_low(&pool->cnt, val);
>>>>>  	return 0;
>>>>>  }
>>>>>  
>>>>>  static int
>>>>> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>>>>> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
>>>>> +		 struct dmem_cgroup_region *region)
>>>>>  {
>>>>> -	return page_counter_set_max(&pool->cnt, val);
>>>>> +	int err = page_counter_set_max(&pool->cnt, val);
>>>>> +
>>>>> +	if (err != -EBUSY || !region || !region->reclaim)
>>>>> +		return err;
>>>>> +
>>>>> +	/*
>>>>> +	 * The new max is below current usage.  Ask the driver
>>>>> to
>>>>> evict memory
>>>>> +	 * and retry, up to a bounded number of times.  Signal
>>>>> interruptions are
>>>>> +	 * propagated back to the write() caller; other
>>>>> reclaim
>>>>> failures leave
>>>>> +	 * -EBUSY as the result.
>>>>> +	 */
>>>>> +	for (int retries = 5; retries > 0; retries--) {
>>>>> +		u64 usage = page_counter_read(&pool->cnt);
>>>>> +		u64 target = usage > val ? usage - val : 0;
>>>>> +		int reclaim_err;
>>>>> +
>>>>> +		if (!target) {
>>>>> +			err = page_counter_set_max(&pool->cnt,
>>>>> val);
>>>>> +			break;
>>>>> +		}
>>>>> +
>>>>> +		reclaim_err = region->reclaim(pool, target,
>>>>> region->reclaim_priv);
>>>>> +		if (reclaim_err) {
>>>>> +			if (reclaim_err == -EINTR ||
>>>>> reclaim_err
>>>>> == -ERESTARTSYS)
>>>>> +				err = reclaim_err;
>>>>> +			break;
>>>>> +		}
>>>>> +
>>>>> +		err = page_counter_set_max(&pool->cnt, val);
>>>>> +		if (err != -EBUSY)
>>>>> +			break;
>>>>> +	}
>>>>> +
>>>>> +	return err;
>>>>>  }
>>>>
>>>> I mentioned this in chat but I wanted to mention it on the
>>>> mailing
>>>> list for others as well,
>>>> can we reproduce the behavior from memory_max_write() in
>>>> mm/memcontrol.c?
>>>>
>>>> 1. First set new limit through xchg.
>>>> 2. If O_NONBLOCK is set -> do nothing, next allocation in target
>>>> region will fail and cause reclaim.
>>>> 3. If not set -> reclaim until below new limit or interrupted by
>>>> a
>>>> signal, return success in all cases here since we set new limit.
>>>>
>>>>
>>>
>>> Yup.
>>>
>>> For 3, we also need to consider the case where we fail to reclaim
>>> due
>>> to memory being pinned. If it's OK to (usually temporary) have
>>> current
>>> usage above max, that would work.
>>>
>>> I have that coded up and also add a patch on top to defer reclaim
>>> to a
>>> thread if we bail due to signal or O_NONBLOCK. Perhaps we could
>>> discuss
>>> whether that's a good or bad idea in that patch.
>>
>> That doesn't sound like a good idea. The semantics of O_NONBLOCK
>> are deliberately intended to be able to change the max without
>> causing
>> reclaim.
>>
>> See the details in commit ("memcg: introduce non-blocking limit
>> setting option")
> 
> From reading the docs that introduces, it sounds more like that avoids
> *synchronous* reclaim, which is also in line with O_NONBLOCK semantics.
> 
> The analogy with launching a thread would be more that of kswapd doing
> the reclaim in the memcg case?
> 
> But OTOH, if we were to introduce a thread-driven dmem reclaim that
> would perhaps be something that wasn't directly tied to the dmem
> controller but rather to the dmem provider itself. (TTM in this case).

From the docs:
+        If memory.max is opened with O_NONBLOCK, then the synchronous
+        reclaim and oom-kill are bypassed. This is useful for admin
+        processes that need to dynamically adjust the job's memory limits
+        without expending their own CPU resources on memory reclamation.
+        The job will trigger the reclaim and/or oom-kill on its next
+        charge request.

The task writing to max will not trigger a reclaim,
only set the new max value.

But when a process, part of the affected cgroup, tries to allocate memory,
it will be forced to reclaim memory until below max again. 

This is a workflow where instead of the updater doing all
the evictions, the evictions handled by a process in the cgroup itself.

>>
>> I also believe it's ok not to continue reclaiming if aborted, the
>> caller can
>> always try again if necessary.
>>
>> If we want to deviate from the memcg controller, we need a very good
>> reason
>> to do so. I'd like to keep the semantics the same if possible.
>>
>>> Will send out when I've updated the IGT tests accordingly.
>>>
>>> Thanks,
>>> Thomas
>>
>> Kind regards,
>> ~Maarten Lankhorst


