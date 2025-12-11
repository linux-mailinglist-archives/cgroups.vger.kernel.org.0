Return-Path: <cgroups+bounces-12334-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F8FACB55DE
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 10:35:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 674623009AA0
	for <lists+cgroups@lfdr.de>; Thu, 11 Dec 2025 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE802F6183;
	Thu, 11 Dec 2025 09:35:25 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4C082E1C6F;
	Thu, 11 Dec 2025 09:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765445725; cv=none; b=ZMcGVDTHNMMdVIIJKhhhLjxwglwoSOkduA396J1eolOWbQvs+SiwDHXYJwoFej9ZUHCnk77WmR2xhaJU7UcHMS8UZmfqYFjN1NlITsYrLyc7IgFwgibIOG3dxLhrt1RhigfWsAoNoP4vU5Afx+xyT2rSmEbpSk60dgvLX8nPHZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765445725; c=relaxed/simple;
	bh=v5SWI7QtBUEEyJYgyzBcFqRJvljNAaAUv3rJXJjPwXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnde747/T88U5bWyC4glPVOFH9+gA5D4tT4Kw6XmahwoVr2lHp7jXm70B+2bXnUa5AsDvF1bcO3ebtGkcGhf27qyR/GHqhAzlGNae+QAv8y0untU/r8WK6t+V4FplW2e+YIR8pKBSqvrBZkSGddle+NPt9sw7HVRR79YFTKpgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C8FB153B;
	Thu, 11 Dec 2025 01:35:15 -0800 (PST)
Received: from [10.163.80.88] (unknown [10.163.80.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3AB273F740;
	Thu, 11 Dec 2025 01:35:18 -0800 (PST)
Message-ID: <49d00536-bf7b-4bc2-b771-c708f36f9407@arm.com>
Date: Thu, 11 Dec 2025 15:05:15 +0530
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm: memcontrol: rename mem_cgroup_from_slab_obj()
To: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Michal Hocko <mhocko@suse.com>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 linux-mm@kvack.org, cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251210154301.720133-1-hannes@cmpxchg.org>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20251210154301.720133-1-hannes@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/12/25 9:13 PM, Johannes Weiner wrote:
> In addition to slab objects, this function is used for resolving
> non-slab kernel pointers. This has caused confusion in recent
> refactoring work. Rename it to mem_cgroup_from_virt(), sticking with
> terminology established by the virt_to_<foo>() converters.
> 
> Link: https://lore.kernel.org/linux-mm/20251113161424.GB3465062@cmpxchg.org/
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/memcontrol.h | 4 ++--
>  mm/list_lru.c              | 4 ++--
>  mm/memcontrol.c            | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0651865a4564..17ad5cf43129 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1727,7 +1727,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
>  	return memcg ? memcg->kmemcg_id : -1;
>  }
>  
> -struct mem_cgroup *mem_cgroup_from_slab_obj(void *p);
> +struct mem_cgroup *mem_cgroup_from_virt(void *p);
>  
>  static inline void count_objcg_events(struct obj_cgroup *objcg,
>  				      enum vm_event_item idx,
> @@ -1799,7 +1799,7 @@ static inline int memcg_kmem_id(struct mem_cgroup *memcg)
>  	return -1;
>  }
>  
> -static inline struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +static inline struct mem_cgroup *mem_cgroup_from_virt(void *p)
>  {
>  	return NULL;
>  }
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index ec48b5dadf51..37b642f6cbda 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -187,7 +187,7 @@ bool list_lru_add_obj(struct list_lru *lru, struct list_head *item)
>  
>  	if (list_lru_memcg_aware(lru)) {
>  		rcu_read_lock();
> -		ret = list_lru_add(lru, item, nid, mem_cgroup_from_slab_obj(item));
> +		ret = list_lru_add(lru, item, nid, mem_cgroup_from_virt(item));
>  		rcu_read_unlock();
>  	} else {
>  		ret = list_lru_add(lru, item, nid, NULL);
> @@ -224,7 +224,7 @@ bool list_lru_del_obj(struct list_lru *lru, struct list_head *item)
>  
>  	if (list_lru_memcg_aware(lru)) {
>  		rcu_read_lock();
> -		ret = list_lru_del(lru, item, nid, mem_cgroup_from_slab_obj(item));
> +		ret = list_lru_del(lru, item, nid, mem_cgroup_from_virt(item));
>  		rcu_read_unlock();
>  	} else {
>  		ret = list_lru_del(lru, item, nid, NULL);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index be810c1fbfc3..e552072e346c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -806,7 +806,7 @@ void mod_lruvec_kmem_state(void *p, enum node_stat_item idx, int val)
>  	struct lruvec *lruvec;
>  
>  	rcu_read_lock();
> -	memcg = mem_cgroup_from_slab_obj(p);
> +	memcg = mem_cgroup_from_virt(p);
>  
>  	/*
>  	 * Untracked pages have no memcg, no lruvec. Update only the
> @@ -2619,7 +2619,7 @@ struct mem_cgroup *mem_cgroup_from_obj_slab(struct slab *slab, void *p)
>   * The caller must ensure the memcg lifetime, e.g. by taking rcu_read_lock(),
>   * cgroup_mutex, etc.
>   */
> -struct mem_cgroup *mem_cgroup_from_slab_obj(void *p)
> +struct mem_cgroup *mem_cgroup_from_virt(void *p)
>  {
>  	struct slab *slab;
> 

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>


