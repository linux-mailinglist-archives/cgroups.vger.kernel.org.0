Return-Path: <cgroups+bounces-11141-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EF5CC0613C
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 13:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E50A7188B985
	for <lists+cgroups@lfdr.de>; Fri, 24 Oct 2025 11:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29102580F0;
	Fri, 24 Oct 2025 11:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b="GnG7EPb+"
X-Original-To: cgroups@vger.kernel.org
Received: from lankhorst.se (lankhorst.se [141.105.120.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F067B30ACE8
	for <cgroups@vger.kernel.org>; Fri, 24 Oct 2025 11:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.105.120.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761306277; cv=none; b=LU5DYYHu4XYm/58r/6NsVBs64igeHvgumkZGwkJgCjbe1wWMIRtlyjpqy/SYQR7kbxIOGhQJgMAP3yCH3pLuIbaz/oIVQDjLn4shBJIGJHlcylaCsHUemuGGNkSAZ2yiNHFUcBRZVPpp4eClF8Qbip70ZbKtEBUsytd5VndOWIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761306277; c=relaxed/simple;
	bh=nThNGbn396MUk+fscta05g9tCvShMWDdvTs92xblY9c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+yr2d9xuhsmzUT5+VTMRgI8hMRUCdXe5uNy155wGlmBkLP7iTvJBH2N+yTDo96RSWx2reOZIjJhwUDfb8CPV/UqTi5//m6Kqyq9dHfclI4J7efZB49CfDQDB2EDU96rMJuJ9ha/D5ZVL5IjwLmnbIryy3rrWJoDu0eRqhbwqIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se; spf=pass smtp.mailfrom=lankhorst.se; dkim=pass (2048-bit key) header.d=lankhorst.se header.i=@lankhorst.se header.b=GnG7EPb+; arc=none smtp.client-ip=141.105.120.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lankhorst.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lankhorst.se
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lankhorst.se;
	s=default; t=1761306272;
	bh=nThNGbn396MUk+fscta05g9tCvShMWDdvTs92xblY9c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GnG7EPb+q90YSGS3/gRp6UVuCsywY6uWHsvMZwwX61mAgo3Zv2+1o5O34+hH/zhHL
	 zdx7JE1f9FjwrLfJMkZ7ldpU6r2PUN7HohHbaukYW2s3VAiI/gqK7ry5icVxoHQHSn
	 YcCjFnldOo15YLfymHsIo1gbPXKxcq+SXVk44Tp6T71S0Ips62b5FvGISytCULbxOo
	 b45XzH2FMbF3mveWkdgrvqK/XmfUq2do7IKjDHitF39TABQMVH5G+khAYupeEI17zY
	 R/hMpv9BFUdUT71JP1+sV9r2sDSeaf3Ktjyvn+B7ddi+4EgK1l3pbMWiC7AYd700ck
	 uBo7vxLykNnIw==
Message-ID: <4f425860-1a43-443a-8b34-3fdd75bb9168@lankhorst.se>
Date: Fri, 24 Oct 2025 13:44:31 +0200
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] cgroup/dmem: Add queries for protection values
To: Natalie Vock <natalie.vock@gmx.de>, Maxime Ripard <mripard@kernel.org>,
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
 =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: cgroups@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20251015-dmemcg-aggressive-protect-v2-0-36644fb4e37f@gmx.de>
 <20251015-dmemcg-aggressive-protect-v2-1-36644fb4e37f@gmx.de>
Content-Language: en-US
From: Maarten Lankhorst <dev@lankhorst.se>
In-Reply-To: <20251015-dmemcg-aggressive-protect-v2-1-36644fb4e37f@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hey,

Den 2025-10-15 kl. 15:57, skrev Natalie Vock:
> Callers can use this feedback to be more aggressive in making space for
> allocations of a cgroup if they know it is protected.
> 
> These are counterparts to memcg's mem_cgroup_below_{min,low}.
> 
> Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
It could be useful to document why we are calculating protection here,
since memcg doesn't do that in their functions.

> ---
>  include/linux/cgroup_dmem.h | 16 +++++++++++++++
>  kernel/cgroup/dmem.c        | 48 +++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
> 
> diff --git a/include/linux/cgroup_dmem.h b/include/linux/cgroup_dmem.h
> index dd4869f1d736e26847578e81377e40504bbba90f..1a88cd0c9eb00409ddd07d1f06eb63d2e55e8805 100644
> --- a/include/linux/cgroup_dmem.h
> +++ b/include/linux/cgroup_dmem.h
> @@ -24,6 +24,10 @@ void dmem_cgroup_uncharge(struct dmem_cgroup_pool_state *pool, u64 size);
>  bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  				      struct dmem_cgroup_pool_state *test_pool,
>  				      bool ignore_low, bool *ret_hit_low);
> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test);
> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test);
>  
>  void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool);
>  #else
> @@ -59,6 +63,18 @@ bool dmem_cgroup_state_evict_valuable(struct dmem_cgroup_pool_state *limit_pool,
>  	return true;
>  }
>  
> +static inline bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
> +					 struct dmem_cgroup_pool_state *test)
> +{
> +	return false;
> +}
> +
> +static inline bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
> +					 struct dmem_cgroup_pool_state *test)
> +{
> +	return false;
> +}
> +
>  static inline void dmem_cgroup_pool_state_put(struct dmem_cgroup_pool_state *pool)
>  { }
>  
> diff --git a/kernel/cgroup/dmem.c b/kernel/cgroup/dmem.c
> index 10b63433f05737cc43a87029f2306147283a77ff..ece23f77f197f1b2da3ee322ff176460801907c6 100644
> --- a/kernel/cgroup/dmem.c
> +++ b/kernel/cgroup/dmem.c
> @@ -641,6 +641,54 @@ int dmem_cgroup_try_charge(struct dmem_cgroup_region *region, u64 size,
>  }
>  EXPORT_SYMBOL_GPL(dmem_cgroup_try_charge);
>  
> +/**
> + * dmem_cgroup_below_min() - Tests whether current usage is within min limit.
> + *
> + * @root: Root of the subtree to calculate protection for, or NULL to calculate global protection.
> + * @test: The pool to test the usage/min limit of.
> + *
> + * Return: true if usage is below min and the cgroup is protected, false otherwise.
> + */
> +bool dmem_cgroup_below_min(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test)
> +{
> +	if (root == test || !pool_parent(test))
> +		return false;
> +
> +	if (!root) {
> +		for (root = test; pool_parent(root); root = pool_parent(root))
> +			{}
> +	}
> +
> +	dmem_cgroup_calculate_protection(root, test);
> +	return page_counter_read(&test->cnt) <= READ_ONCE(test->cnt.emin);
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_min);
> +
> +/**
> + * dmem_cgroup_below_low() - Tests whether current usage is within low limit.
> + *
> + * @root: Root of the subtree to calculate protection for, or NULL to calculate global protection.
> + * @test: The pool to test the usage/low limit of.
> + *
> + * Return: true if usage is below low and the cgroup is protected, false otherwise.
> + */
> +bool dmem_cgroup_below_low(struct dmem_cgroup_pool_state *root,
> +			   struct dmem_cgroup_pool_state *test)
> +{
> +	if (root == test || !pool_parent(test))
> +		return false;
> +
> +	if (!root) {
> +		for (root = test; pool_parent(root); root = pool_parent(root))
> +			{}
> +	}
> +
> +	dmem_cgroup_calculate_protection(root, test);
> +	return page_counter_read(&test->cnt) <= READ_ONCE(test->cnt.elow);
> +}
> +EXPORT_SYMBOL_GPL(dmem_cgroup_below_low);
> +
>  static int dmem_cgroup_region_capacity_show(struct seq_file *sf, void *v)
>  {
>  	struct dmem_cgroup_region *region;
> 

Kind regards,
~Maarten lankhorst

