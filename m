Return-Path: <cgroups+bounces-14509-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6DWSCYyipWngCwAAu9opvQ
	(envelope-from <cgroups+bounces-14509-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:45:32 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0A01DB1A4
	for <lists+cgroups@lfdr.de>; Mon, 02 Mar 2026 15:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A37D30036DB
	for <lists+cgroups@lfdr.de>; Mon,  2 Mar 2026 14:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1A83FFAB5;
	Mon,  2 Mar 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2raseDk"
X-Original-To: cgroups@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584FA33DEF7
	for <cgroups@vger.kernel.org>; Mon,  2 Mar 2026 14:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772462348; cv=none; b=G9pGFnOsBabGd2zvkq9BW6fghuJITXInRvMfrhrvF8aVuc2IpItmJGFeeRcMY2WK8ilir3jn5CSS1l9KuQa5tnru9JV+knqpWpj5rbWRyS1hBhzJiAJ/2wbCTe6AK4rYvERLPLwgF91zTnZ/OTLS/og9mw42yEINN/a0naUcuIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772462348; c=relaxed/simple;
	bh=+zp71fvqIJqC3AXbnfXSuCQrsxntFTsXUmp/G0OAMtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ukNpl0e/mb8cZO73s581h6sM0j1OgbFc3hAbnfVB7P/jI7SwtYi0nlg7gfYFDKqd18TjfW6JiNIbB2bR+Zgj+eFQnytZ75wZOzIXp1LcpHKoe+JOWElCfBw2VMyinFH7Oja7yFe2NCeiBnQden6CHBr5Lo6a2HkKSK0LwN/V/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y2raseDk; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772462348; x=1803998348;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+zp71fvqIJqC3AXbnfXSuCQrsxntFTsXUmp/G0OAMtw=;
  b=Y2raseDkfQIkv7+WONGbUYilVfaI8N3TQ15hi77CrMnVtDZn4vVtdOWt
   x9orAO320pzUe8f1gCgQCG4XzB6xFP94TITL54tDrXfsx9Apzkvrzdz8d
   7g0GKfVV2uoW7yzHHTP8kKV/KDlXOV9HvWHj7lnqUka2vsWhkf24nT7Aw
   M5WPPCsBTswyv8VuCYO0iznEy/EjAltvopZ6bkHJPpblvHUtdDFzcJdAX
   vgfB13BpSnVhRkINH5ByvKrrbJjoSZ0SctpxBY2nF+gnP7Pk+LFBgaSRY
   Mg6CH8poQgRmJfTnKf8tsiIl0WJ2NPvGdTQ/9cNCDWP1jjB2cBAk/0/VH
   w==;
X-CSE-ConnectionGUID: HkRpSjiPTnCNLqTPySlMzQ==
X-CSE-MsgGUID: 5nQPUmwIT0CIrfoYI6wfrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="83805758"
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="83805758"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 06:39:07 -0800
X-CSE-ConnectionGUID: aIgv7D2jT6izEBTmifXZvA==
X-CSE-MsgGUID: X9k6OckeQpW08Cxqh6HDuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,320,1763452800"; 
   d="scan'208";a="222172109"
Received: from rvuia-mobl.ger.corp.intel.com (HELO [10.245.244.129]) ([10.245.244.129])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2026 06:39:03 -0800
Message-ID: <c87a99bc-5481-444e-8841-b09d20016cfd@linux.intel.com>
Date: Mon, 2 Mar 2026 15:38:48 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] cgroup,cgroup/dmem: Add
 (dmem_)cgroup_common_ancestor helper
To: Natalie Vock <natalie.vock@gmx.de>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Tvrtko Ursulin <tursulin@ursulin.net>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260302-dmemcg-aggressive-protect-v5-0-ffd3a2602309@gmx.de>
 <20260302-dmemcg-aggressive-protect-v5-2-ffd3a2602309@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
In-Reply-To: <20260302-dmemcg-aggressive-protect-v5-2-ffd3a2602309@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2C0A01DB1A4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-14509-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmx.de,lankhorst.se,kernel.org,cmpxchg.org,suse.com,amd.com,intel.com,suse.de,gmail.com,ffwll.ch,ursulin.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maarten.lankhorst@linux.intel.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,gmx.de:email]
X-Rspamd-Action: no action

Hey,

This should probably have a Co-developed-by: Tejun Heo <tj@kernel.org>

I need to take a closer look at patch 4 and 6, to add my r-b over the rest.

Den 2026-03-02 kl. 13:37, skrev Natalie Vock:
> This helps to find a common subtree of two resources, which is important
> when determining whether it's helpful to evict one resource in favor of
> another.
> 
> To facilitate this, add a common helper to find the ancestor of two
> cgroups using each cgroup's ancestor array.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
> ---
>  include/linux/cgroup.h      | 21 +++++++++++++++++++++
>  include/linux/cgroup_dmem.h |  9 +++++++++
>  kernel/cgroup/dmem.c        | 43 ++++++++++++++++++++++++++++++++++++++++---
>  3 files changed, 70 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index bc892e3b37eea..560ae995e3a54 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -561,6 +561,27 @@ static inline struct cgroup *cgroup_ancestor(struct cgroup *cgrp,
>  	return cgrp->ancestors[ancestor_level];
>  }
>  
> +/**
> + * cgroup_common_ancestor - find common ancestor of two cgroups
> + * @a: first cgroup to find common ancestor of
> + * @b: second cgroup to find common ancestor of
> + *
> + * Find the first cgroup that is an ancestor of both @a and @b, if it exists
> + * and return a pointer to it. If such a cgroup doesn't exist, return NULL.
> + *
> + * This function is safe to call as long as both @a and @b are accessible.
> + */
> +static inline struct cgroup *cgroup_common_ancestor(struct cgroup *a,
> +						    struct cgroup *b)
> +{
> +	int level;
> +
> +	for (level = min(a->level, b->level); level >= 0; level--)
> +		if (a->ancestors[level] == b->ancestors[level])
> +			return a->ancestors[level];
> +	return NULL;
> +}
> +
>  /**
>   * task_under_cgroup_hierarchy - test task's membership of cgroup ancestry
>   * @task: the task to be tested
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index 1a88cd0c9eb00..444b84f4c253a 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -28,6 +28,8 @@ bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
>  			   struct dmem_cgroup_pool_state *test);
>  bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  			   struct dmem_cgroup_pool_state *test);
> +struct dmem_cgroup_pool_state *dmem_cgroup_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							   struct dmem_cgroup_pool_state *b);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>  #else
> @@ -75,6 +77,13 @@ static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  	return false;
>  }
>  
> +static inline
> +struct dmem_cgroup_pool_state *dmem_cgroup_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							   struct dmem_cgroup_pool_state *b)
> +{
> +	return NULL;
> +}
> +
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 28227405f7cfe..a3ba865f4c68f 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -569,11 +569,10 @@ void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  EXPORT_SYMBOL_GPL(dmem_cgroup_pool_state_put);
>  
>  static struct dmem_cgroup_pool_state *
> -get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
> +find_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>  {
> -	struct dmem_cgroup_pool_state *pool, *allocpool = NULL;
> +	struct dmem_cgroup_pool_state *pool;
>  
> -	/* fastpath lookup? */
>  	rcu_read_lock();
>  	pool = find_cg_pool_locked(cg, region);
>  	if (pool && !READ_ONCE(pool->inited))
> @@ -582,6 +581,17 @@ get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
>  		pool = NULL;
>  	rcu_read_unlock();
>  
> +	return pool;
> +}
> +
> +static struct dmem_cgroup_pool_state *
> +get_cg_pool_unlocked(struct dmemcg_state *cg, struct dmem_cgroup_region *region)
> +{
> +	struct dmem_cgroup_pool_state *pool, *allocpool = NULL;
> +
> +	/* fastpath lookup? */
> +	pool = find_cg_pool_unlocked(cg, region);
> +
>  	while (!pool) {
>  		spin_lock(&dmemcg_lock);
>  		if (!region->unregistered)
> @@ -756,6 +766,33 @@ bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
>  
> +/**
> + * dmem_cgroup_common_ancestor(): Find the first common ancestor of two pools.
> + * @a: First pool to find the common ancestor of.
> + * @b: First pool to find the common ancestor of.
> + *
> + * Return: The first pool that is a parent of both @a and @b, or NULL if either @a or @b are NULL,
> + * or if such a pool does not exist.
> + */
> +struct dmem_cgroup_pool_state *dmem_cgroup_common_ancestor(struct dmem_cgroup_pool_state *a,
> +							   struct dmem_cgroup_pool_state *b)
> +{
> +	struct cgroup *ancestor_cgroup;
> +	struct cgroup_subsys_state *ancestor_css;
> +
> +	if (!a || !b)
> +		return NULL;
> +
> +	ancestor_cgroup = cgroup_common_ancestor(a->cs->css.cgroup, b->cs->css.cgroup);
> +	if (!ancestor_cgroup)
> +		return NULL;
> +
> +	ancestor_css = cgroup_e_css(ancestor_cgroup, &dmem_cgrp_subsys);
> +
> +	return find_cg_pool_unlocked(css_to_dmemcs(ancestor_css), a->region);
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_common_ancestor);
From the naming, I would not expect a reference to be taken to the common ancestor, especially because the reference through a and b would both be able keep the ancestor alive. Otherwise it would not be an ancestor. Rename to dmem_cgroup_get_common_ancestor perhaps? Same for the find_, perhaps rename to lookup_ or use the unmodified get_cg_pool_unlocked version, because the common ancestor's pool_state definitely exists if either a or b do.

Kind regards,
~Maarten Lankhorst

