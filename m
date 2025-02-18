Return-Path: <cgroups+bounces-6590-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8E3A3A092
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 15:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C18B8188A7AF
	for <lists+cgroups@lfdr.de>; Tue, 18 Feb 2025 14:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BACC26AA96;
	Tue, 18 Feb 2025 14:55:55 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mblankhorst.nl (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C839A26B0BD
	for <cgroups@vger.kernel.org>; Tue, 18 Feb 2025 14:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739890555; cv=none; b=M3cl7wY6jTMzn+jpn1gi2JKiRj/xv+YUFxe7mSqK90Luwqa765HttQKGc6vfbsSYlKVNfsxy7Wx8C5pBZKaDPgvBP1w/RN8ymyvMHhE08pCcQf6+Exw5r+100upYWCUvWQbUrXKgznD65RaGvAZ+E/SvWvw1E/TLFl+h1AyuO+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739890555; c=relaxed/simple;
	bh=jUZGPX0Zf9M3kdAh8MTtYa/+ZuFaFbcNgqFNOSnnnZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EbW5Y/zczFQs1dl4T2sEYcGqza3FUYySg+4xK/vYp7ABMUGUSmEaiWY2Gz5TKk2KrVJQ9Gk3o/KR41KDOP0+lxdyx5QZfK4LcMyO2pyA0bQAOpEimcYCRjYioCHejJ+vAupGhldUtXC82QMbHLvMibSCY/pnGeufTf3fRmcckt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se; spf=none smtp.mailfrom=lankhorst.se; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=lankhorst.se
Message-ID: <7f799ba1-3776-49bd-8a53-dc409ef2afe3@lankhorst.se>
Date: Tue, 18 Feb 2025 15:55:43 +0100
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

Should this fix go through the cgroup tree?

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


