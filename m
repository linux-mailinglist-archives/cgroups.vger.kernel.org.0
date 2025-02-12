Return-Path: <cgroups+bounces-6516-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0958A3215C
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 09:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D4E188670E
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2025 08:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1984020551A;
	Wed, 12 Feb 2025 08:40:30 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336F7204C00
	for <cgroups@vger.kernel.org>; Wed, 12 Feb 2025 08:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739349629; cv=none; b=GxSCtNfb5SxYnPmayDvsqr0sZztTkvRxmF4fidDoCKZMpS12NGE78lj+Y8bp7LRPSKLznYyq6I1LSEpP/JznoPlYPY1CBsZ/MKUnuKG3bDlHzto4WxAeO/b1smgKT5TiyvVeeuM74o6eKS52q5NyaBTFS452Vb6Sjml8Kg2OBuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739349629; c=relaxed/simple;
	bh=cBD0k2U3YfYupM/n3qgSfSy19TWNpwagEKBNxf6CqiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQ2JBPGR5halwg3dfI3SyCnz+D5tGFF7F6nVDwJbPyh/gtIGQq45aV+1WxXpX/hyjTF9sur0JwRt811TyzKdWp5XHwTBTqtM8UllFJ7pmyfqAiipYBtVkE+b80Xp7KRlf/ojWENDYv9ClaNAB9yGrV+7CYMZgKrbR4KVHuzN0Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <0ea22cc5-18c2-4de4-b06e-533ad4fae20f@lankhorst.se>
Date: Wed, 12 Feb 2025 09:40:17 +0100
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cgroup/dmem: Don't open-code
 css_for_each_descendant_pre
To: Friedrich Vock <friedrich.vock@gmx.de>, Tejun Heo <tj@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Simona Vetter <simona.vetter@ffwll.ch>,
 David Airlie <airlied@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, dri-devel@lists.freedesktop.org,
 cgroups@vger.kernel.org
References: <20250114153912.278909-1-friedrich.vock@gmx.de>
 <20250127152754.21325-1-friedrich.vock@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20250127152754.21325-1-friedrich.vock@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey,

I was hoping someone else would look at it, but it seems not.

This patch appears to work on my system, it would be helpful if I could 
get the exact sequence failing to write a reproducer, but I don't want 
to hold up a bugfix because of it.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>

Should I send this through the drm-misc-fixes tree?

Cheers,
~Maarten

On 2025-01-27 16:27, Friedrich Vock wrote:
> The current implementation has a bug: If the current css doesn't
> contain any pool that is a descendant of the "pool" (i.e. when
> found_descendant == false), then "pool" will point to some unrelated
> pool. If the current css has a child, we'll overwrite parent_pool with
> this unrelated pool on the next iteration.
> 
> Since we can just check whether a pool refers to the same region to
> determine whether or not it's related, all the additional pool tracking
> is unnecessary, so just switch to using css_for_each_descendant_pre for
> traversal.
> 
> Fixes: b168ed458 ("kernel/cgroup: Add "dmem" memory accounting cgroup")
> Signed-off-by: Friedrich Vock <friedrich.vock@gmx.de>
> ---
> 
> v2 (Michal): Switch to the more idiomatic css_for_each_descendant_pre
> instead of fixing the open-coded version
> 
> ---
>   kernel/cgroup/dmem.c | 50 ++++++++++----------------------------------
>   1 file changed, 11 insertions(+), 39 deletions(-)
> 
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 52736ef0ccf2..77d9bb1c147f 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -220,60 +220,32 @@ dmem_cgroup_calculate_protection(struct dmem_cgroup_pool_state *limit_pool,
>   				 struct dmem_cgroup_pool_state *test_pool)
>   {
>   	struct page_counter *climit;
> -	struct cgroup_subsys_state *css, *next_css;
> +	struct cgroup_subsys_state *css;
>   	struct dmemcg_state *dmemcg_iter;
> -	struct dmem_cgroup_pool_state *pool, *parent_pool;
> -	bool found_descendant;
> +	struct dmem_cgroup_pool_state *pool, *found_pool;
> 
>   	climit = &limit_pool->cnt;
> 
>   	rcu_read_lock();
> -	parent_pool = pool = limit_pool;
> -	css = &limit_pool->cs->css;
> 
> -	/*
> -	 * This logic is roughly equivalent to css_foreach_descendant_pre,
> -	 * except we also track the parent pool to find out which pool we need
> -	 * to calculate protection values for.
> -	 *
> -	 * We can stop the traversal once we find test_pool among the
> -	 * descendants since we don't really care about any others.
> -	 */
> -	while (pool != test_pool) {
> -		next_css = css_next_child(NULL, css);
> -		if (next_css) {
> -			parent_pool = pool;
> -		} else {
> -			while (css != &limit_pool->cs->css) {
> -				next_css = css_next_child(css, css->parent);
> -				if (next_css)
> -					break;
> -				css = css->parent;
> -				parent_pool = pool_parent(parent_pool);
> -			}
> -			/*
> -			 * We can only hit this when test_pool is not a
> -			 * descendant of limit_pool.
> -			 */
> -			if (WARN_ON_ONCE(css == &limit_pool->cs->css))
> -				break;
> -		}
> -		css = next_css;
> -
> -		found_descendant = false;
> +	css_for_each_descendant_pre(css, &limit_pool->cs->css) {
>   		dmemcg_iter = container_of(css, struct dmemcg_state, css);
> +		found_pool = NULL;
> 
>   		list_for_each_entry_rcu(pool, &dmemcg_iter->pools, css_node) {
> -			if (pool_parent(pool) == parent_pool) {
> -				found_descendant = true;
> +			if (pool->region == limit_pool->region) {
> +				found_pool = pool;
>   				break;
>   			}
>   		}
> -		if (!found_descendant)
> +		if (!found_pool)
>   			continue;
> 
>   		page_counter_calculate_protection(
> -			climit, &pool->cnt, true);
> +			climit, &found_pool->cnt, true);
> +
> +		if (found_pool == test_pool)
> +			break;
>   	}
>   	rcu_read_unlock();
>   }
> --
> 2.48.0
> 


