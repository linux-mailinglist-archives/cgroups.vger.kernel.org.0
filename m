Return-Path: <cgroups+bounces-16302-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDgfBKNtFWojVAcAu9opvQ
	(envelope-from <cgroups+bounces-16302-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:53:39 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C345D3BCC
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 11:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74BBE300E3C9
	for <lists+cgroups@lfdr.de>; Tue, 26 May 2026 09:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933893D8101;
	Tue, 26 May 2026 09:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgYPxeoC"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF3B3CA4AF;
	Tue, 26 May 2026 09:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779789214; cv=none; b=iqE3CMiUNbLf3s4AfJsgYr7Maw0chQWB1i1pEiION+7IV2jhVWeHeuEu6Urktgko/Eg9al824wJGUxolXOaGXb9Xci1e+RGjC1fK8Pi3zBlWkFh2FmeQWEf8t8L0YdA1/GtreBZjM1Syji0rIsRf2DMJmKMkulO5CiuLiycwKo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779789214; c=relaxed/simple;
	bh=qxLdqer/T0R+tLdMT9Bc8YIVDWwE0imaVhQoE14GOrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mDnWiOTsW1gG3gjIwa1o2PAzXsH5b2jENDcykuPM4SLyJITBOyLWe8pcHnaTBB0feHs5nxJ7UKzhgO6zSp5rF/DGGHUDpYG8atLAg3jWBXjUDwXXHD2LMVw+29V0Gkh9i13SzBiP3NjCqcIv8YxyTZmBhjugJbnCHjz0F/y6JTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgYPxeoC; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779789213; x=1811325213;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qxLdqer/T0R+tLdMT9Bc8YIVDWwE0imaVhQoE14GOrg=;
  b=mgYPxeoCBoxGybLLf62Z7NZByrTM2oYzde1fITdemTpIrq+VIEtMsw5l
   dNiSw6DJqh6OpTuLOZveIiG/RbDRxiNAidlMlMtqxfgWBtI+ToHp+X6nr
   lh7MW4Xi8OVYRdwvZlrNFm4eDZNfPfVTQS3SYPeQWJNbm5KRUiSyhJ4/d
   L9xfjOVZXAOhNs3qj/aE4ahrY3r3Vjc4zBlu7rEzfG2Rd0HFEDNRlTvia
   Uo1jMhOHG1t33b4ktv9ftm19U90dqc31kWzJQh6G98JROL4uCJx1pyBMU
   Bd4N59nd9RMvVuIgB2I687oe49jIVBGYeZsIgn4MKukI/n9+9tR7gd2Gj
   Q==;
X-CSE-ConnectionGUID: FjAsXh2VQJC1BkixBNhYXA==
X-CSE-MsgGUID: 7NHNjQhuSq6rbrXDx93rgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80582599"
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="80582599"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:53:32 -0700
X-CSE-ConnectionGUID: HYvTEH+lTHe2WjJdmJJN5A==
X-CSE-MsgGUID: FInZMyFcQtGmCJKIM0Fz4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,169,1774335600"; 
   d="scan'208";a="246141873"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO [10.245.244.113]) ([10.245.244.113])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 02:53:26 -0700
Message-ID: <09a61032-2ebf-4767-93f9-92a2c2a62e46@linux.intel.com>
Date: Tue, 26 May 2026 11:53:23 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
 <9fe89d8e-9c32-4b03-ac2c-a634f5d4de0c@linux.intel.com>
 <b797a2aaa1bcef239a2eba449043dd278b9fa51a.camel@linux.intel.com>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <b797a2aaa1bcef239a2eba449043dd278b9fa51a.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmx.de,cmpxchg.org,kernel.org,suse.com,vger.kernel.org,amd.com,intel.com,suse.de,ffwll.ch,gmail.com,lists.freedesktop.org];
	TAGGED_FROM(0.00)[bounces-16302-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:email,intel.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 75C345D3BCC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Thomas,

Den 2026-05-26 kl. 11:24, skrev Thomas Hellström:
> Hi, Maarten,
> 
> Thanks for reviewing.
> 
> On Tue, 2026-05-26 at 10:27 +0200, Maarten Lankhorst wrote:
>> Hello,
>>
>> Den 2026-05-12 kl. 10:24, skrev Thomas Hellström:
>>> Add an optional reclaim callback to struct dmem_cgroup_region. When
>>> dmem.max is set below the current usage of a cgroup pool, the new
>>> limit
>>> is applied immediately (so that concurrent allocations are
>>> throttled
>>> while reclaim is in progress) and then the driver is asked to evict
>>> memory to bring usage back below the limit.
>>>
>>> Reclaim is attempted up to a bounded number of times. No error is
>>> returned to userspace if usage remains above the limit after
>>> reclaim,
>>> and a pending signal will abort the reclaim loop early. This
>>> matches
>>> the behavior of memory.max in the memory cgroup controller.
>>>
>>> Also honor O_NONBLOCK so that if that flag is set during the
>>> max value write, no reclaim is initiated. The idea is to avoid
>>> charging the reclaim cost to the writer of the max value.
>>>
>>> v2:
>>> - Write max before reclaim is attempted (Maarten)
>>> - Let signals abort the reclaim without error (Maarten)
>>> - If a new max value is written with the O_NONBLOCK flag,
>>>   reclaim is not attempted (Maarten)
>>> - Extract region from the pool parameter rather than
>>>   passing it explicitly to set_resource_xxx().
>>> v3:
>>> - Use an rwsem to protect reclaim callback registration and
>>>   region unregister against concurrent reclaim invocations,
>>>   ensuring reclaim_priv is visible when the callback is
>>>   invoked. (Sashiko-bot)
>>>
>>> Assisted-by: GitHub_Copilot:claude-sonnet-4.6
>>> Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>>> ---
>>>  include/linux/cgroup_dmem.h |  24 ++++++++
>>>  kernel/cgroup/dmem.c        | 106
>>> +++++++++++++++++++++++++++++++++---
>>>  2 files changed, 121 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/include/linux/cgroup_dmem.h
>>> b/include/linux/cgroup_dmem.h
>>> index dd4869f1d736..c3bce21cbe80 100644
>>> --- a/include/linux/cgroup_dmem.h
>>> +++ b/include/linux/cgroup_dmem.h
>>> @@ -14,6 +14,21 @@ struct dmem_cgroup_pool_state;
>>>  /* Opaque definition of a cgroup region, used internally */
>>>  struct dmem_cgroup_region;
>>>  
>>> +/**
>>> + * typedef dmem_cgroup_reclaim_fn_t - Reclaim callback for a dmem
>>> cgroup region.
>>> + * @pool: The cgroup pool that needs memory reclaimed.
>>> + * @target_bytes: Minimum number of bytes the driver should
>>> attempt to free.
>>> + * @priv: Private data registered with
>>> dmem_cgroup_region_set_reclaim().
>>> + *
>>> + * Called by the dmem cgroup controller when dmem.max is set below
>>> the current
>>> + * usage of @pool. The driver should evict at least @target_bytes
>>> of memory
>>> + * from @pool. May be called multiple times if usage remains above
>>> the limit.
>>> + *
>>> + * Return: 0 if progress was made, negative error code otherwise.
>>> + */
>>> +typedef int (*dmem_cgroup_reclaim_fn_t)(struct
>>> dmem_cgroup_pool_state *pool,
>>> +					u64 target_bytes, void
>>> *priv);
>>> +
>>>  #if IS_ENABLED(CONFIG_CGROUP_DMEM)
>>>  struct dmem_cgroup_region *dmem_cgroup_register_region(u64 size,
>>> const char *name_fmt, ...) __printf(2,3);
>>>  void dmem_cgroup_unregister_region(struct dmem_cgroup_region
>>> *region);
>>> @@ -26,6 +41,9 @@ bool dmem_cgroup_state_evict_valuable(struct
>>> dmem_cgroup_pool_state *limit_pool,
>>>  				      bool ignore_low, bool
>>> *ret_hit_low);
>>>  
>>>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state
>>> *pool);
>>> +void dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region
>>> *region,
>>> +				    dmem_cgroup_reclaim_fn_t
>>> reclaim,
>>> +				    void *priv);
>>>  #else
>>>  static inline __printf(2,3) struct dmem_cgroup_region *
>>>  dmem_cgroup_register_region(u64 size, const char *name_fmt, ...)
>>> @@ -62,5 +80,11 @@ bool dmem_cgroup_state_evict_valuable(struct
>>> dmem_cgroup_pool_state *limit_pool,
>>>  static inline void dmem_cgroup_pool_state_put(struct
>>> dmem_cgroup_pool_state *pool)
>>>  { }
>>>  
>>> +static inline void
>>> +dmem_cgroup_region_set_reclaim(struct dmem_cgroup_region *region,
>>> +			       dmem_cgroup_reclaim_fn_t reclaim,
>>> +			       void *priv)
>>> +{ }
>>> +
>>>  #endif
>>>  #endif	/* _CGROUP_DMEM_H */
>>> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
>>> index 1ab1fb47f271..5fd5a1634d21 100644
>>> --- a/kernel/cgroup/dmem.c
>>> +++ b/kernel/cgroup/dmem.c
>>> @@ -51,6 +51,20 @@ struct dmem_cgroup_region {
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
>>> +	dmem_cgroup_reclaim_fn_t reclaim;
>>> +
>>> +	/** @reclaim_priv: Private data passed to @reclaim. */
>>> +	void *reclaim_priv;
>>> +
>>> +	/** @unregister_sem: Protect @reclaim while it is running.
>>> */
>>> +	struct rw_semaphore unregister_sem;
>>>  };
>>>  
>>>  struct dmemcg_state {
>>> @@ -145,21 +159,58 @@ static void free_cg_pool(struct
>>> dmem_cgroup_pool_state *pool)
>>>  }
>>>  
>>>  static void
>>> -set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_min(struct dmem_cgroup_pool_state *pool, u64 val,
>>> bool nonblock)
>>>  {
>>>  	page_counter_set_min(&pool->cnt, val);
>>>  }
>>>  
>>>  static void
>>> -set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_low(struct dmem_cgroup_pool_state *pool, u64 val,
>>> bool nonblock)
>>>  {
>>>  	page_counter_set_low(&pool->cnt, val);
>>>  }
>>>  
>>>  static void
>>> -set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val)
>>> +set_resource_max(struct dmem_cgroup_pool_state *pool, u64 val,
>>> bool nonblock)
>>>  {
>>> -	page_counter_set_max(&pool->cnt, val);
>>> +	struct dmem_cgroup_region *region = pool->region;
>>> +
>>> +	/*
>>> +	 * Always update the limit, even if usage currently
>>> exceeds it.
>>> +	 * Concurrent allocations will be throttled against the
>>> new limit
>>> +	 * while reclaim is in progress.
>>> +	 */
>>> +	xchg(&pool->cnt.max, (unsigned long)val);
>>> +
>>> +	if (nonblock || !READ_ONCE(region->reclaim))
>>> +		return;
>>> +
>>> +	for (int retries = 5; retries > 0; retries--) {
>> Where does 5 come from? This code should retry until no longer above
>> limit, otherwise you'll get some hard to debug issues.
> 
> The memcg controller uses MAX_RECLAIM_RETRIES, although if that fails,
> it will invoke the OOM killer, although if the reclaim callback makes
> progress, it will not consume a retry. Perhaps we should adopt the same
> behaviour except the OOM killer, at least for now. Note that if a
> signal is pending, the reclaim attempt is abandoned both here and in
> memcg.

Yeah, it would be good if we could re-use the same MAX_RECLAIM_RETRIES, so
we will at least know where it's coming from.

Perhaps move it to a slightly more public header. I'm thinking linux/mm.h,
but  perhaps the mm maintainers will prefer another place.

It makes sense to eventually fail on no progress, especially if all remaining
memory is pinned. This can happen when we pin dma-buf for example.

Adding an entire DMEM OOM killer would be interesting, but probably far outside
the scope of dmemcg for the foreseeable future. It's only unfortunate that
we have no way of reporting or logging failure at all right now.

>>> <snip>
> 
> Let me take a look at this.
> /Thomas

Thanks for looking into it.

Kind regards,
~Maarten Lankhorst

