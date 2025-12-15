Return-Path: <cgroups+bounces-12354-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 58F36CBCCBB
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 08:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED213015A92
	for <lists+cgroups@lfdr.de>; Mon, 15 Dec 2025 07:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2923631AF2A;
	Mon, 15 Dec 2025 07:38:28 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C20B32861F;
	Mon, 15 Dec 2025 07:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765784307; cv=none; b=aBLHzf8MdQI9GUFHB/B9IXZ3KNouz2D+QO/sl0gdNQgM7CZappGOfCJtAcQ7W9K1rG03+aX2hb0hw2M/HLvnm+l3S+nMpIXgGfs2R3tG8QQxBC9NQqWUrMWc1qKt0S5J2kKyWFeJuZtrnWnu6aRzxrRHxo4S+99m7xc8Uf3CiYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765784307; c=relaxed/simple;
	bh=f8ES+mGhbxJnpdwQlSnH3S4WMOKAQPFUTR9oaGQ4OYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nLA9jCezObc1uYZvnzGgJNWdNVC/6J7Scv+ibPpe/0ZKc7zVl1SRZb8F9L9YNsIaqHHyA8s6pG3+ICQS5sbOuB58+ff7mzdFRK8ts4vK8lW5oRA/eoxNbn8kWOsiXQSfumHg30441SpqIdjth61pWQMpbYEv6uzp/ZEvw7voOMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dVBkH4ldJzKHMWZ;
	Mon, 15 Dec 2025 15:38:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 641691A14A1;
	Mon, 15 Dec 2025 15:38:21 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP1 (Coremail) with SMTP id cCh0CgBHtOnpuj9pnAsAAQ--.24033S2;
	Mon, 15 Dec 2025 15:38:18 +0800 (CST)
Message-ID: <3edf7d6a-5e32-45f1-a6fc-ca5ca786551b@huaweicloud.com>
Date: Mon, 15 Dec 2025 15:38:16 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] mm/memcontrol: make lru_zone_size atomic and simplify
 sanity check
To: Kairui Song <ryncsn@gmail.com>, linux-mm@kvack.org,
 Johannes Weiner <hannes@cmpxchg.org>, Hugh Dickins <hughd@google.com>,
 Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Kairui Song <kasong@tencent.com>
References: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251215-mz-lru-size-cleanup-v1-1-95deb4d5e90f@tencent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBHtOnpuj9pnAsAAQ--.24033S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF48Xr1ktw1DXw17KryxAFb_yoWrCr4rpF
	ZIka40yFZ5ZryY93sFya1Dua4fZa1xKayfJr9rWw1UAr1aq3Zaq34UKr4fuFWUAr95GF4a
	qF90gFW8C3yYvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1
	7KsUUUUUU==
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/12/15 14:45, Kairui Song wrote:
> From: Kairui Song <kasong@tencent.com>
> 
> commit ca707239e8a7 ("mm: update_lru_size warn and reset bad lru_size")
> introduced a sanity check to catch memcg counter underflow, which is
> more like a workaround for another bug: lru_zone_size is unsigned, so
> underflow will wrap it around and return an enormously large number,
> then the memcg shrinker will loop almost forever as the calculated
> number of folios to shrink is huge. That commit also checks if a zero
> value matches the empty LRU list, so we have to hold the LRU lock, and
> do the counter adding differently depending on whether the nr_pages is
> negative.
> 
> But later commit b4536f0c829c ("mm, memcg: fix the active list aging for
> lowmem requests when memcg is enabled") already removed the LRU
> emptiness check, doing the adding differently is meaningless now. And if

Agree.

I did submit a patch to address that, but it was not accepted.

For reference, here is the link to the discussion:

https://lore.kernel.org/lkml/CAOUHufbCCkOBGcSPZqNY+FXcrH8+U7_nRvftzOzKUBS4hn+kuQ@mail.gmail.com/

> we just turn it into an atomic long, underflow isn't a big issue either,
> and can be checked at the reader side. The reader size is much less
> frequently called than the updater.
> 
> So let's turn the counter into an atomic long and check at the
> reader side instead, which has a smaller overhead. Use atomic to avoid
> potential locking issue. The underflow correction is removed, which
> should be fine as if there is a mass leaking of the LRU size counter,
> something else may also have gone very wrong, and one should fix that
> leaking site instead.
> 
> For now still keep the LRU lock context, in thoery that can be removed
> too since the update is atomic, if we can tolerate a temporary
> inaccurate reading, but currently there is no benefit doing so yet.
> 
> Signed-off-by: Kairui Song <kasong@tencent.com>
> ---
>  include/linux/memcontrol.h |  9 +++++++--
>  mm/memcontrol.c            | 18 +-----------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 0651865a4564..197f48faa8ba 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -112,7 +112,7 @@ struct mem_cgroup_per_node {
>  	/* Fields which get updated often at the end. */
>  	struct lruvec		lruvec;
>  	CACHELINE_PADDING(_pad2_);
> -	unsigned long		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
> +	atomic_long_t		lru_zone_size[MAX_NR_ZONES][NR_LRU_LISTS];
>  	struct mem_cgroup_reclaim_iter	iter;
>  
>  #ifdef CONFIG_MEMCG_NMI_SAFETY_REQUIRES_ATOMIC
> @@ -903,10 +903,15 @@ static inline
>  unsigned long mem_cgroup_get_zone_lru_size(struct lruvec *lruvec,
>  		enum lru_list lru, int zone_idx)
>  {
> +	long val;
>  	struct mem_cgroup_per_node *mz;
>  
>  	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	return READ_ONCE(mz->lru_zone_size[zone_idx][lru]);
> +	val = atomic_long_read(&mz->lru_zone_size[zone_idx][lru]);
> +	if (WARN_ON_ONCE(val < 0))
> +		return 0;
> +
> +	return val;
>  }
>  
>  void __mem_cgroup_handle_over_high(gfp_t gfp_mask);
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 9b07db2cb232..d5da09fbe43e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1273,28 +1273,12 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>  				int zid, int nr_pages)
>  {
>  	struct mem_cgroup_per_node *mz;
> -	unsigned long *lru_size;
> -	long size;
>  
>  	if (mem_cgroup_disabled())
>  		return;
>  
>  	mz = container_of(lruvec, struct mem_cgroup_per_node, lruvec);
> -	lru_size = &mz->lru_zone_size[zid][lru];
> -
> -	if (nr_pages < 0)
> -		*lru_size += nr_pages;
> -
> -	size = *lru_size;
> -	if (WARN_ONCE(size < 0,
> -		"%s(%p, %d, %d): lru_size %ld\n",
> -		__func__, lruvec, lru, nr_pages, size)) {
> -		VM_BUG_ON(1);
> -		*lru_size = 0;
> -	}
> -
> -	if (nr_pages > 0)
> -		*lru_size += nr_pages;
> +	atomic_long_add(nr_pages, &mz->lru_zone_size[zid][lru]);
>  }
>  
>  /**
> 
> ---
> base-commit: 1ef4e3be45a85a103a667cc39fd68c3826e6acb9
> change-id: 20251211-mz-lru-size-cleanup-c81deccfd5d7
> 
> Best regards,

-- 
Best regards,
Ridong


